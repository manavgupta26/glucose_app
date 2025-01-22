//
//  WelcomeViewController.swift
//  GlucoWise
//
//  Created by Sehdev Saini on 20/01/25.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        // Check and present modal screen only if it hasn't been shown
        let hasShownFirstModal = UserDefaults.standard.bool(forKey: "hasShownFirstModalScreen")
        print("Has shown first modal: \(hasShownFirstModal)") // Debug log

        if !hasShownFirstModal {
            showFirstModalScreen()
        }
    }
    
    @IBAction func createAccountPressed(_ sender: UIButton) {
        // Initialize the Create Account page
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name if different
        if let createAccountVC = storyboard.instantiateViewController(withIdentifier: "createAccount") as? CreatingAccountViewController {
            // Push the Create Account page onto the navigation stack
            self.navigationController?.pushViewController(createAccountVC, animated: true)
        }
    }
    
    private func showFirstModalScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let firstModalVC = storyboard.instantiateViewController(withIdentifier: "firstmodallyscreenViewController") as? firstmodallyscreenViewController {
            self.present(firstModalVC, animated: true, completion: nil)
        }
    }
}
