//
//  addBloodReadingTableViewController.swift
//  GlucoWise
//
//  Created by student-2 on 13/01/25.
//

import UIKit

protocol addReadingdelegate : AnyObject{
    func didAddReading(reading : String,time : String,type : String)
}

class addBloodReadingTableViewController: UITableViewController {
  
    weak var delegate : addReadingdelegate?
    
    
    @IBOutlet weak var dateField: UIDatePicker!
    
    
    @IBOutlet weak var readingField: UITextField!
    
    
    @IBOutlet weak var mealTag: UIButton!
    
    
    
    @IBOutlet weak var tagOptions: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
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
    @objc func doneTapped(){
        let timeFormatter = DateFormatter()
            timeFormatter.dateFormat = "hh:mm a"
        guard let readings = readingField.text, !readings.isEmpty, let mealType = tagOptions.titleLabel?.text else {
            return
        }
        let time = timeFormatter.string(from: dateField.date)
        delegate?.didAddReading(reading: readings, time: time, type: mealType)
        dismiss(animated: true)
       
    }
}
