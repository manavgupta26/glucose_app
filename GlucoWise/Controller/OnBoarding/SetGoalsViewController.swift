import UIKit

class SetGoalsViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    // You can add more outlets if you have more text fields.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial values for the text fields
        textField1.text = "170"
        textField2.text = "120"
        textField3.text = "6"
        textField4.text = "145"
    }

    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        // Pop the view controller when back button is tapped
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func incrementButtonTapped1(_ sender: UIButton) {
        incrementTextFieldValue(textField: textField1)
    }
    
    @IBAction func decrementButtonTapped1(_ sender: UIButton) {
        decrementTextFieldValue(textField: textField1)
    }
    
    @IBAction func incrementButtonTapped2(_ sender: UIButton) {
        incrementTextFieldValue(textField: textField2)
    }
    
    @IBAction func decrementButtonTapped2(_ sender: UIButton) {
        decrementTextFieldValue(textField: textField2)
    }
    
    @IBAction func incrementButtonTapped3(_ sender: UIButton) {
        incrementTextFieldValue(textField: textField3)
    }
    
    @IBAction func decrementButtonTapped3(_ sender: UIButton) {
        decrementTextFieldValue(textField: textField3)
    }
    
    @IBAction func incrementButtonTapped4(_ sender: UIButton) {
        incrementTextFieldValue(textField: textField4)
    }
    
    @IBAction func decrementButtonTapped4(_ sender: UIButton) {
        decrementTextFieldValue(textField: textField4)
    }
    
    // MARK: - Helper Functions to Increment and Decrement
    
    private func incrementTextFieldValue(textField: UITextField) {
        if let currentValue = Int(textField.text ?? "0") {
            textField.text = String(currentValue + 1)
        }
    }

    private func decrementTextFieldValue(textField: UITextField) {
        if let currentValue = Int(textField.text ?? "0"), currentValue > 0 {
            textField.text = String(currentValue - 1)
        }
    }
    
    
    @IBAction func nextBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "tabb")
            vc2.modalPresentationStyle = .fullScreen
            self.present(vc2, animated: true)
    }
    
    
    }


