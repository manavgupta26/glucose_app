//
//  creatinAccountViewController.swift
//  GlucoWise
//
//  Created by student-2 on 12/12/24.
//

import UIKit

class creatinAccountViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performSegue(withIdentifier: "showModal", sender: self)
    }

}
