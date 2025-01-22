import UIKit

class AddMealViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton! // Regular UIButton

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        updateCancelButton() // Set the initial state of the button
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Perform search with the search text
        let searchText = searchBar.text ?? ""
        print("Search text: \(searchText)")
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Perform real-time search updates
        print("Search text changed: \(searchText)")
        updateCancelButton() // Update the cancel button title when text changes
    }

    // Update the cancel button title based on search text
    private func updateCancelButton() {
        let searchText = searchBar.text ?? ""
        
        if searchText.isEmpty {
            cancelButton.setTitle("Cancel", for: .normal) // When the search bar is empty
        } else {
            cancelButton.setTitle("Done", for: .normal) // When there's text in the search bar
        }
    }

    // Action for the Cancel/Done button
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
        if searchBar.text?.isEmpty ?? true {
            // Reset the search bar when it's empty (Cancel)
            searchBar.resignFirstResponder() // Dismiss the keyboard
        } else {
            // Handle Done action when there's text in the search bar
            print("Done button tapped with text: \(searchBar.text ?? "")")
            searchBar.resignFirstResponder() // Dismiss the keyboard
        }
    }
}
