import UIKit
import DGCharts
import Charts

class BloodGlucoseTrackViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, addReadingdelegate{
    
    var selectedDateReadings: [String: MealReading] = [:]


    func didAddReading(reading: String, time: String, type: String) {
        guard let readingValue = Double(reading) else { return }
        let newReading = MealReading(reading: readingValue, time: time, tag: type)
        selectedDateReadings[type] = newReading
        tableView.reloadData()
        tableViewHeightConstraint?.constant = CGFloat(selectedDateReadings.count * 60)
        
        // Update chart data
        let indexPath = IndexPath(item: 0, section: 0) // Assuming the first chart corresponds to "Today"
        if let chartCell = collectionView.cellForItem(at: indexPath) as? ChartCell {
            updateChartCell(chartCell, at: indexPath)
        }
    }

    func updateChartCell(_ cell: ChartCell, at indexPath: IndexPath) {
        let chartDataEntries: [ChartDataEntry] = selectedDateReadings.values.enumerated().map { index, reading in
            ChartDataEntry(x: Double(index), y: reading.reading)
        }
        
        let titles = ["Today", "Week", "Month"]
        let title = titles[indexPath.row]
        cell.configure(with: title, data: chartDataEntries)
    }

    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var tableView: UITableView!
    var scrollView: UIScrollView!
    var contentView: UIView!
    var tableViewHeightConstraint : NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSelectedDateReadings(for: "01/04/2025")
        tabBarController?.tabBar.isHidden = false
        
        
            view.backgroundColor = .white
            
            // MARK: - ScrollView Setup
            scrollView = UIScrollView()
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(scrollView)

            contentView = UIView()
            contentView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(contentView)
            
            // MARK: - Horizontal Scrollable Collection View
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.itemSize = CGSize(width: 360, height: 310)
            layout.minimumLineSpacing = 15
            layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isPagingEnabled = true
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.backgroundColor = .white
            collectionView.register(ChartCell.self, forCellWithReuseIdentifier: "ChartCell")
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(collectionView)

            pageControl = UIPageControl()
            pageControl.numberOfPages = 3
            pageControl.currentPage = 0
            pageControl.pageIndicatorTintColor = .lightGray
            pageControl.currentPageIndicatorTintColor = .black
            pageControl.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(pageControl)
            
            // MARK: - Readings Section
            let headerView = UIView()
            headerView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(headerView)

            let readingsLabel = UILabel()
            readingsLabel.text = "Readings"
            readingsLabel.font = .boldSystemFont(ofSize: 18)
            readingsLabel.translatesAutoresizingMaskIntoConstraints = false
            headerView.addSubview(readingsLabel)
            
            // Add Reading Button
        // Add the "Add Reading" button
           let addButton: UIButton = {
               let button = UIButton(type: .system)
               button.setTitle("Add Reading", for: .normal)
               button.backgroundColor = UIColor(hex: "#6CAB9C")
               button.layer.cornerRadius = 8
               button.setTitleColor(.white, for: .normal)
               button.translatesAutoresizingMaskIntoConstraints = false
               return button
           }()
           
           // Add the button to the headerView
           headerView.addSubview(addButton)
        addButton.addTarget(self, action: #selector(addReadingButtonTapped), for: .touchUpInside)
           tableView = UITableView()
           tableView.dataSource = self
           tableView.delegate = self
        
        tableView.register(bloodReadingsTableViewCell.self, forCellReuseIdentifier: "ReadingCell")
           tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = 60
                tableView.tableFooterView = UIView()
           contentView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.reloadData()
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(selectedDateReadings.count * 80))
           // MARK: - Constraints
           NSLayoutConstraint.activate([
               // ScrollView
               scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

               // ContentView inside ScrollView
               contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
               contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
               contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
               contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
               contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

               // Collection View
               collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
               collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               collectionView.heightAnchor.constraint(equalToConstant: 310),

               // Page Control
               pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
               pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

               // Readings Header
               headerView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
               headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
               headerView.heightAnchor.constraint(equalToConstant: 40),

               // Readings Label
               readingsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
               readingsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

               // Add Button Constraints (to position it on the right side)
               addButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
               addButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
               addButton.widthAnchor.constraint(equalToConstant: 120),
               addButton.heightAnchor.constraint(equalToConstant: 35),

               // Table View
               
               tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
               tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
               tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
               tableViewHeightConstraint!,
               tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
           ])
       

    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateSelectedDateReadings(for: "01/04/2025")
    }
    
    
    func updateSelectedDateReadings(for date: String) {
        print("Updating readings for date: \(date)")
        let allData = GlucoseDataSet.shared.getAllData()
        if let glucoseReading = allData.first(where: { $0.date == date }) {
            print("Found reading for date: \(date)")
            selectedDateReadings = glucoseReading.readingsByMeal
        } else {
            print("No readings found for date: \(date)")
            selectedDateReadings = [:]
        }
        if tableView == nil {
            print("TableView is nil")
        }
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateReadings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingCell", for: indexPath) as! bloodReadingsTableViewCell
        
        let mealKeys = Array(selectedDateReadings.keys) // Get keys (e.g., "Fasting", "Breakfast")
        let mealKey = mealKeys[indexPath.row]
        
        if let mealReading = selectedDateReadings[mealKey] {
            cell.titleLabel.text = mealKey // Display the tag (e.g., "Fasting")
            cell.timeLabel.text = "At \(mealReading.time)" // Display the time
            cell.readingLabel.text = "\(mealReading.reading)" // Display the reading
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Get the tag (key) of the meal reading to remove
            let mealType = Array(selectedDateReadings.keys)[indexPath.row]
            
            // Remove the item from the dictionary
            selectedDateReadings.removeValue(forKey: mealType)
            
            // Delete the row from the table view with animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            // Adjust table view height after deletion
            tableViewHeightConstraint?.isActive = false
            tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: CGFloat(selectedDateReadings.count * 80))
            tableViewHeightConstraint?.isActive = true
        }
    }
    
    
    @objc func addReadingButtonTapped() {
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let vc2 = storyboard.instantiateViewController(withIdentifier: "addBloodReading") as? AddGlucoseReadingTableViewController{
            vc2.title = "Add Reading"
            vc2.delegate = self
                // Add a cancel button
                let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
                vc2.navigationItem.leftBarButtonItem = cancelButton
                    // Embed vc2 in a navigation controller
                    let navigationController = UINavigationController(rootViewController: vc2)
                    navigationController.modalPresentationStyle = .popover

                    // Present the navigation controller
                    self.present(navigationController, animated: true, completion: nil)
        }
    }
    @objc func dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }


    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3 // Number of charts
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath) as! ChartCell
        
        let chartDataEntries: [ChartDataEntry] = selectedDateReadings.values.enumerated().map { index, reading in
            ChartDataEntry(x: Double(index), y: reading.reading)
        }
        
        let titles = ["Today", "Week", "Month"]
        let title = titles[indexPath.row]
        cell.configure(with: title, data: chartDataEntries)
        
        return cell
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = round(scrollView.contentOffset.x / collectionView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    }

    // MARK: - UITableView DataSource

    
}

// MARK: - Custom UICollectionViewCell for Chart

class ChartCell: UICollectionViewCell {
    let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .boldSystemFont(ofSize: 16)
            label.textAlignment = .center
            label.textColor = .black
            return label
        }()
    let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.noDataText = "No data available"
        chartView.chartDescription.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.isUserInteractionEnabled = false
       
        //chartView.leftAxis.drawGridLinesEnabled = false
        return chartView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
               
               // Add subviews
               contentView.addSubview(titleLabel)
               contentView.addSubview(chartView)
               
               // Set up constraints
               titleLabel.translatesAutoresizingMaskIntoConstraints = false
               chartView.translatesAutoresizingMaskIntoConstraints = false
               
               NSLayoutConstraint.activate([
                   // Title Label Constraints
                   titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                   titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                   titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                   titleLabel.heightAnchor.constraint(equalToConstant: 20),
                   
                   // Chart View Constraints
                   chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                   chartView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   chartView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                   chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
               ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(with title: String, data: [ChartDataEntry]) {
           titleLabel.text = title
           let dataSet = LineChartDataSet(entries: data, label: "")
        dataSet.colors = [UIColor(hex: "#6CAB9C")]
           dataSet.circleColors = [UIColor(hex: "#6CAB9C")]
           dataSet.circleRadius = 4
           dataSet.lineWidth = 2
           let chartData = LineChartData(dataSet: dataSet)
           chartView.data = chartData
        switch title {
            case "Today":
                chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["7 AM", "10 AM", "1 PM", "4 PM", "7 PM","9 PM"])
                chartView.xAxis.granularity = 1
            case "Week":
                chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
                chartView.xAxis.granularity = 1
            case "Month":
                chartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: ["1", "8", "16", "24", "30"])
                chartView.xAxis.granularity = 1
            default:
                break
            }
       }
}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

