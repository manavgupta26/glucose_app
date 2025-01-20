//
//  creatinAccountViewController.swift
//  GlucoWise
//
//  Created by student-2 on 12/12/24.
//

import UIKit

class creatinAccountViewController: UIViewController {
    
    
    @IBOutlet var namefield: UITextField!
    @IBOutlet var emailfield: UITextField!
    @IBOutlet var pwfield: UITextField!
    @IBOutlet var confirmpwfield: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "showModal", sender: self)
    }
    
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "completeProfile", sender: self)
    }
    
    @IBAction func alreadyHaveTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "loginScreen", sender: self)
    }
    
    
}
