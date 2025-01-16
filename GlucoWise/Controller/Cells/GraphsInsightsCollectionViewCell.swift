import UIKit
import DGCharts
import Charts

class GraphsInsightsCollectionViewCell: UICollectionViewCell {
    
    // Properties for three PieChartView objects
    private var glucosePieChart: PieChartView!
    private var caloriesPieChart: PieChartView!
    private var stepsPieChart: PieChartView!
    
    // Labels for each PieChart
    private var glucoseLabel: UILabel!
    private var caloriesLabel: UILabel!
    private var stepsLabel: UILabel!
    
    // Buttons for each PieChart
    private var glucoseButton: UIButton!
    private var caloriesButton: UIButton!
    private var stepsButton: UIButton!
    
    // Summary Views for each PieChart
    private var glucoseSummaryView: UIView!
    private var caloriesSummaryView: UIView!
    private var stepsSummaryView: UIView!
    
    private var glucoseSummaryLabel: UILabel!
    private var caloriesSummaryLabel: UILabel!
    private var stepsSummaryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Set the background color of the cell to white
        self.backgroundColor = .white
        self.contentView.layer.cornerRadius = 12
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0.1, height: 2)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = true
        
        // Initialize Pie Charts
        glucosePieChart = PieChartView()
        caloriesPieChart = PieChartView()
        stepsPieChart = PieChartView()
        
        // Initialize Labels
        glucoseLabel = createLabel(withText: "Glucose")
        caloriesLabel = createLabel(withText: "Calories")
        stepsLabel = createLabel(withText: "Steps")
        
        // Initialize Buttons
        glucoseButton = createButton(action: #selector(glucoseMoreInfoTapped))
        caloriesButton = createButton(action: #selector(caloriesMoreInfoTapped))
        stepsButton = createButton(action: #selector(stepsMoreInfoTapped))
        
        // Initialize Summary Views
        glucoseSummaryView = createSummaryView()
        caloriesSummaryView = createSummaryView()
        stepsSummaryView = createSummaryView()
        
        glucoseSummaryLabel = createSummaryLabel(forView: glucoseSummaryView)
        caloriesSummaryLabel = createSummaryLabel(forView: caloriesSummaryView)
        stepsSummaryLabel = createSummaryLabel(forView: stepsSummaryView)
        
        // Setup the pie chart style
        setupPieChart(pieChart: glucosePieChart)
        setupPieChart(pieChart: caloriesPieChart)
        setupPieChart(pieChart: stepsPieChart)
        
        // Create Stacks
        let glucoseStack = createPieChartStack(pieChart: glucosePieChart, label: glucoseLabel, button: glucoseButton, summaryView: glucoseSummaryView)
        let caloriesStack = createPieChartStack(pieChart: caloriesPieChart, label: caloriesLabel, button: caloriesButton, summaryView: caloriesSummaryView)
        let stepsStack = createPieChartStack(pieChart: stepsPieChart, label: stepsLabel, button: stepsButton, summaryView: stepsSummaryView)
        
        // Main Stack
        let mainStackView = UIStackView(arrangedSubviews: [glucoseStack, caloriesStack, stepsStack])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 15
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.distribution = .fillEqually
        contentView.addSubview(mainStackView)
        
        // Apply Constraints
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Helpers
    private func createLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    private func createButton(action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("More Info ▼", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    private func createSummaryView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isHidden = true
        return view
    }
    
    private func createSummaryLabel(forView view: UIView) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 3
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
        return label
    }
    
    private func createPieChartStack(pieChart: PieChartView, label: UILabel, button: UIButton, summaryView: UIView) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: [pieChart, label, button, summaryView])
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }
    
    func setupPieChart(pieChart: PieChartView) {
        pieChart.holeColor = UIColor.clear
        pieChart.usePercentValuesEnabled = true
        pieChart.drawSlicesUnderHoleEnabled = false
        pieChart.rotationEnabled = false
        pieChart.highlightPerTapEnabled = false
        pieChart.legend.enabled = false
    }
    
    // Configure Data
    func configure(dataset: ChartDataset) {
        // Update the Pie Charts
        setPieChart(pieChart: glucosePieChart, dataPoints: dataset.glucoseChartTitle, values: dataset.glucoseChartData)
        setPieChart(pieChart: caloriesPieChart, dataPoints: dataset.caloriesChartTitle, values: dataset.caloriesChartData)
        setPieChart(pieChart: stepsPieChart, dataPoints: dataset.stepsChartTitle, values: dataset.stepsChartData)
        
        // Update the Summary Labels
        glucoseSummaryLabel.text = dataset.glucoseSummary
        caloriesSummaryLabel.text = dataset.caloriesSummary
        stepsSummaryLabel.text = dataset.stepsSummary
    }
    private func setPieChart(pieChart: PieChartView, dataPoints: [String], values: [Double]) {
        var entries: [PieChartDataEntry] = []
        
        for (_, value) in values.enumerated() {
            let entry = PieChartDataEntry(value: value, label: "") // Removed labels for cleaner presentation
            entries.append(entry)
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "") // No title
        dataSet.colors = [UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)] + [UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)] + ChartColorTemplates.material()
        dataSet.sliceSpace = 2 // Optional spacing between slices
        
        let data = PieChartData(dataSet: dataSet)
        data.setDrawValues(false) // Disable value labels
        
        pieChart.data = data
    }
    // Actions
    @objc private func glucoseMoreInfoTapped() {
        toggleSummaryView(view: glucoseSummaryView, button: glucoseButton)
    }
    
    @objc private func caloriesMoreInfoTapped() {
        toggleSummaryView(view: caloriesSummaryView, button: caloriesButton)
    }
    
    @objc private func stepsMoreInfoTapped() {
        toggleSummaryView(view: stepsSummaryView, button: stepsButton)
    }
    
    private func toggleSummaryView(view: UIView, button: UIButton) {
        let isVisible = !view.isHidden
        UIView.animate(withDuration: 0.3) {
            view.isHidden = isVisible
            button.setTitle(isVisible ? "More Info ▼" : "Less Info ▲", for: .normal)
        }
    }
}
