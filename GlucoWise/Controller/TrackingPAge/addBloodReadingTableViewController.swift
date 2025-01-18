//
//  addBloodReadingTableViewController.swift
//  GlucoWise
//
//  Created by student-2 on 13/01/25.
//

import UIKit

class addBloodReadingTableViewController: UITableViewController {
  
    
    @IBOutlet weak var tagOptions: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
        navigationItem.title = "Add Reading"
              // Configure menu options with handlers to update the button title
        let option1 = UIAction(title: "Fasting", handler: { [weak self] _ in
            self?.tagOptions.setTitle("Fasting", for: .normal)
        })
        let option2 = UIAction(title: "PreMeal", handler: { [weak self] _ in
            self?.tagOptions.setTitle("PreMeal", for: .normal)
        })
        let option3 = UIAction(title: "PostMeal", handler: { [weak self] _ in
            self?.tagOptions.setTitle("PostMeal", for: .normal)
        })
        let option4 = UIAction(title: "PreWorkout", handler: { [weak self] _ in
            self?.tagOptions.setTitle("PreWorkout", for: .normal)
        })
        let option5 = UIAction(title: "PostWorkout", handler: { [weak self] _ in
            self?.tagOptions.setTitle("PostWorkout", for: .normal)
        })
        
        // Assign the menu to the button
        let menu = UIMenu(title: "", children: [option1, option2, option3, option4, option5])
        tagOptions.menu = menu
        tagOptions.showsMenuAsPrimaryAction = true

    }
    @objc func cancelBtnTapped(){
        dismiss(animated: true,completion: nil)
    }
}
