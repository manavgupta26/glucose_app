//
//  NotificationPreferencesViewController.swift
//  GlucoWise
//
//  Created by Sehdev Saini on 23/12/24.
//

import UIKit

class NotificationPreferencesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    @IBOutlet weak var tableView: UITableView!

    let notificationOptions = [
        "App Notifications",
        "Mail Notifications",
        "Reminder Notifications"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notification Preferences"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NotificationCell")
    }
}

