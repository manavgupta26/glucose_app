// Struct to represent individual meal readings

import Foundation
struct MealReading {
    var reading: Double       // The glucose level
    var time: String          // Time of the reading in "HH:mm AM/PM" format
    var tag: String           // One tag selected by the user (e.g., "Pre Meal", "Post Workout")
    var notes: String?        // Optional notes provided by the user
}

// Struct to represent daily glucose readings
struct GlucoseReading {
    var date: String          // In "MM/DD/YYYY" format
    var averageReading: Double
    var change: Double
    var lastUpdated: String   // Timestamp of the last update (in "MM/DD/YYYY HH:mm" format)
    var isSelected: Bool      // Indicates if this reading is currently selected
    var readingsByMeal: [String: MealReading]  // Dictionary of meal-specific readings (e.g., "Fasting", "Breakfast")
    var summary: String
}

// Class to manage the dataset
class GlucoseDataSet {
    
    // Example dataset with 7 readings
    private var glucoseReadings: [GlucoseReading] = [
        GlucoseReading(
            date: "01/01/2025",
            averageReading: 120.5,
            change: 2.0,
            lastUpdated: "01/01/2025 10:30",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 100.0, time: "06:30 AM", tag: "Fasting", notes: "Feeling normal"),
                "Breakfast": MealReading(reading: 110.0, time: "08:00 AM", tag: "Pre Meal", notes: nil),
                "Lunch": MealReading(reading: 130.0, time: "12:30 PM", tag: "Post Meal", notes: "Felt a little tired"),
                "Snacks": MealReading(reading: 125.0, time: "04:00 PM", tag: "Pre Workout", notes: nil),
                "Dinner": MealReading(reading: 120.0, time: "07:30 PM", tag: "Post Meal", notes: "Enjoyed a big dinner")
            ],
            summary: "Day started with a normal fasting reading, slightly elevated post-meal readings. Felt a bit tired after lunch."
        ),
        GlucoseReading(
            date: "01/02/2025",
            averageReading: 115.0,
            change: -5.5,
            lastUpdated: "01/02/2025 12:00",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 95.0, time: "06:20 AM", tag: "Fasting", notes: "Good energy"),
                "Breakfast": MealReading(reading: 105.0, time: "08:10 AM", tag: "Pre Meal", notes: nil),
                "Lunch": MealReading(reading: 120.0, time: "12:15 PM", tag: "Post Meal", notes: nil),
                "Snacks": MealReading(reading: 115.0, time: "03:45 PM", tag: "Pre Workout", notes: "Light snack"),
                "Dinner": MealReading(reading: 110.0, time: "07:20 PM", tag: "Post Meal", notes: nil)
            ],
            summary: "Steady glucose levels throughout the day, with a slight decrease from the previous day. Felt good overall."
        ),
        GlucoseReading(
            date: "01/03/2025",
            averageReading: 118.0,
            change: 3.0,
            lastUpdated: "01/03/2025 08:45",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 97.0, time: "06:10 AM", tag: "Fasting", notes: "Slept well"),
                "Breakfast": MealReading(reading: 115.0, time: "08:00 AM", tag: "Pre Meal", notes: nil),
                "Lunch": MealReading(reading: 125.0, time: "12:45 PM", tag: "Post Meal", notes: "Salad for lunch"),
                "Snacks": MealReading(reading: 120.0, time: "04:15 PM", tag: "Post Workout", notes: nil),
                "Dinner": MealReading(reading: 130.0, time: "07:15 PM", tag: "Post Meal", notes: "Felt slightly bloated")
            ],
            summary: "A slight increase in readings, with a healthy salad lunch. Felt bloated after dinner."
        ),
        GlucoseReading(
            date: "01/04/2025",
            averageReading: 130.0,
            change: 12.0,
            lastUpdated: "01/04/2025 09:15",
            isSelected: true, // Default selected
            readingsByMeal: [
                "Fasting": MealReading(reading: 110.0, time: "06:25 AM", tag: "Fasting", notes: "Woke up feeling a bit groggy"),
                "Breakfast": MealReading(reading: 125.0, time: "08:30 AM", tag: "Pre Meal", notes: nil),
                "Lunch": MealReading(reading: 140.0, time: "12:10 PM", tag: "Post Meal", notes: "Heavier lunch"),
                "Snacks": MealReading(reading: 135.0, time: "04:05 PM", tag: "Pre Workout", notes: "Prepared for exercise"),
                "Dinner": MealReading(reading: 125.0, time: "07:00 PM", tag: "Post Meal", notes: nil)
            ],
            summary: "Higher than usual readings, especially after lunch. Heavier meal intake led to a noticeable spike."
        ),
        GlucoseReading(
            date: "01/05/2025",
            averageReading: 125.0,
            change: -5.0,
            lastUpdated: "01/05/2025 11:30",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 102.0, time: "06:15 AM", tag: "Fasting", notes: nil),
                "Breakfast": MealReading(reading: 110.0, time: "08:25 AM", tag: "Pre Meal", notes: nil),
                "Lunch": MealReading(reading: 130.0, time: "12:40 PM", tag: "Post Meal", notes: nil),
                "Snacks": MealReading(reading: 118.0, time: "03:50 PM", tag: "Post Workout", notes: "Workout was intense"),
                "Dinner": MealReading(reading: 122.0, time: "07:35 PM", tag: "Post Meal", notes: "Dinner was balanced")
            ],
            summary: "Good recovery post-workout, with balanced meals throughout the day. A noticeable drop compared to previous day."
        ),
        GlucoseReading(
            date: "01/06/2025",
            averageReading: 135.0,
            change: 10.0,
            lastUpdated: "01/06/2025 07:00",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 112.0, time: "06:45 AM", tag: "Fasting", notes: "Stressful morning"),
                "Breakfast": MealReading(reading: 120.0, time: "08:50 AM", tag: "Post Meal", notes: nil),
                "Lunch": MealReading(reading: 145.0, time: "12:20 PM", tag: "Post Meal", notes: nil),
                "Snacks": MealReading(reading: 125.0, time: "03:40 PM", tag: "Pre Workout", notes: "Had some juice"),
                "Dinner": MealReading(reading: 130.0, time: "07:25 PM", tag: "Post Meal", notes: nil)
            ],
            summary: "A busy day with high readings, especially after lunch. Stress in the morning might have impacted glucose levels."
        ),
        GlucoseReading(
            date: "01/07/2025",
            averageReading: 140.0,
            change: 5.0,
            lastUpdated: "01/07/2025 06:30",
            isSelected: false,
            readingsByMeal: [
                "Fasting": MealReading(reading: 115.0, time: "06:50 AM", tag: "Fasting", notes: nil),
                "Breakfast": MealReading(reading: 125.0, time: "08:40 AM", tag: "Pre Meal", notes: "Had cereal"),
                "Lunch": MealReading(reading: 150.0, time: "12:30 PM", tag: "Post Meal", notes: "Ate a big meal"),
                "Snacks": MealReading(reading: 135.0, time: "04:10 PM", tag: "Post Workout", notes: nil),
                "Dinner": MealReading(reading: 140.0, time: "07:40 PM", tag: "Post Meal", notes: nil)
            ],
            summary: "Higher glucose levels, likely due to a large lunch. Stayed consistent throughout the day."
        )
    ]
    
    private init() {}
    
    static var shared = GlucoseDataSet()
    
    func getData(byDate date: Date) -> GlucoseReading {

        glucoseReadings[glucoseReadings.firstIndex { $0.date == "\(date)" } ?? 0]
    }
    
    func getAllData() -> [GlucoseReading] {
        glucoseReadings
    }
    
    func getDataCount() -> Int {
        glucoseReadings.count
    }
    
    func getData(byIndex id: Int) -> GlucoseReading {
        glucoseReadings[id]
    }
}
