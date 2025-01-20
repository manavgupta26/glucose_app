struct ChartDataset {
    let glucoseChartTitle:[String]
    let glucoseChartData: [Double]
    let glucoseData: [String]
    let glucoseValues: [Double]
    let glucoseSummary: String
    
    let caloriesChartTitle:[String]
    let caloriesChartData: [Double]
    let caloriesData: [String]
    let caloriesValues: [Double]
    let caloriesSummary: String
    
    let stepsChartTitle:[String]
    let stepsChartData: [Double]
    let stepsData: [String]
    let stepsValues: [Double]
    let stepsSummary: String
}
class GraphData{
    // Example Dataset
    private let exampleDataset = ChartDataset(
        glucoseChartTitle: ["Within goal","goal"],
        glucoseChartData: [20,80],
        glucoseData: ["Breakfast", "Lunch", "Dinner", "Snacks"],
        glucoseValues: [120.0, 150.0, 130.0, 80.0],
        glucoseSummary: """
    - Breakfast: 120 mg/dL
    - Lunch: 150 mg/dL
    - Dinner: 130 mg/dL
    - Snacks: 80 mg/dL
    """,
        
        caloriesChartTitle: ["Calories","Calories left"],
        caloriesChartData: [1500.0,1000],
        caloriesData: ["Protein", "Carbs", "Fat"],
        caloriesValues: [25.0, 50.0, 25.0],
        caloriesSummary: """
    - Protein: 25% of total calories
    - Carbs: 50% of total calories
    - Fat: 25% of total calories
    """,
        
        stepsChartTitle: ["Steps Taken","Goal steps left"],
        stepsChartData: [1200,800],
        stepsData: ["Morning", "Afternoon", "Evening"],
        stepsValues: [3000, 4000, 2000],
        stepsSummary: """
    - Morning: 3,000 steps
    - Afternoon: 4,000 steps
    - Evening: 2,000 steps
    """
    )
    private init(){}
    static let shared = GraphData()
    func getExampleDataset() -> ChartDataset {
        return exampleDataset
    }
}
