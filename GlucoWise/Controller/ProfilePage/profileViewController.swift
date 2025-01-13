//
//  profileViewController.swift
//  GlucoWise
//
//  Created by student-2 on 23/12/24.
//

import UIKit

class profileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.dataSource = self
        profileTableView.delegate = self
        // Register a custom UITableViewCell for sections
        profileTableView.register(UITableViewCell.self, forCellReuseIdentifier: "profileCell")
    }

    // Section titles
    let sectionTitles = ["User Settings", "General"]
    // Section items
    let sectionItems = [
        ["Change Password", "Notification Preference"],
        ["Progress Summary", "Health Goals", "Reminders"]
    ]
    // Section icons
    let cellIcons = [
        [UIImage(systemName: "lock"), UIImage(systemName: "bell")],
        [UIImage(systemName: "list.bullet.clipboard"), UIImage(systemName: "heart"), UIImage(systemName: "alarm")]
    ]

    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < sectionTitles.count {
            return sectionItems[section].count
        }
        return 0 // Logout section does not have rows
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count + 1 // Adding an extra section for the Logout button
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section < sectionTitles.count {
            return sectionTitles[section]
        }
        return nil // No title for the Logout button section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        
        if indexPath.section < sectionTitles.count {
            cell.textLabel?.text = sectionItems[indexPath.section][indexPath.row]
            cell.imageView?.image = cellIcons[indexPath.section][indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }

    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row after selection
        tableView.deselectRow(at: indexPath, animated: true)

        // Create a storyboard instance
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil) // Replace "Main" with your storyboard's name

        // Determine the selected section and row
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                // Navigate to "Change Password" ViewController
                let changePasswordVC = storyboard.instantiateViewController(withIdentifier: "ChangePasswordTVC")
                changePasswordVC.title = "Change Password" // Set the title for the next screen
                changePasswordVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(changePasswordVC, animated: true)
            } else if indexPath.row == 1 {
                // Navigate to "Notification Preferences" ViewController
                let notificationPreferenceVC = storyboard.instantiateViewController(withIdentifier: "NotificationPreferencesViewController") as! NotificationPreferencesTableViewController
                notificationPreferenceVC.title = "Notification Preferences" // Set the title for the next screen
                notificationPreferenceVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(notificationPreferenceVC, animated: true)
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                // Navigate to "Progress Summary" ViewController
                let progressSummaryVC = storyboard.instantiateViewController(withIdentifier: "ProgressSummaryVC")
                progressSummaryVC.title = "Progress Summary" // Set the title for the next screen
                self.navigationController?.pushViewController(progressSummaryVC, animated: true)
            } else if indexPath.row == 1 {
                // Navigate to "Health Goals" ViewController
                let healthGoalsVC = storyboard.instantiateViewController(withIdentifier: "HealthGoalsVC")
                healthGoalsVC.title = "Health Goals" // Set the title for the next screen
                self.navigationController?.pushViewController(healthGoalsVC, animated: true)
            } else if indexPath.row == 2 {
                // Navigate to "Reminders" ViewController
                let remindersVC = storyboard.instantiateViewController(withIdentifier: "ReminderVC")
                remindersVC.title = "Reminders" // Set the title for the next screen
                self.navigationController?.pushViewController(remindersVC, animated: true)
            }
        }
    }
    // MARK: - Logout Button as Footer View
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == sectionTitles.count { // Last section for Logout button
            let footerView = UIView()
            footerView.backgroundColor = .clear
            
            // Create the Logout button
            let logoutButton = UIButton(type: .system)
            logoutButton.setTitle("Logout", for: .normal)
            logoutButton.setTitleColor(.white, for: .normal)
            logoutButton.backgroundColor = UIColor(red: 108/255, green: 178/255, blue: 163/255, alpha: 1.0) // Custom color
            logoutButton.layer.cornerRadius = 10
            logoutButton.translatesAutoresizingMaskIntoConstraints = false // Enable Auto Layout
            
            // Add the button to the footer view
            footerView.addSubview(logoutButton)
            
            // Set constraints for the Logout button
            NSLayoutConstraint.activate([
                logoutButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
                logoutButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
                logoutButton.widthAnchor.constraint(equalToConstant: 352), // Button width
                logoutButton.heightAnchor.constraint(equalToConstant: 42)  // Button height
            ])
            
            // Add target for logout action
            logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
            
            return footerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == sectionTitles.count { // Logout section
            return 80 // Height for the Logout button
        }
        return 0.1 // Minimal height for other sections
    }

    // MARK: - Logout Button Action
    @objc func logoutButtonTapped() {
        print("Logout button tapped")
        // Perform logout action here
    }
}
