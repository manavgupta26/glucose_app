//
//  firstmodallyscreenViewController.swift
//  GlucoWise
//
//  Created by student-2 on 12/12/24.
//

import UIKit

class firstmodallyscreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func continueBtnPressed(_ sender: UIButton) {
        // Mark the modal screen as shown
        UserDefaults.standard.set(true, forKey: "hasShownFirstModalScreen")
        print("Modal screen shown. Flag updated.") // Debug log

        self.dismiss(animated: true, completion: nil)
    }
}
