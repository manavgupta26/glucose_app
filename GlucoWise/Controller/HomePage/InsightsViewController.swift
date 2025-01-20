import UIKit
import DGCharts
class InsightsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let detailedSummaryLabel = UILabel()
    let chartView = LineChartView()
    var selectedReadingIndex: Int? // Store the index of the selected reading
    let glucoseDataSet = GlucoseDataSet() // Initialize dataset
    let readingsTableView = UITableView(frame: .zero, style: .grouped)
    let cardView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        setupScrollView()
        // Set up the view's background
        view.backgroundColor = UIColor.systemGray6
        
        readingsTableView.register(GlucoseReadingCell.self, forCellReuseIdentifier: "GlucoseReadingCell")


        // Fetch the selected glucose reading using the selected ind
        
        if let selectedReadingIndex = selectedReadingIndex,
           selectedReadingIndex >= 0, selectedReadingIndex < glucoseDataSet.glucoseReadings.count {
            let selectedReading = glucoseDataSet.glucoseReadings[selectedReadingIndex]
            setupAverageBloodGlucoseView(using: selectedReading)
            setupGraphView(using: selectedReading) // Add this line
            setupReadingsTableView()
            
        } else {
            print("Invalid or no selected reading index found!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard let selectedReadingIndex = selectedReadingIndex else { return 0 }
            return glucoseDataSet.glucoseReadings[selectedReadingIndex].readingsByMeal.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GlucoseReadingCell", for: indexPath) as? GlucoseReadingCell else {
                return UITableViewCell()
            }
            
            // Fetch the reading data
            guard let selectedReadingIndex = selectedReadingIndex else { return cell }
            let keys = Array(glucoseDataSet.glucoseReadings[selectedReadingIndex].readingsByMeal.keys)
            let key = keys[indexPath.row]
            
            if let dailyReading = glucoseDataSet.glucoseReadings[selectedReadingIndex].readingsByMeal[key] {
                let formattedTime = dailyReading.time.prefix(5) // Extract HH:mm format
                cell.tagLabel.text = key // Tag (title)
                cell.timeLabel.text = "Time: \(formattedTime)" // Time (subtitle)
                cell.valueLabel.text = "\(dailyReading.reading) mg/dL" // Value
            }
            
            return cell
        }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Readings"
    }

    
    
    
    
    //scroll view
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Keep this
            contentView.heightAnchor.constraint(equalToConstant: 3000) // Ensure enough height for content to scroll
        ])

    }


    
    // Set up the average blood glucose view
    func setupAverageBloodGlucoseView(using reading: GlucoseReading) {
        // Card Container
        contentView.addSubview(cardView)
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 12
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.1
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        
        contentView.addSubview(cardView)
        // Constraints for Card View
        cardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:0),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            cardView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // Average Blood Glucose Title
        let titleLabel = UILabel()
        titleLabel.text = "Average Blood Glucose Level"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        titleLabel.textColor = UIColor.label
        cardView.addSubview(titleLabel)
        
        // Constraints for Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ])
        
        // Glucose Value Label
        let glucoseValueLabel = UILabel()
        glucoseValueLabel.text = "\(reading.averageReading) mg/dL" // Now uses Int for averageReading
        glucoseValueLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        glucoseValueLabel.textColor = .black
        cardView.addSubview(glucoseValueLabel)
        
        // Constraints for Glucose Value Label
        glucoseValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            glucoseValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            glucoseValueLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 12)
        ])
        
        // Change Indicator (e.g., "+5% since yesterday")
        let changeLabel = UILabel()
        if(reading.change > 0){
            changeLabel.text="⬇︎  \(reading.change) since yesterday"
        }
        else{
            changeLabel.text="⬆︎  \(reading.change) since yesterday"
        }
        
        changeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        changeLabel.textColor =  UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        cardView.addSubview(changeLabel)
        
        // Constraints for Change Label
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            changeLabel.topAnchor.constraint(equalTo: glucoseValueLabel.bottomAnchor, constant: 25),
            changeLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16)
        ])
        
        // Timestamp Label
        let timestampLabel = UILabel()
        timestampLabel.text = "Updated at \(reading.lastUpdated.split(separator: " ")[1])"
        timestampLabel.font = UIFont.systemFont(ofSize: 12, weight: .light)
        timestampLabel.textColor = UIColor.secondaryLabel
        cardView.addSubview(timestampLabel)
        
        // Constraints for Timestamp Label
        timestampLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timestampLabel.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 4),
            timestampLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            timestampLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardView.bottomAnchor, constant: -16)
        ])
        
        // Emoji or Avatar Image
        let emojiImageView = UIImageView()
        if(reading.averageReading < 120){
            emojiImageView.image = UIImage(named: "goodEmoji")
        }
        else if(reading.averageReading < 180){
            emojiImageView.image = UIImage(named: "neutralEmoji")
        }
        else{
            emojiImageView.image = UIImage(named: "badEmoji")
        }
        
        emojiImageView.contentMode = .scaleAspectFit
        cardView.addSubview(emojiImageView)
        
        // Constraints for Emoji Image View
        emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emojiImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            emojiImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            emojiImageView.widthAnchor.constraint(equalToConstant: 120),
            emojiImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    
    func getFormattedReading(for indexPath: IndexPath) -> String? {
            guard let selectedReadingIndex = selectedReadingIndex else { return nil }
            let keys = Array(glucoseDataSet.glucoseReadings[selectedReadingIndex].readingsByMeal.keys)
            let key = keys[indexPath.row]
            if let dailyReading = glucoseDataSet.glucoseReadings[selectedReadingIndex].readingsByMeal[key] {
                let formattedTime = dailyReading.time.prefix(5) // Extract HH:mm format
                return "Time: \(formattedTime), Value: \(dailyReading.reading) mg/dL"
            }
            return nil
        }
        
        func setupReadingsTableView() {
            let sectionHeader = UIView()
                   sectionHeader.backgroundColor = .white
                   let headerLabel = UILabel()
                   headerLabel.text = "Readings"
                   headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
                   sectionHeader.addSubview(headerLabel)
                   headerLabel.translatesAutoresizingMaskIntoConstraints = false
                   NSLayoutConstraint.activate([
                       headerLabel.centerXAnchor.constraint(equalTo: sectionHeader.centerXAnchor),
                       headerLabel.centerYAnchor.constraint(equalTo: sectionHeader.centerYAnchor)
                   ])

                   contentView.addSubview(readingsTableView)
            readingsTableView.delegate = self
            readingsTableView.dataSource = self
            readingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReadingCell")
            readingsTableView.backgroundColor = .clear
            contentView.addSubview(readingsTableView)
            
            // Adjust constraints to place table below the graph
            readingsTableView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                readingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 440), // Adjusted to be below the graph
                readingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                readingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                readingsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
                readingsTableView.heightAnchor.constraint(equalToConstant: 150)
            ])
        }
    func setupGraphView(using reading: GlucoseReading) {
        contentView.addSubview(chartView)
        chartView.backgroundColor = .white
        chartView.layer.cornerRadius = 14
        chartView.legend.enabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        contentView.addSubview(chartView)
        chartView.isUserInteractionEnabled = false
        // Set constraints
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            chartView.heightAnchor.constraint(equalToConstant: 200)
        ])
        let keys=Array(reading.readingsByMeal.keys)
        // Configure chart data (example)
        
        var dataEntries: [ChartDataEntry] = []
        var timeStrings: [String] = [] // To hold formatted time strings
        var i = 0 // Initialize i outside the loop
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // 24-hour time format
        
        for key in keys {
            let dailyReading = reading.readingsByMeal[key]
            if let readingValue = dailyReading?.reading {
                // Assuming i is in minutes
                guard let timeString=dailyReading?.time.prefix(5) else { return  } // Convert to formatted string
                dataEntries.append(ChartDataEntry(x: Double(i), y: readingValue))
                
                // Append the formatted time to the timeStrings array
                timeStrings.append(String(timeString))
                
                i += 1
            }
        }
        
        // Assuming you are using a chart view (e.g., LineChartView) from the Charts library
        let xAxis = chartView.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: timeStrings) // Set x-axis labels with timeStrings
        
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "")
        dataSet.colors = [UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)]
        print(timeStrings)
        
        dataSet.drawCircleHoleEnabled = false
        
        dataSet.circleRadius = 0
        
        let chartData = LineChartData(dataSet: dataSet)
        chartView.data = chartData
    }
    func setupDailySummaryView(using reading: GlucoseReading) {
        // Card Container for Insights
        let insightsCardView = UIView()
        insightsCardView.backgroundColor = .white
        insightsCardView.layer.cornerRadius = 12
        insightsCardView.layer.shadowColor = UIColor.black.cgColor
        insightsCardView.layer.shadowOpacity = 0.1
        insightsCardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        insightsCardView.layer.shadowRadius = 4
    
        scrollView.addSubview(insightsCardView)
        
        // Constraints for Insights Card View
        insightsCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            insightsCardView.topAnchor.constraint(equalTo: readingsTableView.bottomAnchor, constant: 16),
            insightsCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            insightsCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            insightsCardView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        // Title Label for Insights
        let insightsTitleLabel = UILabel()
        insightsTitleLabel.text = "Glucose Level Insights"
        insightsTitleLabel.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        insightsTitleLabel.textColor = UIColor.label
        insightsCardView.addSubview(insightsTitleLabel)
        
        // Constraints for Insights Title Label
        insightsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            insightsTitleLabel.topAnchor.constraint(equalTo: insightsCardView.topAnchor, constant: 16),
            insightsTitleLabel.leadingAnchor.constraint(equalTo: insightsCardView.leadingAnchor, constant: 16)
        ])
        
        // Insight Text Based on Glucose Data
        let insightsTextLabel = UILabel()
        insightsTextLabel.numberOfLines = 0
        insightsTextLabel.textColor = UIColor.secondaryLabel
        insightsTextLabel.font = UIFont.systemFont(ofSize: 16)
        
        // Example of generating insights based on readings
        if reading.averageReading < 100 {
            insightsTextLabel.text = "Your glucose levels are within a healthy range today. Keep it up!"
        } else if reading.averageReading < 180 {
            insightsTextLabel.text = "Your glucose levels are slightly elevated. Monitor your diet and activity levels."
        } else {
            insightsTextLabel.text = "Your glucose levels are high. Consider reviewing your medication or consult with your healthcare provider."
        }

        insightsCardView.addSubview(insightsTextLabel)
        
        // Constraints for Insights Text Label
        insightsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            insightsTextLabel.topAnchor.constraint(equalTo: insightsTitleLabel.bottomAnchor, constant: 8),
            insightsTextLabel.leadingAnchor.constraint(equalTo: insightsCardView.leadingAnchor, constant: 16),
            insightsTextLabel.trailingAnchor.constraint(equalTo: insightsCardView.trailingAnchor, constant: -16),
            insightsTextLabel.bottomAnchor.constraint(equalTo: insightsCardView.bottomAnchor, constant: -16)
        ])
    }

    
}
        
class GlucoseReadingCell: UITableViewCell {
    // UI elements
    let tagLabel = UILabel()
    let timeLabel = UILabel()
    let valueLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configure the tag label
        tagLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tagLabel.textColor = UIColor.label
        
        // Configure the time label
        timeLabel.font = UIFont.systemFont(ofSize: 14)
        timeLabel.textColor = UIColor.secondaryLabel
        
        // Configure the value label
        valueLabel.font = UIFont.boldSystemFont(ofSize: 16)
        valueLabel.textColor = UIColor.label
        valueLabel.textAlignment = .right
        
        // Add the labels to the cell's content view
        contentView.addSubview(tagLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(valueLabel)
        
        // Set up constraints
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Tag label (title) constraints
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tagLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8),
            
            // Time label (subtitle) constraints
            timeLabel.topAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: 4),
            timeLabel.leadingAnchor.constraint(equalTo: tagLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(lessThanOrEqualTo: valueLabel.leadingAnchor, constant: -8),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // Value label constraints
            valueLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
