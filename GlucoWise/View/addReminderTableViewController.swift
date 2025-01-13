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
    
    
        
    @IBOutlet weak var reminderTimePicker: UIDatePicker!
    
    @IBOutlet weak var selectReminderRepeat: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func repeatReminder(_ sender: UIAction) {
        self.selectReminderRepeat.setTitle(sender.title, for: .normal)
    }
 

}
