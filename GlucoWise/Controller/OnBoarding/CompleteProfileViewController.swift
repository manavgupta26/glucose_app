import UIKit

class CompleteProfileViewController: UIViewController, UITextFieldDelegate {
    
    let genderOptions = ["Male", "Female"]
    var genderPicker: UIPickerView!
    var datePicker: UIDatePicker!
    var toolbar: UIToolbar!
    
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGenderPicker()
        setupDatePicker()
        setupKeyboardDismissGesture()
        setupTextFieldDelegates()
    }
    
    // MARK: - Gender Picker Setup
    func setupGenderPicker() {
        genderPicker = UIPickerView()
        genderPicker.delegate = self
        genderPicker.dataSource = self
        
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(genderDoneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        genderTextField.inputView = genderPicker
        genderTextField.inputAccessoryView = toolbar
    }
    
    @objc func genderDoneButtonTapped() {
        let selectedRow = genderPicker.selectedRow(inComponent: 0)
        genderTextField.text = genderOptions[selectedRow]
        genderTextField.resignFirstResponder()
    }
    
    // MARK: - Date Picker Setup
    func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date() // Prevents selecting future dates
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dateDoneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        dobTextField.inputView = datePicker
        dobTextField.inputAccessoryView = toolbar
    }
    
    @objc func dateDoneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // Format: Jan 19, 2025
        dobTextField.text = formatter.string(from: datePicker.date)
        dobTextField.resignFirstResponder()
    }
    
    // MARK: - Dismiss Keyboard
    func setupKeyboardDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true) // Dismiss the keyboard
    }
    
    func setupTextFieldDelegates() {
        heightTextField.delegate = self
        weightTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
    
    // MARK: - Register Button Action
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let gender = genderTextField.text, !gender.isEmpty else {
            showAlert(message: "Please select your gender.")
            return
        }
        
        guard let dob = dobTextField.text, !dob.isEmpty else {
            showAlert(message: "Please select your date of birth.")
            return
        }
        
        guard isValidAge() else {
            showAlert(message: "You must be at least 16 years old to register.")
            return
        }
        
        guard let heightText = heightTextField.text, !heightText.isEmpty, let height = Double(heightText), height >= 140 else {
            showAlert(message: "Please enter a valid height (at least 140 cm).")
            return
        }
        
        guard let weightText = weightTextField.text, !weightText.isEmpty, let weight = Double(weightText), weight >= 40 else {
            showAlert(message: "Please enter a valid weight (at least 40 kg).")
            return
        }
        
        self.performSegue(withIdentifier: "howActive", sender: self)
    }
    
    // MARK: - Validation Helpers
    private func isValidAge() -> Bool {
        let calendar = Calendar.current
        let today = Date()
        let birthDate = datePicker.date
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: today)
        if let age = ageComponents.year, age >= 16 {
            return true
        }
        return false
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UIPickerView Delegate and DataSource
extension CompleteProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderOptions[row]
    }
}
