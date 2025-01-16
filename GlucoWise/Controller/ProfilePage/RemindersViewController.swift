import UIKit

protocol AddReminderDelegate: AnyObject {
    func didAddReminder(_ reminder: RemindersViewController.Reminder)
}

class RemindersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate {
    struct Reminder {
        var title: String
        var time: String
        var frequency: String
    }

    var reminders: [Reminder] = [
        Reminder(title: "Workout Reminder", time: "7:00 AM", frequency: "Daily"),
        Reminder(title: "Drink water reminder", time: "Every hour", frequency: "Every Hour")
    ]

    
    @IBOutlet weak var remindersTableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        remindersTableView.dataSource = self
        remindersTableView.delegate = self
        remindersTableView.rowHeight = UITableView.automaticDimension
        remindersTableView.estimatedRowHeight = 50

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addReminderButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func addReminderButtonTapped() {
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil) // Replace "Main" with your storyboard name
        guard let addReminderVC = storyboard.instantiateViewController(withIdentifier: "addReminderVC") as? addReminderTableViewController else { return }
        addReminderVC.modalPresentationStyle = .popover

      
        if let popoverController = addReminderVC.popoverPresentationController {
                popoverController.barButtonItem = navigationItem.rightBarButtonItem // Set the source to the right bar button item
                popoverController.permittedArrowDirections = .any // Arrow direction can be adjusted as needed
                popoverController.delegate = self // Optional: To handle popover delegate methods
            }
            
            // Present the view controller
            present(addReminderVC, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reminders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderCell", for: indexPath)
        let reminder = reminders[indexPath.row]
        cell.textLabel?.text = reminder.title
        cell.detailTextLabel?.text = "\(reminder.time) • \(reminder.frequency)"
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = reminders[indexPath.row]

        let actionSheet = UIAlertController(title: "Reminder Options", message: "What would you like to do?", preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.deleteReminder(at: indexPath.row)
        })

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
    }

    // Implement swipe-to-delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteReminder(at: indexPath.row)
        }
    }

    func deleteReminder(at index: Int) {
        reminders.remove(at: index)
        remindersTableView.reloadData()
    }
}


