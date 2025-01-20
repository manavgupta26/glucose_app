import UIKit

class HowActiveAreYouViewController: UIViewController {

    // Outlets for the views containing images
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    
    // Array to hold all the views
    var views: [UIView] = []
    
    // Track the selected view
    var selectedView: UIView?
    
    // Dictionary to store the original background color of each view
    var originalBackgroundColors: [UIView: UIColor] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the views to the array
        views = [view1, view2, view3, view4]
        
        // Store the original background color of each view
        for view in views {
            originalBackgroundColors[view] = view.backgroundColor
        }
        
        // Set up tap gestures for each view
        for view in views {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    // Action when one of the views is tapped
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        
        // Deselect the previously selected view
        deselectAllViews()
        
        // Select the new view and change its background color (or image)
        selectView(tappedView)
    }

    // Deselect all views
    func deselectAllViews() {
        for view in views {
            // Reset the background color of all views to their original state
            if let originalColor = originalBackgroundColors[view] {
                view.backgroundColor = originalColor
            }
        }
    }

    // Select a view and change its appearance
    func selectView(_ view: UIView) {
        // Set the background color using the hex code #6CAB9D
        view.backgroundColor = UIColor(hex: "#6CAB9D")
        
        // Keep track of the selected view
        selectedView = view
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        // Pop the view controller from the navigation stack when back button is tapped
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func NextButtonTapped(_ sender: UIButton) {
        // Perform segue when next button is tapped
        self.performSegue(withIdentifier: "lastReading", sender: self)
    }
}
