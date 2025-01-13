import UIKit

class HomePageCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let sectionNames = ["Calendar", "Daily Average", "Dietary Recommendations", "Tips", "Graph Insights"]
    
    
    
    var days: [String] = ["M", "T", "W", "T", "F", "St", "S"]
    var dates: [String] = ["1", "2", "3", "4", "5", "6", "7"] // Example dates for the week
    var selectedStates: [Bool] = [false, false, false, true, false, false, false] // Example for selection states
    
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
        print("Days: \(days)")
        print("Dates: \(dates)")
        print("Glucose Levels: \(glucoseLevels)")
        collectionView.register(CalenderCellCollectionViewCell.self, forCellWithReuseIdentifier: "CalenderCell")
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
        case 0: count = days.count
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
        for index in selectedStates.indices {
                    selectedStates[index] = false
                }
                
                // Select the tapped item
            selectedStates[indexPath.item] = true
                
                // Reload the collection view to update the appearance
            collectionView.reloadData()

    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Configuring \(sectionNames[indexPath.section]) cell at indexPath: \(indexPath)")

        switch indexPath.section {
        case 0:
            
            // First cell: Date and day selection
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalenderCell", for: indexPath) as! CalenderCellCollectionViewCell
            let day = days[indexPath.item]
            let date = dates[indexPath.item]
            let isSelected = selectedStates[indexPath.item]
            
            cell.dayLabel?.text = day
            cell.dateLabel?.text = date
            
            // Update background color based on selection state
            if isSelected {
                cell.contentView.backgroundColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
                cell.dayLabel?.textColor = UIColor.white
                cell.dateLabel?.textColor = UIColor.white
            } else {
                cell.contentView.backgroundColor = UIColor.systemBackground
                cell.dayLabel?.textColor = UIColor.label
                cell.dateLabel?.textColor = UIColor.label
            }
            
            let cellHeight = cell.bounds.size.height
            let cellWidth = cell.bounds.size.width
            let radius = min(cellHeight, cellWidth) / 2  // Use the smaller dimension to ensure it's circular
            cell.contentView.layer.cornerRadius = radius
            cell.contentView.clipsToBounds = true
            
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyAverageCell", for: indexPath) as! DailyAverageCollectionViewCell
            let glucoseLevel = glucoseLevels[selectedIndex]
            cell.glucoseLabel?.text = "\(glucoseLevel)"
            cell.glucoseChangeLabel?.text = "5% since yesterday"
            cell.glucoseLastUppdatedLbl?.text = "Updated at 8:00 AM"
            if glucoseLevel < 80 {
                cell.glucoseReactionLbl?.image = badEmoji
            } else if glucoseLevel >= 80 && glucoseLevel <= 140 {
                cell.glucoseReactionLbl?.image = goodEmoji
            } else {
                cell.glucoseReactionLbl?.image = neutralEmoji
            }
            return cell
            
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DietaryRecommendationCell", for: indexPath) as! DailyRecommendationsCollectionViewCell
            let lastMeal = "Grilled Chicken Salad"
            let lastMealImageName = "chicken_salad" // Add this image to Assets.xcassets
            let carbs: Float = 0.7 // Progress between 0.0 and 1.0
            let gi: Float = 0.6 // Progress between 0.0 and 1.0
            let recommendedMeal = "Baked Salmon with Steamed Broccoli"
            let recommendedMealDetails = "Baked Salmon with steamed broccoli"
            let recommendedMealImageName = "salmon_broccoli" // Add this image to Assets.xcassets
            
            // Configure the Cell
            cell.configure(
                lastMeal: lastMeal,
                lastMealImageName: lastMealImageName,
                carbs: carbs,
                gi: gi,
                recommendedMeal: recommendedMeal,
                recommendedMealDetails: recommendedMealDetails,
                recommendedMealImageName: recommendedMealImageName
            )
            
            return cell
            
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TipsCell", for: indexPath) as! TipsCollectionViewCell
            
            
            let tip = tipsData[indexPath.item] // Assuming tipsData is an array with the tip data
            let glucoseLevel = glucoseLevels[indexPath.item]// Replace this with the actual glucose level from your data
            
            // Setting up the UI elements in the cell
            cell.tipsNameLbl?.text = tip.name // Set the tip name
            cell.tipsDescriptionLbl?.text = tip.description // Set the tip description
            cell.tipsImage?.image = UIImage(named: tip.imageName) // Set the image for the tip
            
            // Example button action
            cell.actionNameBtn?.setTitle(tip.buttonText, for: .normal) // Set the button title
            
            // Set the glucose reaction emoji (based on the glucose level)
            if glucoseLevel < 80 {
                cell.tipsImage?.image = UIImage(named: "badEmoji") // Update image based on glucose level
            } else if glucoseLevel >= 80 && glucoseLevel <= 140 {
                cell.tipsImage?.image = UIImage(named: "goodEmoji") // Update image based on glucose level
            } else {
                cell.tipsImage?.image = UIImage(named: "neutralEmoji") // Update image based on glucose level
            }
            
            // Return the populated cell
            return cell
            
        case 4:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphInsightsCell", for: indexPath) as! GraphsInsightsCollectionViewCell
            
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
                
                // Define the section and set the group
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 0
                
            case 1: // Daily Average Cell
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))  // Adjust height as needed
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))  // Full width, fixed height for daily average cell
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10  // Adjust spacing between items in the group
                
            case 2: // Dietary Recommendations Cell
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))  // Adjust height as needed
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(150))  // Full width, fixed height for dietary recommendations
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10  // Adjust spacing between items in the group
                
            case 3: // Tips Cell (Horizontal Scrolling)
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(100))  // Adjust height and width as needed for tips
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))  // Full width, fixed height for tips cell
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10  // Spacing between items
                section.orthogonalScrollingBehavior = .continuous  // Horizontal scrolling for the tips section
                
            case 4: // Graph Insight Cell
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(100))  // Adjust height as needed
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))  // Full width, height 1/4 of the screen
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10  // Adjust spacing as needed
                
            default:
                fatalError("Invalid Section Index")
            }
            return section
        }
        
    }
}
