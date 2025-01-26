
import Foundation
import UIKit


// Food item struct
struct FoodItem {
    var name: String
    var quantity: Double
    var quantityType: QuantityType
    var protein: Double
    var fiber: Double
    var carbs: Double
    var fats: Double
    var calories: Double
    var glycemicIndex: Double
    var gl: Double {
        return (glycemicIndex * carbs) / 100.0
    }
    var giProgress: Double {
           return glycemicIndex / 100.0 // GI is typically on a scale of 0 to 100
       }

       var glProgress: Double {
           let maxGL = 30.0 // Define a realistic upper threshold for GL
           return min(gl / maxGL, 1.0) // Normalize and cap at 1.0 (100%)
       }
}

// Quantity type enum
enum QuantityType: String {
    case grams, spoon, bowl, piece, ml // Add more as needed
}

// Meal type enum
enum MealType: String {
    case breakfast, lunch, snacks, dinner
}

class MealDataModel {
    // Dictionary to hold meal data
    static let shared = MealDataModel()
    private var userMeals: [Date: [MealType: [FoodItem]]] = [
        Date(): [
            .breakfast: [
                FoodItem(
                    name: "Oats",
                    quantity: 50,
                    quantityType: .grams,
                    protein: 5.0,
                    fiber: 4.0,
                    carbs: 30.0,
                    fats: 2.0,
                    calories: 150,
                    glycemicIndex: 55
                ),
                FoodItem(
                    name: "Banana",
                    quantity: 1,
                    quantityType: .piece,
                    protein: 1.3,
                    fiber: 2.6,
                    carbs: 27.0,
                    fats: 0.3,
                    calories: 105,
                    glycemicIndex: 51
                )
            ],
            .lunch: [
                FoodItem(
                    name: "Rajma Curry",
                    quantity: 150,
                    quantityType: .grams,
                    protein: 31.0,
                    fiber: 0.0,
                    carbs: 0.0,
                    fats: 3.6,
                    calories: 165,
                    glycemicIndex: 0
                ),
                FoodItem(
                    name: "Fried Rice",
                    quantity: 100,
                    quantityType: .grams,
                    protein: 2.6,
                    fiber: 1.8,
                    carbs: 23.0,
                    fats: 0.9,
                    calories: 110,
                    glycemicIndex: 50
                )
            ],
            .snacks: [
                FoodItem(
                    name: "Almonds",
                    quantity: 30,
                    quantityType: .grams,
                    protein: 6.0,
                    fiber: 3.5,
                    carbs: 6.0,
                    fats: 14.0,
                    calories: 160,
                    glycemicIndex: 15
                )
            ],
            .dinner: [
                FoodItem(
                    name: "Yellow Dal",
                    quantity: 100,
                    quantityType: .grams,
                    protein: 25.0,
                    fiber: 0.0,
                    carbs: 0.0,
                    fats: 13.0,
                    calories: 208,
                    glycemicIndex: 0
                ),
                FoodItem(
                    name: "Chappati",
                    quantity: 150,
                    quantityType: .grams,
                    protein: 2.0,
                    fiber: 3.0,
                    carbs: 10.0,
                    fats: 0.5,
                    calories: 50,
                    glycemicIndex: 15
                )
            ]
        ]
    ]
    private init(){}
    func getUserMeals() -> [Date: [MealType: [FoodItem]]]? {
            return userMeals
        }
    func addFoodItem(date: Date, mealType: MealType, foodItem: FoodItem) {
          if userMeals[date] == nil {
              // If no meals exist for the given date, create a new entry for all meal types
              userMeals[date] = [
                  .breakfast: [],
                  .lunch: [],
                  .snacks: [],
                  .dinner: []
              ]
          }
          
          // Add the food item to the specified meal type for the given date
          userMeals[date]?[mealType]?.append(foodItem)
      }
}


















//

//
//
//// Meal structure
//struct Meal {
//    var userId: Int              // User ID associated with the meal
//    var type: MealType           // Meal type (e.g., breakfast, lunch)
//    var selectedFoods: [FoodItem] // List of food items in the meal
//    var date: Date               // Date of the meal
//}
//
//// MealDataModel class
//class MealDataModel {
//    private var usersMeals: [Int: [Date: [MealType: [FoodItem]]]] = [:]
//    static var shared = MealDataModel(usersMeals: [:], foodItemsDatabase: [])
//
//    private var foodItemsDatabase: [FoodItem] = [
//        FoodItem(name: "Halwa", quantity: 100, quantityType: .grams, protein: 1.2, fiber: 0.8, carbs: 31, fats: 11, calories: 215, glycemicIndex: 55),
//        FoodItem(name: "Paratha", quantity: 100, quantityType: .grams, protein: 5.1, fiber: 3.4, carbs: 36, fats: 10, calories: 297, glycemicIndex: 62),
//        FoodItem(name: "Dahi (Curd)", quantity: 100, quantityType: .grams, protein: 3.1, fiber: 0.0, carbs: 4.0, fats: 3.0, calories: 61, glycemicIndex: 35),
//        FoodItem(name: "Dal (Lentils)", quantity: 100, quantityType: .grams, protein: 7.6, fiber: 7.9, carbs: 18, fats: 0.5, calories: 116, glycemicIndex: 30),
//        FoodItem(name: "Paneer", quantity: 100, quantityType: .grams, protein: 18.9, fiber: 0.0, carbs: 1.2, fats: 20.8, calories: 265, glycemicIndex: 27),
//        FoodItem(name: "Rice", quantity: 100, quantityType: .grams, protein: 2.4, fiber: 0.4, carbs: 28, fats: 0.1, calories: 130, glycemicIndex: 73),
//        FoodItem(name: "Chicken Curry", quantity: 100, quantityType: .grams, protein: 15, fiber: 0.0, carbs: 3.0, fats: 8.0, calories: 160, glycemicIndex: 0),
//        FoodItem(name: "Chapati", quantity: 100, quantityType: .grams, protein: 8.1, fiber: 2.8, carbs: 43, fats: 1.7, calories: 204, glycemicIndex: 55),
//        FoodItem(name: "Samosa", quantity: 100, quantityType: .grams, protein: 6.0, fiber: 2.0, carbs: 24, fats: 14, calories: 262, glycemicIndex: 45)
//    ]
//
//    private init(usersMeals: [Int: [Date: [MealType: [FoodItem]]]], foodItemsDatabase: [FoodItem]) {
//        self.usersMeals = usersMeals
//        self.foodItemsDatabase = foodItemsDatabase
//    }
//
//    // Add a new meal
//    func addMeal(meal: Meal) {
//        if var userMeals = usersMeals[meal.userId] {
//            if var mealsForDate = userMeals[meal.date] {
//                if var foodItems = mealsForDate[meal.type] {
//                    foodItems.append(contentsOf: meal.selectedFoods)
//                    mealsForDate[meal.type] = foodItems
//                } else {
//                    mealsForDate[meal.type] = meal.selectedFoods
//                }
//                userMeals[meal.date] = mealsForDate
//            } else {
//                userMeals[meal.date] = [meal.type: meal.selectedFoods]
//            }
//            usersMeals[meal.userId] = userMeals
//        } else {
//            usersMeals[meal.userId] = [meal.date: [meal.type: meal.selectedFoods]]
//        }
//    }
//
//    // Get meal details
//    func getMealDetails(for mealType: MealType, on date: Date, userId: Int) -> [(mealName: String, quantity: Double, quantityType: QuantityType, calories: Double)] {
//        guard let userMeals = usersMeals[userId], let mealsForDate = userMeals[date], let foodItems = mealsForDate[mealType] else {
//            return []
//        }
//
//        return foodItems.map { foodItem in
//            (mealName: foodItem.name, quantity: foodItem.quantity, quantityType: foodItem.quantityType, calories: foodItem.calories)
//        }
//    }
//
//    // Get total nutrients for a specific date
//    func getTotalNutrients(for date: Date, userId: Int) -> (carbs: Double, fats: Double, proteins: Double, fiber: Double) {
//        var totalCarbs = 0.0, totalFats = 0.0, totalProteins = 0.0, totalFiber = 0.0
//
//        if let userMeals = usersMeals[userId], let mealsForDate = userMeals[date] {
//            for (_, foodItems) in mealsForDate {
//                for food in foodItems {
//                    totalCarbs += food.carbs
//                    totalFats += food.fats
//                    totalProteins += food.protein
//                    totalFiber += food.fiber
//                }
//            }
//        }
//        return (carbs: totalCarbs, fats: totalFats, proteins: totalProteins, fiber: totalFiber)
//    }
//
//    // Remove a food item
//    func removeFoodItem(_ foodItem: FoodItem, from mealType: MealType, on date: Date, userId: Int) -> Bool {
//        guard var userMeals = usersMeals[userId], var mealsForDate = userMeals[date], var foodItems = mealsForDate[mealType] else {
//            print("No meals found for the given user, date, or meal type.")
//            return false
//        }
//
//        if let index = foodItems.firstIndex(of: foodItem) {
//            foodItems.remove(at: index)
//            mealsForDate[mealType] = foodItems
//            userMeals[date] = mealsForDate
//            usersMeals[userId] = userMeals
//            return true
//        } else {
//            print("The specified food item was not found.")
//            return false
//        }
//    }
//
//    // Get food details
//    func getFoodDetails(foodName: String) -> (protein: Double, carbs: Double, fats: Double, fiber: Double, calories: Double, glycemicLoad: Double)? {
//        guard let foodItem = foodItemsDatabase.first(where: { $0.name == foodName }) else {
//            print("Food item not found in the database.")
//            return nil
//        }
//
//        return (
//            protein: foodItem.protein,
//            carbs: foodItem.carbs,
//            fats: foodItem.fats,
//            fiber: foodItem.fiber,
//            calories: foodItem.calories,
//            glycemicLoad: foodItem.gl
//        )
//    }
//}
//
//
//
////import Foundation
////import UIKit
////
////
////// Food item struct
////struct FoodItem : Equatable {
////    var name: String
////    var quantity: Double
////    var quantityType: QuantityType
////    var protein: Double
////    var fiber: Double
////    var carbs: Double
////    var fats : Double
////    var calories: Double
////    var glycemicIndex: Double
////    var gl: Double {
////        return (Double(glycemicIndex) * Double(carbs)) / 100.0
////    }
////}
////// Quantity type enum
////enum QuantityType: String {
////    case grams, spoon, bowl, piece, ml // Add more as needed
////}
////// Meal type enum
////enum MealType: String {
////    case breakfast, lunch, snacks, dinner
////}
////
////// Meal structure
////struct Meal {
////    var type: MealType        // Meal type (e.g., breakfast, lunch)
////    var selectedFoods: [FoodItem]
////}
////
////
////class MealDataModel {
////
////
////    private var usersMeals: [Int: [Date: [MealType: [FoodItem]]]] = [:]
////    
////    static var shared = MealDataModel(usersMeals: [:], foodItemsDatabase: [])
////    
////    private var foodItemsDatabase: [FoodItem] = [
////            FoodItem(name: "Halwa", quantity: 100, quantityType: .grams, protein: 1.2, fiber: 0.8, carbs: 31, fats: 11, calories: 215, glycemicIndex: 55),
////            FoodItem(name: "Paratha", quantity: 100, quantityType: .grams, protein: 5.1, fiber: 3.4, carbs: 36, fats: 10, calories: 297, glycemicIndex: 62),
////            FoodItem(name: "Dahi (Curd)", quantity: 100, quantityType: .grams, protein: 3.1, fiber: 0.0, carbs: 4.0, fats: 3.0, calories: 61, glycemicIndex: 35),
////            FoodItem(name: "Dal (Lentils)", quantity: 100, quantityType: .grams, protein: 7.6, fiber: 7.9, carbs: 18, fats: 0.5, calories: 116, glycemicIndex: 30),
////            FoodItem(name: "Paneer", quantity: 100, quantityType: .grams, protein: 18.9, fiber: 0.0, carbs: 1.2, fats: 20.8, calories: 265, glycemicIndex: 27),
////            FoodItem(name: "Rice", quantity: 100, quantityType: .grams, protein: 2.4, fiber: 0.4, carbs: 28, fats: 0.1, calories: 130, glycemicIndex: 73),
////            FoodItem(name: "Chicken Curry", quantity: 100, quantityType: .grams, protein: 15, fiber: 0.0, carbs: 3.0, fats: 8.0, calories: 160, glycemicIndex: 0),
////            FoodItem(name: "Chapati", quantity: 100, quantityType: .grams, protein: 8.1, fiber: 2.8, carbs: 43, fats: 1.7, calories: 204, glycemicIndex: 55),
////            FoodItem(name: "Samosa", quantity: 100, quantityType: .grams, protein: 6.0, fiber: 2.0, carbs: 24, fats: 14, calories: 262, glycemicIndex: 45)
////        ]
////    private init(usersMeals: [Int : [Date : [MealType : [FoodItem]]]], foodItemsDatabase: [FoodItem]) {
////        self.usersMeals = usersMeals
////        self.foodItemsDatabase = foodItemsDatabase
////    }
////    
////
////    
////    
////    
////    //func to get quickview of usersMeals
////    //takes input as date and mealtype then returns the values needed in an array.
////    func getMealDetails(for mealType: MealType, on date: Date, userId: Int) -> [(mealName: String, quantity: Double, quantityType: QuantityType, calories: Double)] {
////        var result: [(mealName: String, quantity: Double, quantityType: QuantityType, calories: Double)] = []
////
////        // Check if there are meals for the given user and date
////        if let userMeals = usersMeals[userId], let mealsForDate = userMeals[date] {
////            // Check if there are meals for the given meal type
////            if let foodItems = mealsForDate[mealType] {
////                // Map each FoodItem to the desired tuple format
////                result = foodItems.map { foodItem in
////                    (mealName: foodItem.name, quantity: foodItem.quantity, quantityType: foodItem.quantityType, calories: foodItem.calories)
////                }
////            }
////        }
////        return result
////    }
////    
////    // Method to get total macronutrients for a specific date
////    func getTotalNutrients(for date: Date, userId: Int) -> (carbs: Double, fats: Double, proteins: Double, fiber: Double) {
////        var totalCarbs = 0.0
////        var totalFats = 0.0
////        var totalProteins = 0.0
////        var totalFiber = 0.0
////
////        // Check if there are meals for the given user and date
////        if let userMeals = usersMeals[userId], let mealsForDate = userMeals[date] {
////            // Iterate through all meals for that date
////            for (_, foodItems) in mealsForDate {
////                for food in foodItems {
////                    totalCarbs += food.carbs
////                    totalFats += food.fats // Add fat property if available in FoodItem
////                    totalProteins += food.protein
////                    totalFiber += food.fiber
////                }
////            }
////        }
////
////        return (carbs: totalCarbs, fats: totalFats, proteins: totalProteins, fiber: totalFiber)
////    }
////    
////    // Function to remove a FoodItem
////    func removeFoodItem(_ foodItem: FoodItem, from mealType: MealType, on date: Date, userId: Int) -> Bool {
////        // Check if the user and date exist
////        guard var userMeals = usersMeals[userId], var mealsForDate = userMeals[date] else {
////            print("No meals found for the given user and date.")
////            return false
////        }
////
////        // Check if the meal type exists
////        guard var foodItems = mealsForDate[mealType] else {
////            print("No foods found for the given meal type on the specified date.")
////            return false
////        }
////
////        // Try to remove the food item
////        if let index = foodItems.firstIndex(of: foodItem) {
////            foodItems.remove(at: index) // Remove the item
////            mealsForDate[mealType] = foodItems // Update the meal type data
////            userMeals[date] = mealsForDate // Update the date data
////            usersMeals[userId] = userMeals // Update the user's meals
////            return true
////        } else {
////            print("The specified food item was not found.")
////            return false
////        }
////    }
////    func addMeal(date: Date, mealType: MealType, foodName: String, quantity: Double, quantityType: QuantityType, userId: Int) {
////        // Find the food item in the database
////        guard let baseFoodItem = foodItemsDatabase.first(where: { $0.name == foodName }) else {
////            print("Food item not found in the database.")
////            return
////        }
////
////        // Create a new food item based on the selected item and quantity
////        let newFoodItem = FoodItem(
////            name: baseFoodItem.name,
////            quantity: quantity,
////            quantityType: quantityType,
////            protein: (baseFoodItem.protein / baseFoodItem.quantity) * quantity,
////            fiber: (baseFoodItem.fiber / baseFoodItem.quantity) * quantity,
////            carbs: (baseFoodItem.carbs / baseFoodItem.quantity) * quantity,
////            fats: (baseFoodItem.fats / baseFoodItem.quantity) * quantity,
////            calories: (baseFoodItem.calories / baseFoodItem.quantity) * quantity,
////            glycemicIndex: baseFoodItem.glycemicIndex
////        )
////
////        // Check if the user and date already exist
////        if var userMeals = usersMeals[userId] {
////            if var mealTypes = userMeals[date] {
////                // Check if the meal type exists for that date
////                if var foodItems = mealTypes[mealType] {
////                    foodItems.append(newFoodItem)  // Add the new food item
////                    mealTypes[mealType] = foodItems  // Update the meal type
////                } else {
////                    // Meal type does not exist; create a new entry
////                    mealTypes[mealType] = [newFoodItem]
////                }
////                // Update the user's meals dictionary with modified mealTypes
////                userMeals[date] = mealTypes
////            } else {
////                // Date does not exist; create a new entry for the date
////                userMeals[date] = [mealType: [newFoodItem]]
////            }
////            usersMeals[userId] = userMeals
////        } else {
////            // User does not exist; create a new entry for the user
////            usersMeals[userId] = [date: [mealType: [newFoodItem]]]
////        }
////    }
////    
////    func getFoodDetails(foodName: String) -> (protein: Double, carbs: Double, fats: Double, fiber: Double, calories: Double, glycemicLoad: Double)? {
////        guard let foodItem = foodItemsDatabase.first(where: { $0.name == foodName }) else {
////            print("Food item not found in the database.")
////            return nil
////        }
////
////        return (
////            protein: foodItem.protein,
////            carbs: foodItem.carbs,
////            fats: foodItem.fats,
////            fiber: foodItem.fiber,
////            calories: foodItem.calories,
////            glycemicLoad: foodItem.gl
////        )
////    }
////
////}
