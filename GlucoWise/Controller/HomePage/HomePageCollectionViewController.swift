import UIKit
let glucoseDataSet = GlucoseDataSet()
let lastMealDataSet = LastMealDataSet()
let recommendedMealDataSet = RecommendedMealDataSet()
let headerHeight: CGFloat = 100

let glucoseD = ["Normal", "High", "Low"]
    let glucoseValues = [60.0, 30.0, 10.0]
    
    let calorieData = ["Protein", "Carbs", "Fat"]
    let calorieValues = [20.0, 50.0, 30.0]
    
    let stepsD = ["Walking", "Running", "Cycling"]
    let stepsValues = [40.0, 40.0, 20.0]
    
class HomePageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DailyAverageCollectionViewCellDelegate, DailyRecommendationsCollectionViewCellDelegate, TipsCollectionViewCellDelegate {
    var selectedtip: Tip = tipsData[0]
    
    let sectionNames = ["Calendar", "Daily Average", "Dietary Recommendations", "Tips", "Graph Insights"]
    
    
    
    // Example for selection states
    
    let glucoseLevels = [120, 110, 130, 150, 95]
    let mealData = [
        ("Grilled Chicken Salad", "chicken_salad", 0.7, 0.6, "Baked Salmon with Steamed Broccoli", "Baked Salmon with steamed broccoli", "salmon_broccoli")
    ]
    var selectedIndex: Int = 0
    
    let goodEmoji = UIImage(named: "goodEmoji")
    let neutralEmoji = UIImage(named: "neutralEmoji")
    let badEmoji = UIImage(named: "badEmoji")
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home Page"
        
        
        // Set welcome text
        //        welcomeLabel.text = "Welcome, Sarah"
        
        // Set up the collection view delegate and data source
        collectionView.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        print("Glucose Levels: \(glucoseLevels)")
        collectionView.register(TipsCollectionHeaderViewCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "TipsCollectionHeaderView")
        
        collectionView.register(CalenderCollectionViewCell.self, forCellWithReuseIdentifier: "CalenderCell")
        collectionView.register(DailyAverageCollectionViewCell.self, forCellWithReuseIdentifier: "DailyAverageCell")
        collectionView.register(DailyRecommendationsCollectionViewCell.self, forCellWithReuseIdentifier: "DietaryRecommendationCell")
        collectionView.register(TipsCollectionViewCell.self, forCellWithReuseIdentifier: "TipsCell")
        collectionView.register(GraphsInsightsCollectionViewCell.self, forCellWithReuseIdentifier: "GraphInsightsCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        // Set horizontal scrolling specifically for the Calendar and Tips sections
        
        collectionView.collectionViewLayout = createCompositionalLayout()
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNames.count
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count: Int
        switch section {
        case 0: count = glucoseDataSet.glucoseReadings.count
        case 1: count = 1
        case 2: count = 1
        case 3: count = tipsData.count
        case 4: count = 1
        default: count = 0
        }
        print("Number of items in section \(section): \(count)")
        return count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Toggle the selected state
        switch indexPath.section {
        case 0:
            
            // Deselect all readings
            for i in 0..<glucoseDataSet.glucoseReadings.count {
                glucoseDataSet.glucoseReadings[i].isSelected = false
            }
            
            // Mark the selected reading
            glucoseDataSet.glucoseReadings[indexPath.item].isSelected = true
            
            // Reload the collection view to reflect changes
            
            
            // Fetch and display additional details for the selected date
            let selectedReading = glucoseDataSet.glucoseReadings[indexPath.item]
            selectedIndex=indexPath.item
            collectionView.reloadData()
            print("Selected Reading: \(selectedReading)")
            
        case 1:
                // Perform actions for section 1
                print("Action for Section 1")
                let indexSet = IndexSet(integer: 1)
                collectionView.reloadSections(indexSet)
                
        case 2:
            // Perform actions for section 2
            print("Action for Section 2")
            let indexSet = IndexSet(integer: 2)
            collectionView.reloadSections(indexSet)
            
        case 3:
            // Handle Tip Selection
            guard indexPath.item < tipsData.count else {
                print("Invalid index for tipsData")
                return
            }
            
            let selectedTip = tipsData[indexPath.item]
            selectedtip = selectedTip
            
            
            print("Selected Tip: \(selectedTip.name)")
            
            // Reload only Section 3
            let indexSet = IndexSet(integer: 3)
            collectionView.reloadSections(indexSet)
                
           
            
        default:
            break
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Configuring \(sectionNames[indexPath.section]) cell at indexPath: \(indexPath)")
        
        switch indexPath.section {
        case 0:
            
            // First cell: Date and day selection
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCollectionViewCell
            let reading = glucoseDataSet.glucoseReadings[indexPath.item]
            // Extract the date components
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            if let date = dateFormatter.date(from: reading.date){
                dateFormatter.dateFormat = "E" // Day abbreviation (e.g., Mon, Tue)
                let day = dateFormatter.string(from: date)
                dateFormatter.dateFormat = "d" // Day of the month (e.g., 1, 2)
                let dayOfMonth = dateFormatter.string(from: date)
                
                cell.dayLabel?.text = day
                cell.dateLabel?.text = dayOfMonth
            }
            // Update background color based on selection state
            if reading.isSelected {
                cell.contentView.backgroundColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
                cell.dayLabel?.textColor = UIColor.white
                cell.dateLabel?.textColor = UIColor.white
            } else {
                cell.contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
                cell.dayLabel?.textColor = UIColor.lightGray
                cell.dateLabel?.textColor = UIColor.lightGray
                
            }
            let cellHeight = cell.bounds.size.height
            let cellWidth = cell.bounds.size.width
            let radius = min(cellHeight, cellWidth) / 2  // Use the smaller dimension to ensure it's circular
            cell.contentView.layer.cornerRadius = radius
            cell.contentView.clipsToBounds = true
            
            return cell
            
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyAverageCell", for: indexPath) as! DailyAverageCollectionViewCell
            cell.contentView.backgroundColor = UIColor.white
            cell.contentView.layer.cornerRadius = 12 // Rounded corners
            cell.contentView.layer.masksToBounds = true
            
            // Add shadow for better appearance
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.masksToBounds = false
            
            // Display the average in the DailyAverageCollectionViewCell
            if let selectedIndex = glucoseDataSet.glucoseReadings.firstIndex(where: { $0.isSelected }) {
                let reading = glucoseDataSet.glucoseReadings[selectedIndex]
                var emoji:String;           if(reading.change>0) {
                    emoji="⬆️"}
                else { emoji="⬇️"}
                cell.glucoseLabel?.text = "Blood Glucose Level "
                cell.glucoseValueLabel?.text = "\(reading.averageReading)"
                cell.glucoseChangeLabel?.text = "\(emoji)\(abs(reading.change))% change since last reading"
                cell.glucoseLastUppdatedLbl?.text = "Updated at \(reading.lastUpdated)"
                
                // Update reaction based on glucose levels
                if reading.averageReading > 180 {
                    cell.glucoseReactionLbl?.image = UIImage(named: "badEmoji") // Example: High glucose emoji
                } else if reading.averageReading <= 120 {
                    cell.glucoseReactionLbl?.image = UIImage(named: "goodEmoji") // Example: Low glucose emoji
                } else {
                    cell.glucoseReactionLbl?.image = UIImage(named: "neutralEmoji") // Neutral emoji for normal levels
                }
            } else {
                cell.glucoseLabel?.text = "No data available"
                cell.glucoseChangeLabel?.text = ""
                cell.glucoseLastUppdatedLbl?.text = ""
                cell.glucoseReactionLbl?.image = UIImage(named: "neutralEmoji")
                print("No data available for the selected date.")
            }
            cell.delegate = self
            //            cell.contentView.backgroundColor = UIColor.lightGray
            return cell
            
        case 2:
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DietaryRecommendationCell", for: indexPath) as! DailyRecommendationsCollectionViewCell
            cell.contentView.layer.cornerRadius = 12 // Rounded corners
            cell.contentView.layer.masksToBounds = true
            
            // Add shadow for better appearance
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.masksToBounds = false
            if let lastMeal = lastMealDataSet.getLastMeal() {
                let nextMeal = recommendedMealDataSet.getRecommendedMeal(basedOn: lastMeal.carbs)
                
                cell.lastMealImage?.text = lastMeal.emoji
                cell.lastMealLabel?.text = "Last Meal: \(lastMeal.name)"
                cell.carbsLbl?.text = "Carbs:"
                cell.carbsPointer?.progress = Float(lastMeal.carbs) / 100.0
                
                if let nextMeal = nextMeal {
                    cell.nextMealImage?.text = nextMeal.emoji
                    cell.recommendedNextMealLabel?.text = "Recommended Meal"
                    cell.nextMealRecommendation?.text = nextMeal.name
                    cell.gIlbl?.text = "GI:"
                    cell.GIPointer?.progress = Float(nextMeal.glycemicIndex) / 100.0
                } else {
                    cell.nextMealRecommendation?.text = "No more recommendations available"
                }
            } else {
                cell.recommendedNextMealLabel?.text = "No previous meal available"
            }
            cell.delegate = self
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipsCell", for: indexPath) as! TipsCollectionViewCell
            
            
            let tip = tipsData[indexPath.item]
            
            // Assuming tipsData is an array with the tip data
            let glucoseLevel = glucoseLevels[indexPath.item]// Replace this with the actual glucose level from your data
            
            // Setting up the UI elements in the cell
            cell.tipTitleLabel?.text = tip.name // Set the tip name
            cell.tipDescriptionLabel?.text = tip.description // Set the tip description
            cell.tipImageView?.image = UIImage(named: tip.imageName) // Set the image for the tip
            
            // Example button action
            cell.actionNameBtn?.setTitle(tip.buttonText, for: .normal) // Set the button title
            
            // Set the glucose reaction emoji (based on the glucose level)
            if glucoseLevel < 80 {
                cell.tipImageView?.image = UIImage(named: "badEmoji") // Update image based on glucose level
            } else if glucoseLevel >= 80 && glucoseLevel <= 140 {
                cell.tipImageView?.image = UIImage(named: "goodEmoji") // Update image based on glucose level
            } else {
                cell.tipImageView?.image = UIImage(named: "neutralEmoji") // Update image based on glucose level
            }
            cell.delegate=self
            // Return the populated cell
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphInsightsCell", for: indexPath) as! GraphsInsightsCollectionViewCell
            
            cell.configure(dataset: exampleDataset)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) in
            var section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0: // Calendar Section (Horizontal Scrolling)
                let itemSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0 / 7), // Seven items, each takes 1/7th of the available width
                    heightDimension: .absolute(60) // Set a fixed height for the cells
                )
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                // Define the size for the group (this group will hold all 7 items in one row)
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0), // Use full width for the group
                    heightDimension: .absolute(50) // Height remains constant
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: [item, item, item, item, item, item, item] // Seven items in one row
                )
                group.interItemSpacing = NSCollectionLayoutSpacing.fixed(5)
                // Define the section and set the group
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                
            case 1: // Daily Average Cell
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))  // Full width and 120 height
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 50, leading: 5, bottom: 5, trailing: 5)
                
                
                // Dietary Recommendations Cell
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 5, trailing: 5)
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15)
                section.boundarySupplementaryItems = [header]
                
                
            case 3: // Tips Cell (Horizontal Scrolling)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(250))  // Adjust height and width as needed for tips
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))  // Full width, fixed height for tips cell
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0  // Spacing between items
                section.orthogonalScrollingBehavior = .continuous  // Horizontal scrolling for the tips section
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                header.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15)
                section.boundarySupplementaryItems = [header]
                
            case 4: // Graph Insight Cell
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))  // Adjust height and width to fit 3 items horizontally
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                // Group with horizontal arrangement of items
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250))  // Full width, fixed height for the group
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item, item])  // Three items per row (glucose, calories, steps)
                
                // Section with the group
                section = NSCollectionLayoutSection(group: group)
                
                section.interGroupSpacing = 10  // Set spacing between items
                section.orthogonalScrollingBehavior = .none // Adjust spacing as needed
                let headerSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(50)
                )
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 5, trailing: 15)
                section.boundarySupplementaryItems = [header]
                
            default:
                fatalError("Invalid Section Index")
            }
            func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
                return CGSize(width: collectionView.bounds.width, height: 50)  // Set header height
            }
            return section
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TipsCollectionHeaderView", for: indexPath)
            
            // Configure the header view based on the section
            let label = UILabel(frame: headerView.bounds)
            label.text = sectionNames[indexPath.section]
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
            headerView.addSubview(label)
            
            return headerView
        }
        
        return UICollectionReusableView()
        
        
    }
    func didTapInsightsButton() {
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let insightsVC = storyboard.instantiateViewController(withIdentifier: "insights") as? InsightsViewController {
            print("Selected Reading Index: \(self.selectedIndex)")
            insightsVC.selectedReadingIndex = self.selectedIndex
            insightsVC.selectedReadingIndex? = self.selectedIndex
            insightsVC.title = "Insights"
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.pushViewController(insightsVC, animated: true)
            
        } else {
            print("ViewController with ID 'insights' not found.")
        }
    }
    func didTapOnViewRecipieButton(){
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let recipieVC = storyboard.instantiateViewController(withIdentifier: "recipie") as? RecipeViewController {
            recipieVC.title="Recipie"
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.pushViewController(recipieVC, animated: true)
        }
        
        else {
            print("ViewController with ID 'recipie' not found.")
        }
    }
    func didTapActionButton(){
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let tipsVC = storyboard.instantiateViewController(withIdentifier: "tips") as? TipsViewController {
            tipsVC.title="Tips"
            tipsVC.tip=self.selectedtip
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.prefersLargeTitles = false
            navigationController?.pushViewController(tipsVC, animated: true)
        }
        
        else {
            print("ViewController with ID 'tips' not found.")
        }
    }
}
