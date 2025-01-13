//
//  DailyRecommendationsCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit

class DailyRecommendationsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lastMealLabel: UILabel!
    @IBOutlet weak var carbsLbl: UILabel!
    @IBOutlet weak var carbsPointer: UIProgressView!
    @IBOutlet weak var gIlbl: UILabel!
    @IBOutlet weak var GIPointer: UIProgressView!
    @IBOutlet weak var lastMealImage: UIImageView!
    @IBOutlet weak var recommendedNextMealLabel: UILabel!
    @IBOutlet weak var nextMealRecommendation: UILabel!
    @IBOutlet weak var nextMealImage: UIImageView!
    
    
    
   @IBAction func recipieButtonClicked(_ sender: UIButton) {
       print("Recipe button clicked for recommended meal: \(recommendedNextMealLabel.text ?? "Unknown")")
       
    }
   
        func configure(
            lastMeal: String,
            lastMealImageName: String,
            carbs: Float,
            gi: Float,
            recommendedMeal: String,
            recommendedMealDetails: String,
            recommendedMealImageName: String
        ) {
            // Set Last Meal Info
            lastMealLabel?.text = "Last Meal: \(lastMeal)"
            lastMealImage?.image = UIImage(named: lastMealImageName)

            // Set Carbs and GI Progress
            carbsLbl?.text = "Carbs"
            carbsPointer?.progress = carbs
            gIlbl?.text = "G.I."
            GIPointer?.progress = gi

            // Set Recommended Meal Info
            recommendedNextMealLabel?.text = "Recommended Next Meal"
            nextMealRecommendation?.text = recommendedMealDetails
            nextMealImage?.image = UIImage(named: recommendedMealImageName)
        }
    
    
    
    
}
