//
//  addBloodReadingTableViewController.swift
//  GlucoWise
//
//  Created by student-2 on 13/01/25.
//

import UIKit

class addBloodReadingTableViewController: UITableViewController {
    
    var isPickerVisible = false
    var isDatePicker = true // true for Date Picker, false for Time Picker
    var selectedDate: Date = Date() {
            didSet {
                tableView.reloadData() // Update the displayed date and time
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBtnTapped))
    }
    @objc func cancelBtnTapped(){
        dismiss(animated: true,completion: nil)
    }




}
