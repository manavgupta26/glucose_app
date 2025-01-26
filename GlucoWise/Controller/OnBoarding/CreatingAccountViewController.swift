//
//  CreatingAccountViewController.swift
//  GlucoWise
//
//  Created by student-2 on 12/12/24.
//

import UIKit

class CreatingAccountViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var namefield: UITextField!
    @IBOutlet var emailfield: UITextField!
    @IBOutlet var pwfield: UITextField!
    @IBOutlet var confirmpwfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        // Add gesture recognizer to dismiss the keyboard when tapping outside
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        // Set the text field delegates to self
        namefield.delegate = self
        emailfield.delegate = self
        pwfield.delegate = self
        confirmpwfield.delegate = self
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true) // Dismiss the keyboard
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "showModal", sender: self)
    }
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        if validateFields() {
            // Proceed to the next screen if all fields are valid
            self.performSegue(withIdentifier: "completeProfile", sender: self)
        }
    }
    
    @IBAction func alreadyHaveTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginScreen", sender: self)
    }
    
    // Function to validate all fields
    private func validateFields() -> Bool {
        guard let name = namefield.text, !name.isEmpty else {
            showAlert(message: "Name field is required.")
            return false
        }
        
        guard let email = emailfield.text, !email.isEmpty, isValidEmail(email) else {
            showAlert(message: "Please enter a valid email address.")
            return false
        }
        
        guard let password = pwfield.text, !password.isEmpty else {
            showAlert(message: "Password field is required.")
            return false
        }
        
        guard isValidPassword(password) else {
            showAlert(message: "Password must be at least 5 characters long and contain at least one special symbol.")
            return false
        }
        
        guard let confirmPassword = confirmpwfield.text, confirmPassword == password else {
            showAlert(message: "Passwords do not match.")
            return false
        }
        
        return true
    }
    
    // Function to display an alert
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Function to validate email format
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
    }
    
    // Function to validate password rules
    private func isValidPassword(_ password: String) -> Bool {
        let specialCharacterRegex = ".*[!@#$%^&*(),.?\":{}|<>].*"
        let passwordLengthRule = password.count >= 5
        let containsSpecialCharacter = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegex).evaluate(with: password)
        return passwordLengthRule && containsSpecialCharacter
    }
    
    // UITextFieldDelegate method to handle return button
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}
