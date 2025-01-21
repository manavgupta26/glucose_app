import UIKit

class EnterLastReadingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!  // Connect your text field here
    @IBOutlet weak var skipButton: UIBarButtonItem!  // Connect your skip button here
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the initial button title
        skipButton.title = "Skip"
        
        // Set the delegate for the text field
        textField.delegate = self
        
        // Add target to detect text changes in the text field
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    // Action for when the text field value changes
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            // If text field is empty, set skip button to "Skip"
            skipButton.title = "Skip"
        } else {
            // If text field has text, set skip button to "Done"
            skipButton.title = "Done"
        }
    }
    
    // Ensure only numeric input is allowed in the text field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Allow backspace
        if string.isEmpty {
            return true
        }
        
        // Check if the replacement string contains only numeric characters
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        // Pop the view controller when back button is tapped
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func skipButtonPressed(_ sender: UIBarButtonItem) {
        // Perform the segue regardless of the button's title
        self.performSegue(withIdentifier: "goalSet", sender: self)
    }
}
