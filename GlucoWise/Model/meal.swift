//
//  meal.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 1/15/25.
//

// Meal struct to include a link to the recipe
struct Meal {
    let name: String
    let calories: Int
    let carbs: Float
    let glycemicIndex: Float
    let emoji: String
    let recipeLink: String
}

// MealDataSet for Last Meals
class LastMealDataSet {
    private let lastMeals: [Meal] = [
        Meal(name: "Grilled Chicken Salad", calories: 200, carbs: 5, glycemicIndex: 20, emoji: "🥗", recipeLink: "https://www.example.com/grilled-chicken-salad"),
        Meal(name: "Avocado Toast", calories: 250, carbs: 15, glycemicIndex: 30, emoji: "🥑", recipeLink: "https://www.example.com/avocado-toast")
        // Add more last meal entries as needed
    ]
    
    func getLastMeal() -> Meal? {
        return lastMeals.last
    }
}

// MealDataSet for Recommended Meals
class RecommendedMealDataSet {
    private let recommendedMeals: [Meal] = [
        Meal(name: "Vegetable Stir Fry", calories: 300, carbs: 25, glycemicIndex: 40, emoji: "🥦", recipeLink: "https://www.example.com/vegetable-stir-fry"),
        Meal(name: "Pasta Primavera", calories: 400, carbs: 50, glycemicIndex: 45, emoji: "🍝", recipeLink: "https://www.example.com/pasta-primavera")
        // Add more recommended meal entries as needed
    ]
    
    func getRecommendedMeal(basedOn carbs: Float) -> Meal? {
        let filteredMeals = getRecommendedMeals(basedOn: carbs)
        return filteredMeals.first
    }
    
    func getRecommendedMeals(basedOn carbs: Float) -> [Meal] {
        if carbs < 30 {
            return recommendedMeals.filter { $0.carbs < 30 } // Low-carb meals
        } else if carbs < 50 {
            return recommendedMeals.filter { $0.carbs >= 30 && $0.carbs < 50 } // Moderate-carb meals
        } else {
            return recommendedMeals.filter { $0.carbs >= 50 } // High-carb meals
        }
    }
}
