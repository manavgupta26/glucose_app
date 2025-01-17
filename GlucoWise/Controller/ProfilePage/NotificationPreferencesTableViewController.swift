//
//  NotificationPreferencesTableViewController.swift
//  GlucoWise
//
//  Created by Sehdev Saini on 03/01/25.
//

import UIKit

class NotificationPreferencesTableViewController: UITableViewController {

    let notificationOptions = [
        ("App Notifications", "bell"),
        ("Mail Notifications", "envelope"),
        ("Reminder Notifications", "bell.badge")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notification Preferences"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationOptions.count // Number of rows = number of options
    
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)
        
        // Configure the cell
        let option = notificationOptions[indexPath.row]
        cell.textLabel?.text = option.0 // Set the title
        cell.imageView?.image = UIImage(systemName: option.1) // Set the icon
        
        // Set the tint color to black
        cell.imageView?.tintColor = UIColor.black
        
        // Add UISwitch as accessory view
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(true, animated: true) // Default to ON
        switchView.tag = indexPath.row // Use tag to identify the switch later
        switchView.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1 // A very small height to remove the extra space
    }

    
    @objc func switchChanged(_ sender: UISwitch) {
        let optionName = notificationOptions[sender.tag].0
        print("\(optionName) is now \(sender.isOn ? "ON" : "OFF")")
    }


    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
