import Foundation

struct BloodGlucoseDataVariables {
    var userId: Int           // Unique user identifier
    var id: Int               // Unique identifier for each entry
    var reading: Double       // Blood glucose level in mg/dL
    var timestamp: Date       // The date and time the reading was recorded
    var notes: String?        // Optional user-provided notes
    var tag: String           // Tag indicating the context (e.g., "Pre-Meal", "Post-Workout")
}

class BloodGlucoseDataManager {
    // Static data dictionary storing user-specific glucose data
    private static var userData: [Int: [BloodGlucoseDataVariables]] = [:]

    // Generate a unique integer ID based on timestamp
    private func generateUniqueID() -> Int {
        let timestamp = Int(Date().timeIntervalSince1970) // Current Unix timestamp as an integer
        return timestamp // Use only timestamp for unique ID generation
    }

    // Add a new reading for a specific user
    func addReading(userId: Int, reading: Double, timestamp: Date, notes: String?, tag: String) {
        let newID = generateUniqueID()
        let newEntry = BloodGlucoseDataVariables(
            userId: userId,
            id: newID,
            reading: reading,
            timestamp: timestamp,
            notes: notes,
            tag: tag
        )
        
        // Add the new entry to the user's data
        if BloodGlucoseDataManager.userData[userId] != nil {
            BloodGlucoseDataManager.userData[userId]?.append(newEntry)
        } else {
            BloodGlucoseDataManager.userData[userId] = [newEntry]
        }
    }

    // Get all readings for a specific user
//    func getAllReadings(userId: Int) -> [BloodGlucoseDataVariables]? {
//        return BloodGlucoseDataManager.userData[userId]
//    }

    // Get readings for a specific user and date
    func getReadings(forUserId userId: Int, forDate date: Date) -> [BloodGlucoseDataVariables]? {
        guard let userReadings = BloodGlucoseDataManager.userData[userId] else { return nil }
        
        let calendar = Calendar.current
        return userReadings.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
    }

    // Delete a reading for a specific user by ID
    func deleteReading(byId id: Int, forUserId userId: Int) {
        if let index = BloodGlucoseDataManager.userData[userId]?.firstIndex(where: { $0.id == id }) {
            BloodGlucoseDataManager.userData[userId]?.remove(at: index)
        }
    }

    // Group readings by tags
    func groupEntriesByTag(for userId: Int, forDate date: Date) -> [String: [BloodGlucoseDataVariables]]? {
        guard let userReadings = getReadings(forUserId: userId, forDate: date) else { return nil }
        return Dictionary(grouping: userReadings, by: { $0.tag })
    }

    // Group readings by specific time slots
    func groupEntriesByTime(for userId: Int, forDate date: Date) -> [String: Double?] {
        let timeSlots = ["Pre-Meal", "Breakfast", "Lunch", "Dinner"]
        var groupedReadings: [String: Double?] = [:]

        if let readings = groupEntriesByTag(for: userId, forDate: date) {
            for slot in timeSlots {
                // Get all readings for the current time slot
                if let matchingEntries = readings[slot] {
                    // Calculate the average for the time slot
                    let averageReading = matchingEntries.map { $0.reading }.reduce(0, +) / Double(matchingEntries.count)
                    groupedReadings[slot] = averageReading
                } else {
                    groupedReadings[slot] = nil // No data for this time slot
                }
            }
        } else {
            // If no data is available for the user/date, fill with nil
            for slot in timeSlots {
                groupedReadings[slot] = nil
            }
        }

        return groupedReadings
    }

    // Prepare graph data
    func prepareGraphData(for userId: Int, forDate date: Date, targetGlucose: Double) -> (graphPoints: [Double?], targetLine: [Double]) {
        let groupedData = groupEntriesByTime(for: userId, forDate: date)
        let timeSlots = ["Fasting","Pre-Meal","Post-Meal", "Pre-Workout", "Post-Workout"]
        let graphPoints = timeSlots.map { groupedData[$0] ?? nil }
        let targetLine = Array(repeating: targetGlucose, count: timeSlots.count)
        return (graphPoints, targetLine)
    }
}

//import Foundation
//
//struct BloodGlucoseDataVariables {
//    var userId: Int           // Unique user identifier
//    var id: Int               // Unique identifier for each entry
//    var reading: Double       // Blood glucose level in mg/dL
//    var timestamp: Date       // The date and time the reading was recorded
//    var notes: String?        // Optional user-provided notes
//    var tag: String           // Tag indicating the context (e.g., "Pre-Meal", "Post-Workout")
//}
//
//class BloodGlucoseDataManager {
//    // Static data dictionary storing user-specific glucose data
//    private static var userData: [Int: [BloodGlucoseDataVariables]] = [:]
//
//    // Generate a unique integer ID based on timestamp
//    private func generateUniqueID() -> Int {
//        let timestamp = Int(Date().timeIntervalSince1970) // Current Unix timestamp as an integer
//        return timestamp // Use only timestamp for unique ID generation
//    }
//
//    // Add a new reading for a specific user
//    func addReading(userId: Int, reading: Double, timestamp: Date, notes: String?, tag: String) {
//        let newID = generateUniqueID()
//        let newEntry = BloodGlucoseDataVariables(
//            userId: userId,
//            id: newID,
//            reading: reading,
//            timestamp: timestamp,
//            notes: notes,
//            tag: tag
//        )
//
//        // Add the new entry to the user's data
//        if BloodGlucoseDataManager.userData[userId] != nil {
//            BloodGlucoseDataManager.userData[userId]?.append(newEntry)
//        } else {
//            BloodGlucoseDataManager.userData[userId] = [newEntry]
//        }
//    }
//
//    // Get all readings for a specific user
//    func getAllReadings(userId: Int) -> [BloodGlucoseDataVariables]? {
//        return BloodGlucoseDataManager.userData[userId]
//    }
//
//    // Get readings for a specific user and date
//    func getReadings(forUserId userId: Int, forDate date: Date) -> [BloodGlucoseDataVariables]? {
//        guard let userReadings = BloodGlucoseDataManager.userData[userId] else { return nil }
//
//        let calendar = Calendar.current
//        return userReadings.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
//    }
//
//    // Delete a reading for a specific user by ID
//    func deleteReading(byId id: Int, forUserId userId: Int) {
//        if let index = BloodGlucoseDataManager.userData[userId]?.firstIndex(where: { $0.id == id }) {
//            BloodGlucoseDataManager.userData[userId]?.remove(at: index)
//        }
//    }
//
//    // Update an existing reading for a specific user
//    func updateReading(id: Int, forUserId userId: Int, newReading: Double?, newNotes: String?, newTag: String?) {
//        if let index = BloodGlucoseDataManager.userData[userId]?.firstIndex(where: { $0.id == id }) {
//            if let newReading = newReading {
//                BloodGlucoseDataManager.userData[userId]?[index].reading = newReading
//            }
//            if let newNotes = newNotes {
//                BloodGlucoseDataManager.userData[userId]?[index].notes = newNotes
//            }
//            if let newTag = newTag {
//                BloodGlucoseDataManager.userData[userId]?[index].tag = newTag
//            }
//        }
//    }
//
//    // Calculate average blood glucose over a number of days for a specific user
//    func calculateAverageBloodSugar(forUserId userId: Int, forDay day: Date) -> Double? {
//        guard let userReadings = BloodGlucoseDataManager.userData[userId] else { return nil }
//
//        let calendar = Calendar.current
//        let filteredData = userReadings.filter {
//            calendar.isDate($0.timestamp, inSameDayAs: day)
//        }
//
//        // If there are no readings for the specific day, return nil
//        guard !filteredData.isEmpty else { return nil }
//
//        // Calculate the average of blood glucose readings for that day
//        let totalBloodGlucose = filteredData.reduce(0.0) { $0 + $1.reading }
//        let average = totalBloodGlucose / Double(filteredData.count)
//
//        return average
//    }
//
//    // Generate blood sugar insights for a specific user
//    func generateBloodSugarInsights(forUserId userId: Int, forDay day: Date = Date()) -> String? {
//        guard let averageBloodSugar = calculateAverageBloodSugar(forUserId: userId, forDay: day) else {
//            return "No blood glucose data available for insights. Start tracking now!"
//        }
//
//        switch averageBloodSugar {
//        case 0:
//            return "No blood glucose data available for insights. Start tracking now!"
//        case 0..<70:
//            return "Your average blood glucose level is \(String(format: "%.1f", averageBloodSugar)) mg/dL, which is LOW. Consider consuming glucose-rich food and consult your doctor."
//        case 70..<140:
//            return "Your average blood glucose level is \(String(format: "%.1f", averageBloodSugar)) mg/dL, which is in the NORMAL range. Great job maintaining stability!"
//        case 140..<200:
//            return "Your average blood glucose level is \(String(format: "%.1f", averageBloodSugar)) mg/dL, which is slightly elevated. Try monitoring your carb intake and staying active."
//        case 200...:
//            return "Your average blood glucose level is \(String(format: "%.1f", averageBloodSugar)) mg/dL, which is HIGH. It's time to take immediate action: consult your doctor, eat balanced meals, and incorporate regular exercise."
//        default:
//            return "Unexpected values found. Please verify your blood sugar records."
//        }
//    }
//}
//
////struct BloodGlucoseGraphData {
////    var userId: Int
////    var entries: [BloodGlucoseDataVariables] = [] // List of blood glucose readings
////    var targetGlucose: Double                // Target glucose level from the user data model
////}
////class BloodGlucoseGraphDataManager {
////    var static bloodGlucoseGraphData: BloodGlucoseGraphData()
////    // Group Data for Graphing
////     func groupEntriesByTag() -> [String: [BloodGlucoseDataVariables]] {
////        return Dictionary(grouping: entries, by: { $0.tag })
////    }
////
////    func groupEntriesByTime(for date: Date) -> [String: Double?] {
////        let calendar = Calendar.current
////        let filteredEntries = entries.filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
////
////        let timeSlots = ["Pre-Meal", "Breakfast", "Lunch", "Dinner"]
////        var groupedReadings: [String: Double?] = [:]
////
////        for slot in timeSlots {
////            let matchingEntries = filteredEntries.filter { $0.tag == slot }
////            let averageReading = matchingEntries.isEmpty
////                ? nil
////                : matchingEntries.map { $0.reading }.reduce(0, +) / Double(matchingEntries.count)
////            groupedReadings[slot] = averageReading
////        }
////
////        return groupedReadings
////    }
////
////    // Prepare graph data
////    func prepareGraphData(for date: Date) -> (graphPoints: [Double?], targetLine: [Double]) {
////        let groupedData = groupEntriesByTime(for: date)
////        let timeSlots = ["Pre-Meal", "Breakfast", "Lunch", "Dinner"]
////        let graphPoints = timeSlots.map { groupedData[$0] ?? nil }
////        let targetLine = Array(repeating: targetGlucose, count: timeSlots.count)
////        return (graphPoints, targetLine)
////    }
////}
//
//
//    // Group readings by specific time slots (e.g., Pre-Meal, Breakfast, etc.)
//    func groupEntriesByTime(for userId: Int, forDate date: Date) -> [String: Double?] {
//        let timeSlots = ["Pre-Meal", "Breakfast", "Lunch", "Dinner"]
//        var groupedReadings: [String: Double?] = [:]
//
//        if let readings = groupEntriesByTag(for: userId, forDate: date) {
//            for slot in timeSlots {
//                // Get all readings for the current time slot
//                if let matchingEntries = readings[slot] {
//                    // Calculate the average for the time slot
//                    let averageReading = matchingEntries.map { $0.reading }.reduce(0, +) / Double(matchingEntries.count)
//                    groupedReadings[slot] = averageReading
//                } else {
//                    groupedReadings[slot] = nil // No data for this time slot
//                }
//            }
//        } else {
//            // If no data is available for the user/date, fill with nil
//            for slot in timeSlots {
//                groupedReadings[slot] = nil
//            }
//        }
//
//        return groupedReadings
//    }
//
//    // Prepare graph data
//    func prepareGraphData(for userId: Int, forDate date: Date, targetGlucose: Double) -> (graphPoints: [Double?], targetLine: [Double]) {
//        let groupedData = groupEntriesByTime(for: userId, forDate: date)
//        let timeSlots = ["Pre-Meal", "Breakfast", "Lunch", "Dinner"]
//        let graphPoints = timeSlots.map { groupedData[$0] ?? nil }
//        let targetLine = Array(repeating: targetGlucose, count: timeSlots.count)
//        return (graphPoints, targetLine)
//    }
//

