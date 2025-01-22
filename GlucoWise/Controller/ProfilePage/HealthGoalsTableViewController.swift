import UIKit

class HealthGoalsTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let goals: [String] = ["Blood Sugar Level Goal", "Body Weight Goal", "Daily Activity Goal", "Weight Management Goal"]
    var values = ["120 mg/dL", "100 kg", "30 minutes", "10 %"]
    var pickerData: [String] = [] // Picker options
    var selectedIndexPath: IndexPath? // To keep track of selected row
    var units: [String] = ["mg/dL", "kg", "minutes", "%"] // Units for each goal

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Goals", for: indexPath)
        cell.textLabel?.text = goals[indexPath.row]
        cell.detailTextLabel?.text = values[indexPath.row]
        return cell
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath
        showPicker(for: indexPath)
    }

    // MARK: - Picker View Logic

    private func showPicker(for indexPath: IndexPath) {
        // Define picker options
        switch indexPath.row {
        case 0: pickerData = Array(70...200).map { "\($0)" } // Blood sugar range
        case 1: pickerData = Array(40...150).map { "\($0)" } // Weight range
        case 2: pickerData = Array(10...100).map { "\($0)" } // Activity range
        case 3: pickerData = Array(5...50).map { "\($0)" }  // Management range
        default: pickerData = []
        }
        
        // Create a container view for UIPickerView
        let alertController = UIAlertController(title: "Select Value", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerView = UIPickerView()
        pickerView.frame = CGRect(x: 0, y: 50, width: 270, height: 150)
        pickerView.delegate = self
        pickerView.dataSource = self
        alertController.view.addSubview(pickerView)
        
        // Add Done button
        alertController.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            let selectedValue = self.pickerData[pickerView.selectedRow(inComponent: 0)]
            let unit = self.units[indexPath.row]
            self.updateValue("\(selectedValue) \(unit)", for: indexPath)
        }))
        
        // Add Cancel button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }

    private func updateValue(_ value: String, for indexPath: IndexPath) {
        // Update the value in the data source
        values[indexPath.row] = value
        
        // Reload the specific row
        tableView.reloadRows(at: [indexPath], with: .none)
    }

    // MARK: - UIPickerView DataSource & Delegate

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
