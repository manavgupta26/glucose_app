import UIKit

class TrackedMealsPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var setTitle : String?
    let tableView = UITableView(frame: .zero, style: .grouped)
    var trackedFoods = ["Allu Paratha", "Curd, Amul"]
    let macronutrients = [("Carbs", 0.9), ("Protein", 0.7), ("Fats", 0.5), ("Fiber", 0.8)]
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.title = setTitle
        setupTableView()
       // Setup Glycemic Indicators
    }
    

    private func setupTableView() {
           view.addSubview(tableView)
           tableView.delegate = self
           tableView.dataSource = self
           tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
           tableView.register(GlycemicIndicatorCell.self, forCellReuseIdentifier: "glycemicCell")
           tableView.translatesAutoresizingMaskIntoConstraints = false

           NSLayoutConstraint.activate([
               tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
       }
    
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0:
               return trackedFoods.count
           case 1:
               return 1// Glycemic Index and Glycemic Load
           case 2:
               return macronutrients.count
           default:
               return 0
           }
       }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            switch indexPath.section {
            case 0: // Tracked Foods
                cell.textLabel?.text = trackedFoods[indexPath.row]
                cell.accessoryType = .disclosureIndicator
                
            case 1: // Glycemic Indicators
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "glycemicCell", for: indexPath) as? GlycemicIndicatorCell else {
                                return UITableViewCell()
                            }
                            cell.configure(glycemicIndex: 0.45, glycemicLoad: 0.28, indexValue: 45, loadValue: 28)
                            return cell
                
            case 2: // Macronutrients
                let nutrient = macronutrients[indexPath.row]
                   cell.textLabel?.text = nutrient.0
                   
                   let progressView = UIProgressView(progressViewStyle: .default)
                   progressView.progress = Float(nutrient.1)
                progressView.tintColor = UIColor(hex: "#6CAB9C")
                   progressView.translatesAutoresizingMaskIntoConstraints = false
                   
                   // Label for the macronutrient values
                   let valueLabel = UILabel()
                   valueLabel.text = "\(Int(nutrient.1 * 20))/20g" // Assuming a total value of 20g for demonstration
                   valueLabel.font = UIFont.systemFont(ofSize: 14)
                valueLabel.textColor = .systemGray
                valueLabel.font = UIFont.systemFont(ofSize: 12)
                   valueLabel.translatesAutoresizingMaskIntoConstraints = false
                   
                   // Clear old subviews to prevent overlap
                   for subview in cell.contentView.subviews {
                       subview.removeFromSuperview()
                   }
                   
                   // Add the progress view and the label to the cell content view
                   cell.contentView.addSubview(progressView)
                   cell.contentView.addSubview(valueLabel)
                   
                   // Constraints for progressView and valueLabel
                   NSLayoutConstraint.activate([
                       progressView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                       progressView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                       progressView.widthAnchor.constraint(equalToConstant: 100),
                       
                       valueLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
                       valueLabel.trailingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: -8) // Place the label to the left of the progress bar
                   ])
                
            default:
                break
            }
            return cell
        }
    
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         switch section {
         case 0:
             return "Tracked Food"
         case 1:
             return "Glycemic Indicators"
         case 2:
             return "Macronutrients Breakdown"
         default:
             return nil
         }
     }
 

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                trackedFoods.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Handle tap on tracked food item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: "fooditem", bundle: nil)
            if let foodItemViewController = storyboard.instantiateViewController(withIdentifier: "foodValues") as? foodvaluesViewController {
                foodItemViewController.navigationItem.title = trackedFoods[indexPath.row]
                foodItemViewController.imagew = UIImage(named: trackedFoods[indexPath.row])
                self.navigationController?.pushViewController(foodItemViewController, animated: true)
                
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // Show options to Edit or Delete the tracked food
    private func showTrackedFoodOptions(for index: Int) {
        let foodItem = trackedFoods[index]

        let alertController = UIAlertController(
            title: "Manage \(foodItem)",
            message: "What would you like to do?",
            preferredStyle: .actionSheet
        )

        // Edit Action
        alertController.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            self.showEditTrackedFoodAlert(for: index)
        }))

        // Delete Action
        alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
            self.trackedFoods.remove(at: index)
            self.tableView.reloadData()
        }))

        // Cancel Action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }

    // Show alert to edit tracked food
    private func showEditTrackedFoodAlert(for index: Int) {
        let alertController = UIAlertController(
            title: "Edit Tracked Food",
            message: "Update the name of the food item.",
            preferredStyle: .alert
        )

        // Text Field for Input
        alertController.addTextField { textField in
            textField.text = self.trackedFoods[index]
        }

        // Save Action
        alertController.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let updatedText = alertController.textFields?.first?.text, !updatedText.isEmpty {
                self.trackedFoods[index] = updatedText
                self.tableView.reloadData()
            }
        }))

        // Cancel Action
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        present(alertController, animated: true, completion: nil)
    }
 

}
class GlycemicIndicatorCell: UITableViewCell {
    private let glycemicIndexView = UIView()
    private let glycemicLoadView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        glycemicIndexView.translatesAutoresizingMaskIntoConstraints = false
        glycemicLoadView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(glycemicIndexView)
        contentView.addSubview(glycemicLoadView)

        NSLayoutConstraint.activate([
            // Glycemic Index View constraints
            glycemicIndexView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            glycemicIndexView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16), // Adjusted to add vertical padding
            glycemicIndexView.widthAnchor.constraint(equalToConstant: 120),
            glycemicIndexView.heightAnchor.constraint(equalToConstant: 120),

            // Glycemic Load View constraints
            glycemicLoadView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            glycemicLoadView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16), // Adjusted to add vertical padding
            glycemicLoadView.widthAnchor.constraint(equalToConstant: 120),
            glycemicLoadView.heightAnchor.constraint(equalToConstant: 120),

            // Ensure bottom of the views align with the content view's bottom
            glycemicIndexView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),
            glycemicLoadView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    
  

    
    
    func configure(glycemicIndex: CGFloat, glycemicLoad: CGFloat, indexValue: Int, loadValue: Int) {
        setupCircularProgress(view: glycemicIndexView, progress: glycemicIndex, title: "Glycemic Index", value: indexValue)
        setupCircularProgress(view: glycemicLoadView, progress: glycemicLoad, title: "Glycemic Load", value: loadValue)
    }
    



    private func setupCircularProgress(view: UIView, progress: CGFloat, title: String, value: Int) {
        view.subviews.forEach { $0.removeFromSuperview() } // Clear previous subviews

        let circleLayer = CAShapeLayer()
        let progressLayer = CAShapeLayer()

        let center = CGPoint(x: 60, y: 60)
        let radius: CGFloat = 50
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)

        // Background circle
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor(hex: "#EAEDEC").cgColor
        circleLayer.lineWidth = 7
        view.layer.addSublayer(circleLayer)

        // Progress circle
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(hex: "#6CAB9C").cgColor
        progressLayer.lineWidth = 7
        progressLayer.strokeEnd = progress
        view.layer.addSublayer(progressLayer)

        // Value label
        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textColor = .systemGray
        valueLabel.textAlignment = .center
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(valueLabel)

        // Title label
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 11)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Add constraints for labels
        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 4),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

