import UIKit

class HbA1cViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var glucoseDataSet = GlucoseDataSet() // Use the predefined GlucoseDataSet

    let tableView = UITableView(frame: .zero) // Inset grouped style
    let recalculateButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup UI
        setupUI()
    }

    // Setup UI elements
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = "Predicted HbA1c"

        // **Recalculate Button**
        recalculateButton.translatesAutoresizingMaskIntoConstraints = false
        recalculateButton.setTitle("Recalculate HbA1c", for: .normal)
        recalculateButton.backgroundColor = UIColor(red: 108/255, green: 171/255, blue: 145/255, alpha: 1.0) // #6cab91
        recalculateButton.setTitleColor(.white, for: .normal) // White text
        recalculateButton.layer.cornerRadius = 15 // Rounded corners
        recalculateButton.layer.shadowColor = UIColor.black.cgColor
        recalculateButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        recalculateButton.layer.shadowRadius = 4
        recalculateButton.layer.shadowOpacity = 0.2
        recalculateButton.addTarget(self, action: #selector(recalculateHbA1c), for: .touchUpInside)
        self.view.addSubview(recalculateButton)

        // **TableView**
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine // Ensure lines are visible
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16) // Adjust insets
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GlucoseCell")
        self.view.addSubview(tableView)

        // Layout Constraints
        NSLayoutConstraint.activate([
            recalculateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            recalculateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            recalculateButton.heightAnchor.constraint(equalToConstant: 50),
            recalculateButton.widthAnchor.constraint(equalToConstant: 250),

            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: recalculateButton.topAnchor, constant: -20)
        ])
    }

    // Calculate HbA1c and show as a popup
    private func updatePredictedHbA1c() {
        let readings = glucoseDataSet.glucoseReadings.map { $0.averageReading }
        let averageGlucose = readings.reduce(0, +) / Double(readings.count)
        let predictedHbA1c = (averageGlucose + 46.7) / 28.7

        let status: String
        let emoji: String

        if predictedHbA1c < 5.7 {
            status = "Good"
            emoji = "😊"
        } else if predictedHbA1c < 7.0 {
            status = "Bad"
            emoji = "😐"
        } else {
            status = "Worse"
            emoji = "😞"
        }

        // Show a popup with the HbA1c value and status
        let alert = UIAlertController(
            title: "Predicted HbA1c",
            message: String(format: "\(emoji) HbA1c: %.2f%%\nStatus: \(status)", predictedHbA1c),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    @objc private func recalculateHbA1c() {
        updatePredictedHbA1c()
    }

    // MARK: - UITableView DataSource & Delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // All readings in one section
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return glucoseDataSet.glucoseReadings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlucoseCell", for: indexPath)
        let reading = glucoseDataSet.glucoseReadings[indexPath.row]

        cell.textLabel?.text = "\(reading.date) - \(String(format: "%.1f", reading.averageReading)) mg/dL"
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)

        // Adjust appearance
        cell.contentView.backgroundColor = .white
        
        cell.contentView.layer.masksToBounds = true // Ensure rounded corners don't overlap

        return cell
    }
}

//// Dummy data structure for demonstration purposes
//struct GlucoseReading {
//    let date: String
//    let averageReading: Double
//}
//
//struct GlucoseDataSet {
//    var glucoseReadings: [GlucoseReading] = [
//        GlucoseReading(date: "2025-01-19", averageReading: 110.0),
//        GlucoseReading(date: "2025-01-18", averageReading: 120.0),
//        GlucoseReading(date: "2025-01-17", averageReading: 95.0)
//    ]

