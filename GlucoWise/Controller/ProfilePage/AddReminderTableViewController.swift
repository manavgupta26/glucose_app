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

class AddReminderTableViewController: UITableViewController{
    weak var delegate: AddReminderDelegate?
    
    
    @IBOutlet weak var repeatType: UIButton!
    
    

    
    let option1 = UIAction(title: "Never", handler: { _ in
                
            })
    let option2 = UIAction(title: "Everyday", handler: { _ in
                
            })
    let option3 = UIAction(title: "Weekdays", handler: { _ in
        
    })
    let option4 = UIAction(title: "Weekends", handler: { _ in
        
    })
let option5 = UIAction(title: "Monthly", handler: { _ in

})
let option6 = UIAction(title: "Every 3 months", handler: { _ in

})
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = UIMenu(title: "", children: [option1, option2, option3,option4,option5])
        repeatType.menu = menu
        
    }
    
 

}
