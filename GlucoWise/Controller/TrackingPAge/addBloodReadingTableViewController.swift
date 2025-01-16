//
//  addBloodReadingTableViewController.swift
//  GlucoWise
//
//  Created by student-2 on 13/01/25.
//

import UIKit

class addBloodReadingTableViewController: UITableViewController {
    let option1 = UIAction(title: "Fasting", handler: { _ in
                print("Option 1 selected")
})
    let option2 = UIAction(title: "PreMeal", handler: { _ in
                print("Option 2 selected")
            })
    let option3 = UIAction(title: "PostMeal", handler: { _ in
                print("Option 3 selected")
            })
    let option4 = UIAction(title: "PreWorkout", handler: { _ in
        print("Option 2 selected")
    })
    let option5 = UIAction(title: "PostWorkout", handler: { _ in
        print("Option 3 selected")
    })
    @IBOutlet weak var tagOptions: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
        navigationItem.title = "Add Reading"
        let menu = UIMenu(title: "", children: [option1, option2, option3,option4,option5])
        tagOptions.menu = menu
    }
    @objc func cancelBtnTapped(){
        dismiss(animated: true,completion: nil)
    }
}
