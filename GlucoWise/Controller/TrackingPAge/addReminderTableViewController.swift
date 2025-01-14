//
//  addReminderTableViewController.swift
//  GlucoWise
//
//  Created by Sehdev Saini on 13/01/25.
//

import UIKit
protocol addReminderDelegate: AnyObject {
    func didAddReminder(title: String, time: Date?, repeatOption: String)
}

class addReminderTableViewController: UITableViewController{
    weak var delegate: AddReminderDelegate?
    
    
    @IBOutlet weak var repeatType: UIButton!
    
    
        
    @IBOutlet weak var reminderTimePicker: UIDatePicker!
    
    let option1 = UIAction(title: "Never", handler: { _ in
                print("Option 1 selected")
            })
    let option2 = UIAction(title: "Weekdays", handler: { _ in
        print("Option 2 selected")
    })
    let option3 = UIAction(title: "Weekends", handler: { _ in
        print("Option 3 selected")
    })
let option4 = UIAction(title: "Monthly", handler: { _ in
print("Option 2 selected")
})
let option5 = UIAction(title: "Every 3 months", handler: { _ in
print("Option 3 selected")
})
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = UIMenu(title: "", children: [option1, option2, option3,option4,option5])
        repeatType.menu = menu
        
    }
    
 

}
