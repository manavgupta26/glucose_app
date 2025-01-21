import UIKit

class HowActiveAreYouViewController: UIViewController {

    // Outlets for the views containing images and labels
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
        
        // Select the new view and change its background color and text color
        selectView(tappedView)
    }

    // Deselect all views
    func deselectAllViews() {
        for view in views {
            // Reset the background color of all views to their original state
            if let originalColor = originalBackgroundColors[view] {
                view.backgroundColor = originalColor
            }
            
            // Reset the text color of labels inside each view to their default (e.g., black)
            updateLabelColor(for: view, to: .black)
        }
    }

    // Select a view and change its appearance
    func selectView(_ view: UIView) {
        // Set the background color using the hex code #6CAB9D
        view.backgroundColor = UIColor(hex: "#6CAB9D")
        
        // Change the text color of labels inside the selected view to white
        updateLabelColor(for: view, to: .white)
        
        // Keep track of the selected view
        selectedView = view
    }

    // Helper to update the text color of labels inside a view
    func updateLabelColor(for view: UIView, to color: UIColor) {
        for subview in view.subviews {
            if let label = subview as? UILabel {
                label.textColor = color
            }
        }
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

// MARK: - UIColor Extension for Hex Colors

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
