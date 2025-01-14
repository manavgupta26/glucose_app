import UIKit

class ChangePasswordTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a "Done" button to the navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }

    // MARK: - Actions
    @objc private func doneButtonTapped() {
        // Handle the "Done" button tap action
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    
}
