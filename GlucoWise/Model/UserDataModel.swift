//import Foundation
//
//// MARK: - User Data Model
//struct UserData {
//    var id: Int // Unique identifier for the user
//    var name: String
//    var emailId: String
//    var password: String
//    var age: Int
//    var gender: Gender
//    var weight: Double // Stored in kilograms by default
//    var height: Double // Stored in centimeters by default
//    var isWeightInPounds: Bool // Flag to indicate weight unit
//    var isHeightInInches: Bool // Flag to indicate height unit
//    var targetBloodSugar: Double? // Target blood sugar level
//    var currentBloodSugar: Double? // Current blood sugar level
//    var activityLevel: ActivityLevel // User activity level
//    var goals: Goals // Goals object
//    var meal: [Meal]? // Meal object
//    var bloodSugar: [BloodGlucoseDataVariables]? // Blood glucose data
//    var healthData: PersonalizedHealthData? // User's personalized health data
//    var graph: Getinsights? // Combined insights manager
//    var workoutdata : workoutData?
//}
//
//// MARK: - Enums
//enum Gender: String {
//    case male = "Male"
//    case female = "Female"
//    case other = "Other"
//}
//
//enum ActivityLevel: String {
//    case sedentary = "Sedentary"
//    case active = "Active"
//    case veryActive = "Very Active"
//    case moderateActive = "Moderately Active"
//}
//
//// MARK: - User Class (Methods)
//class User {
//    private var users: [UserData] = [] // Store multiple users with their ID as key
//    private var tipsManager: PersonalizedTipsManager = PersonalizedTipsManager()
//    
//    // Singleton instance
//    static let shared = User()
//    
//    private init() {}
//    
//    // Add a new user
//    func addUser(userData: UserData) {
//        users[userData.id] = userData
//    }
//    
////    // Get User's Unique ID
////    func getUserID(userId: Int) -> Int? {
////        return users[userId]?.id
////    }
//
//    // Calculate BMI for a specific user
//    func getBMI(for userId: Int) -> Double? {
//        guard let user = users[userId], user.height > 0 else { return nil }
//        let heightInMeters = user.height / 100
//        return user.weight / (heightInMeters * heightInMeters)
//    }
//
//    // Update blood sugar level for a specific user
//    func updateBloodSugar(userId: Int, newReading: Double) {
//        guard var user = users[userId] else { return }
//        user.currentBloodSugar = newReading
//        if var healthData = user.healthData {
//            healthData.sugarLevels.append(newReading)
//            user.healthData = healthData
//        }
//        users[userId] = user
//    }
//
//    // Set or update user details
//    func setUserDetails(userId: Int, name: String, emailId: String, password: String, age: Int) {
//        guard var user = users[userId] else { return }
//        user.name = name
//        user.emailId = emailId
//        user.password = password
//        user.age = age
//        users[userId] = user
//    }
//
//    // Add health data for a specific user
//    func addHealthData(userId: Int, hbA1c: Double, sugarLevels: [Double], workout: String?, diet: [String]) {
//        guard var user = users[userId] else { return }
//        let healthData = PersonalizedHealthData(hbA1c: hbA1c, sugarLevels: sugarLevels, workout: workout, diet: diet)
//        user.healthData = healthData
//        tipsManager.addHealthData(healthData)
//        users[userId] = user
//    }
//
//    // Generate health tips for a specific user
//    func generateHealthTips(userId: Int) -> [HealthTip] {
//        guard let user = users[userId], let healthData = user.healthData else {
//            return [HealthTip(category: "General", message: "No health data available.")]
//        }
//        return tipsManager.generatePersonalizedTips()
//    }
//
//    // Toggle weight unit between kg and pounds for a specific user
//    func toggleWeightUnit(for userId: Int) {
//        guard var user = users[userId] else { return }
//        if user.isWeightInPounds {
//            user.weight /= 2.20462 // Convert pounds to kilograms
//        } else {
//            user.weight *= 2.20462 // Convert kilograms to pounds
//        }
//        user.isWeightInPounds.toggle()
//        users[userId] = user
//    }
//
//    // Toggle height unit between cm and inches for a specific user
//    func toggleHeightUnit(for userId: Int) {
//        guard var user = users[userId] else { return }
//        if user.isHeightInInches {
//            user.height *= 2.54 // Convert inches to centimeters
//        } else {
//            user.height /= 2.54 // Convert centimeters to inches
//        }
//        user.isHeightInInches.toggle()
//        users[userId] = user
//    }
//
//    // Verify credentials for a specific user
//    func validateCredentials(userId: Int, email: String, password: String) -> Bool {
//        guard let user = users[userId] else { return false }
//        return user.emailId == email && user.password == password
//    }
//
//    // Update body weight for a specific user
//    func updateBodyWeight(userId: Int, newWeight: Double, isWeightInPounds: Bool? = nil) {
//        guard var user = users[userId] else { return }
//        if let isInPounds = isWeightInPounds {
//            user.weight = isInPounds ? newWeight / 2.20462 : newWeight
//            user.isWeightInPounds = isInPounds
//        } else {
//            user.weight = user.isWeightInPounds ? newWeight / 2.20462 : newWeight
//        }
//        users[userId] = user
//    }
//
//    // Fetch data for dual charts (steps and glucose readings) for a specific user
//    func fetchGraphData(userId: Int, forDate date: Date) -> (stepsData: [(time: Date, steps: Int)], glucoseData: [(time: Date, glucose: Double)])? {
//        guard let glucoseReadings = getReadings(userId: userId, forDate: date) else {
//            return nil
//        }
//        let stepsData = getStepsData(forDate: date)
//        let glucoseData = glucoseReadings.map { (time: $0.timestamp, glucose: $0.reading) }
//        return (stepsData: stepsData, glucoseData: glucoseData)
//    }
//
//    // Mock function to get readings for glucose for a specific user
//    func getReadings(userId: Int, forDate date: Date) -> [BloodGlucoseDataVariables]? {
//        guard let user = users[userId] else { return nil }
//        return user.bloodSugar?.filter {
//            Calendar.current.isDate($0.timestamp, inSameDayAs: date)
//        }
//    }
//
//    // Mock function to get steps data
//    func getStepsData(forDate date: Date) -> [(time: Date, steps: Int)] {
//        return [
//            (time: Calendar.current.date(byAdding: .hour, value: 8, to: date)!, steps: 500),
//            (time: Calendar.current.date(byAdding: .hour, value: 12, to: date)!, steps: 1500),
//            (time: Calendar.current.date(byAdding: .hour, value: 18, to: date)!, steps: 2000)
//        ]
//    }
//}
//
//// MARK: - Goals
//struct Goals {
//    var goalWeight: Double // in kilograms
//    var bloodSugarGoal: Double // in mg/dL
//    var hba1cGoal: Double // in percentage
//    var activityGoal: Int // in minutes per day
//}
