import UIKit

class trackMealsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var selectedButton: UIButton?
    private var tableView: UITableView!
    let meals = ["Breakfast", "Lunch", "Snacks", "Dinner"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendarView()
        setupHeader()
        setupTableView()
    }

    // MARK: - Calendar Setup
    func setupCalendarView() {
        // Container view for the calendar
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Main horizontal stack view for the days
        let mainStackView = UIStackView()
        mainStackView.axis = .horizontal
        mainStackView.spacing = 8
        mainStackView.distribution = .fillEqually
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(mainStackView)

        // Get current week dates
        let currentDate = Date()
        let calendar = Calendar.current
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        let days = ["M", "T", "W", "T", "F", "S", "S"]
        
        for i in 0..<7 {
            // Calculate the date for each day in the week
            if let date = calendar.date(byAdding: .day, value: i, to: startOfWeek) {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "d" // Day number
                let dayNumber = dayFormatter.string(from: date)
                
                // Stack for label and button
                let buttonStack = UIStackView()
                buttonStack.axis = .vertical
                buttonStack.alignment = .center
                buttonStack.spacing = 4
                buttonStack.translatesAutoresizingMaskIntoConstraints = false
                
                // Day label
                let dayLabel = UILabel()
                dayLabel.text = days[i]
                dayLabel.font = UIFont.systemFont(ofSize: 14)
                dayLabel.textColor = .darkGray
                buttonStack.addArrangedSubview(dayLabel)
                
                // Day button
                let dayButton = UIButton(type: .system)
                dayButton.setTitle(dayNumber, for: .normal)
                dayButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                dayButton.backgroundColor = UIColor(hex: "#F2F2F7")
                dayButton.layer.cornerRadius = 20
                dayButton.clipsToBounds = true
                dayButton.setTitleColor(.black, for: .normal)
                dayButton.layer.borderWidth = 1
                dayButton.layer.borderColor = UIColor.clear.cgColor

                // Disable future dates
                if date > currentDate {
                    dayButton.isEnabled = false
                    dayButton.setTitleColor(.lightGray, for: .normal)
                } else {
                    // Highlight the current day by default
                    if calendar.isDate(date, inSameDayAs: currentDate) {
                        dayButton.backgroundColor = UIColor(hex: "#6CAB9C")
                        dayButton.setTitleColor(.white, for: .normal)
                        selectedButton = dayButton // Set the initial selected button
                    }
                    
                    dayButton.addTarget(self, action: #selector(dayButtonTapped(_:)), for: .touchUpInside)
                }
                
                dayButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
                dayButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
                
                buttonStack.addArrangedSubview(dayButton)
                mainStackView.addArrangedSubview(buttonStack)
            }
        }

        // Add constraints for the container and stack view
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
        ])
    }

    @objc func dayButtonTapped(_ sender: UIButton) {
        // Reset the previously selected button
        if let previousButton = selectedButton {
            previousButton.backgroundColor = UIColor(hex: "#F2F2F7")
            previousButton.setTitleColor(.black, for: .normal)
            previousButton.layer.borderWidth = 1
            previousButton.layer.borderColor = UIColor.clear.cgColor
        }
        
        // Highlight the new selected button
        sender.backgroundColor = UIColor(hex: "#6CAB9C")
        sender.setTitleColor(.white, for: .normal)
        sender.layer.borderWidth = 0

        // Update the selected button
        selectedButton = sender
    }

    
    func setupHeader() {
        // Create a header view
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)

        // Add constraints for the header
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 44), // Adjusted height to fit the button
        ])

        // "Add Meal" button
        let addMealButton = UIButton(type: .system)
        addMealButton.setTitle("Add Meal", for: .normal)
        addMealButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        addMealButton.backgroundColor = UIColor(hex: "#6CAB9C")
        addMealButton.setTitleColor(.white, for: .normal)
        addMealButton.layer.cornerRadius = 20
        addMealButton.clipsToBounds = true
        addMealButton.addTarget(self, action: #selector(addMealButtonTapped), for: .touchUpInside)
        
        // Add the button to the header
        addMealButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(addMealButton)

        // Add constraints for the button to stretch it across the width
        NSLayoutConstraint.activate([
            addMealButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),  // Align with the left edge of the screen
            addMealButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),  // Align with the right edge of the screen
            addMealButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor), // Center vertically within the header view
            addMealButton.heightAnchor.constraint(equalToConstant: 40),  // Set button height
        ])
        
        // Make sure the Add Meal button is always on top
        view.bringSubviewToFront(headerView)
        view.bringSubviewToFront(addMealButton)
    }

    @objc func addMealButtonTapped() {
        let storyboard = UIStoryboard(name: "AddMeal", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "search") as? AddMealViewController{
            vc.title = "Search Food"
            if vc.navigationController == nil {
                // Embed vc2 in a navigation controller
                let navigationController = UINavigationController(rootViewController: vc)
                navigationController.modalPresentationStyle = .popover

                // Present the navigation controller
                self.present(navigationController, animated: true, completion: nil)
            } else {
                // If already embedded, just present vc2
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true, completion: nil)
            }
            
        }
    }

    // MARK: - Table View Setup
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // Add constraints for the table view
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 165), // Starts below the header and button
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        ])
    }

    // MARK: - Table View Data Source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Now there are two sections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4 // For "Tracked Meals" section
        } else {
            return 4 // For "Macronutrient Breakdown"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell") ?? UITableViewCell(style: .default, reuseIdentifier: "MealCell")
            
            
            cell.textLabel?.text = meals[indexPath.row]
            
            // Add disclosure indicator to each cell
            cell.accessoryType = .disclosureIndicator
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MacronutrientCell") ?? UITableViewCell(style: .default, reuseIdentifier: "MacronutrientCell")
            
            let macronutrients = ["Carbs", "Protein", "Fats", "Fiber"]
            let values = [("12", "20"), ("15", "30"), ("8", "25"), ("5", "10")] // Example values for current and target

            let currentValue = values[indexPath.row].0
            let targetValue = values[indexPath.row].1
            
            cell.textLabel?.text = macronutrients[indexPath.row]
            
            // Add a progress bar
            let progressBar = UIProgressView(progressViewStyle: .default)
            progressBar.progress = Float(currentValue)! / Float(targetValue)! // Set progress dynamically
            progressBar.translatesAutoresizingMaskIntoConstraints = false
            cell.contentView.addSubview(progressBar)
            
            // Add the label to show the current value (e.g., "12/20g")
            let valueLabel = UILabel()
            valueLabel.text = "\(currentValue)/\(targetValue)g"
            valueLabel.translatesAutoresizingMaskIntoConstraints = false
            valueLabel.font = UIFont.systemFont(ofSize: 12)
            cell.contentView.addSubview(valueLabel)

            // Constraints for the progress bar
            NSLayoutConstraint.activate([
                progressBar.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20),
                progressBar.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                progressBar.widthAnchor.constraint(equalToConstant: 100),
                
                valueLabel.trailingAnchor.constraint(equalTo: progressBar.leadingAnchor, constant: -10), // Space between the label and progress bar
                valueLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            ])
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "TrackedMealsPage", bundle: nil)
        if let vc2 = storyboard.instantiateViewController(withIdentifier: "TrackedMealsVC") as? TrackedMealsPageViewController{
            vc2.setTitle = meals[indexPath.row]
            self.navigationController?.pushViewController(vc2, animated: true)
        }
        
    }


    // MARK: - Table View Delegate
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Tracked Meals"
        } else {
            return "Macronutrient Breakdown"
        }
    }
}
