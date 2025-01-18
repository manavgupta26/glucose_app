import UIKit

class TrackedMealsPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    var trackedFoods = ["Allu Paratha", "Curd, Amul"]
    let macronutrients = [("Carbs", 0.9), ("Protein", 0.7), ("Fats", 0.5), ("Fiber", 0.8)]

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupGlycemicIndicators() // Setup Glycemic Indicators
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trackedFoods.count
        } else {
            return macronutrients.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.section == 0 {
            cell.textLabel?.text = trackedFoods[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        } else {
            let nutrient = macronutrients[indexPath.row]
            cell.textLabel?.text = nutrient.0

            let progressView = UIProgressView(progressViewStyle: .default)
            progressView.progress = Float(nutrient.1)
            progressView.tintColor = .systemGreen
            progressView.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(progressView)

            NSLayoutConstraint.activate([
                progressView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                progressView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16),
                progressView.widthAnchor.constraint(equalToConstant: 100)
            ])
        }
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Tracked Food"
        } else {
            return "Macronutrients Breakdown"
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
            showTrackedFoodOptions(for: indexPath.row)
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

    // Setup Glycemic Indicators
    private func setupGlycemicIndicators() {
        // Section Heading
        let sectionLabel = UILabel()
        sectionLabel.text = "Glycemic Indicators"
        sectionLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionLabel)

        // Glycemic Index Progress View
        let glycemicIndexView = createCircularProgressView(progress: 0.45, title: "Glycemic Index", value: 45)
        glycemicIndexView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glycemicIndexView)

        // Glycemic Load Progress View
        let glycemicLoadView = createCircularProgressView(progress: 0.28, title: "Glycemic Load", value: 28)
        glycemicLoadView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(glycemicLoadView)

        NSLayoutConstraint.activate([
            sectionLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16),
            sectionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            glycemicIndexView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 16),
            glycemicIndexView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            glycemicIndexView.widthAnchor.constraint(equalToConstant: 100),
            glycemicIndexView.heightAnchor.constraint(equalToConstant: 120),

            glycemicLoadView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 16),
            glycemicLoadView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            glycemicLoadView.widthAnchor.constraint(equalToConstant: 100),
            glycemicLoadView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    // Create Circular Progress View
    private func createCircularProgressView(progress: CGFloat, title: String, value: Int) -> UIView {
        let container = UIView()

        let circleLayer = CAShapeLayer()
        let progressLayer = CAShapeLayer()

        let center = CGPoint(x: 50, y: 50)
        let radius: CGFloat = 40
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -.pi / 2, endAngle: 1.5 * .pi, clockwise: true)

        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.lineWidth = 8
        container.layer.addSublayer(circleLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor.systemGreen.cgColor
        progressLayer.lineWidth = 8
        progressLayer.strokeEnd = progress
        container.layer.addSublayer(progressLayer)

        let valueLabel = UILabel()
        valueLabel.text = "\(value)"
        valueLabel.font = UIFont.boldSystemFont(ofSize: 20)
        valueLabel.textColor = .systemGreen
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(valueLabel)

        NSLayoutConstraint.activate([
            valueLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.bottomAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])

        return container
    }
}
