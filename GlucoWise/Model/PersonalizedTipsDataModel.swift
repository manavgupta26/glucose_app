//
//  personalizedTipsDataModel.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/18/24.
//

import Foundation

// MARK: - Data Models

// Represents personalized health data
struct PersonalizedHealthData {
    var hbA1c: Double         // HbA1c percentage
    var sugarLevels: [Double] // Recent blood sugar levels in mg/dL
    var workout: String?      // Optional workout description
    var diet: [String]        // List of food items consumed recently
}

// Represents a health tip
struct HealthTip {
    var category: String      // Category of the tip (e.g., "Diet", "Exercise", "Lifestyle")
    var message: String       // The actual tip content
}

// MARK: - Health Tips Manager

class PersonalizedTipsManager {
    private var userHealthData: [PersonalizedHealthData] = []
    
    // Add user health data
    func addHealthData(_ data: PersonalizedHealthData) {
        userHealthData.append(data)
    }
    
    // Generate tips based on HbA1c levels
    private func generateHbA1cTips(hbA1c: Double) -> [HealthTip] {
        if hbA1c > 7.0 {
            return [
                HealthTip(category: "Lifestyle", message: "Your HbA1c levels are above the recommended range. Consider consulting your doctor."),
                HealthTip(category: "Diet", message: "Focus on reducing carbohydrate intake and opt for foods with a lower glycemic index.")
            ]
        } else {
            return [HealthTip(category: "General", message: "Your HbA1c levels are in a healthy range. Keep up the good work!")]
        }
    }
    
    // Generate tips based on recent sugar levels
    private func generateSugarLevelTips(sugarLevels: [Double]) -> [HealthTip] {
        guard !sugarLevels.isEmpty else {
            return [HealthTip(category: "General", message: "No recent sugar levels recorded. Please track your levels regularly.")]
        }
        
        let averageSugar = sugarLevels.reduce(0, +) / Double(sugarLevels.count)
        
        if averageSugar > 180 {
            return [HealthTip(category: "Diet", message: "Your average blood sugar is high. Limit sugary foods and include more fiber in your meals.")]
        } else if averageSugar < 70 {
            return [HealthTip(category: "Safety", message: "Your blood sugar is low. Always keep a quick source of glucose, such as candy or juice, nearby.")]
        } else {
            return [HealthTip(category: "General", message: "Your blood sugar levels are within the normal range. Keep tracking regularly.")]
        }
    }
    
    // Generate tips based on workout
    private func generateWorkoutTips(workout: String?) -> [HealthTip] {
        guard let workout = workout, !workout.isEmpty else {
            return [HealthTip(category: "Exercise", message: "Incorporate at least 30 minutes of exercise into your daily routine.")]
        }
        
        return [HealthTip(category: "Exercise", message: "Good job on your recent workout: \(workout). Keep it consistent for better results.")]
    }
    
    // Generate tips based on diet
    private func generateDietTips(diet: [String]) -> [HealthTip] {
        if diet.contains(where: { $0.lowercased() == "sugar" || $0.lowercased().contains("sweet") }) {
            return [HealthTip(category: "Diet", message: "Reduce your sugar intake to help stabilize blood glucose levels.")]
        }
        
        if diet.isEmpty {
            return [HealthTip(category: "Diet", message: "No food data recorded. Make sure to log your meals for better insights.")]
        }
        
        return [HealthTip(category: "Diet", message: "Your recent meals look good. Focus on balanced portions of protein, carbs, and fats.")]
    }
    
    // Generate all personalized tips for a user
    func generatePersonalizedTips() -> [HealthTip] {
        // Assuming we are generating tips for all users' data
        var tips: [HealthTip] = []
        
        for userData in userHealthData {
            tips.append(contentsOf: generateHbA1cTips(hbA1c: userData.hbA1c))
            tips.append(contentsOf: generateSugarLevelTips(sugarLevels: userData.sugarLevels))
            tips.append(contentsOf: generateWorkoutTips(workout: userData.workout))
            tips.append(contentsOf: generateDietTips(diet: userData.diet))
        }
        
        return tips
    }
}
