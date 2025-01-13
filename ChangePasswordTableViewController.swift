//
//  ChangePasswordTableViewController.swift
//  GlucoWise
//
//  Created by Sehdev Saini on 23/12/24.
//

import UIKit

class ChangePasswordTableViewController: UITableViewController {
    
    var currentPasswordTextField: UITextField!
    var newPasswordTextField: UITextField!
    var confirmPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        // Set the title for the navigation bar
                self.navigationItem.title = "Change Password"

               
                
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pass", for: indexPath)

        // Configure the cell...

        if indexPath.section == 0 {
            // Section 1: Current Password
            let textField = UITextField(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 44))
            textField.placeholder = "Current Password"
            textField.isSecureTextEntry = true
            self.currentPasswordTextField = textField
            cell.contentView.addSubview(textField)
        } else if indexPath.section == 1 {
            // Section 2: New Password
            let textField = UITextField(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 44))
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
            self.newPasswordTextField = textField
            cell.contentView.addSubview(textField)
        } else if indexPath.section == 2 {
            // Section 3: Confirm New Password
            let textField = UITextField(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 44))
            textField.placeholder = "Confirm New Password"
            textField.isSecureTextEntry = true
            self.confirmPasswordTextField = textField
            cell.contentView.addSubview(textField)
        } else if indexPath.section == 3 {
            // Section 4: Password Requirements
            cell.textLabel?.text = "Your new password should be at least 8 characters long, contain a mix of uppercase and lowercase letters, numbers, and special symbols."
            cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
            cell.textLabel?.numberOfLines = 0 // Allow multiline text
        }

        return cell

    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Current Password"
            } else if section == 1 {
                return "New Password"
            } else if section == 2 {
                return "Confirm New Password"
            }
            return nil
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
    
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }

}
