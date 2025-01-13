//
//  workoutDataModel.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/19/24.
//

import Foundation

struct workoutData {
    let id: Int           // Unique identifier for each workout
    let startTime: Date           // Start time of the workout
    let endTime: Date             // End time of the workout
    let duration: TimeInterval    // Total duration of the workout in seconds
    let type: String              // Workout type (e.g., "Running", "Walking", "Cycling")
    let caloriesBurned: Double    // Total calories burned during the workout (in kcal)
    let distance: Double?         // Total distance covered (in meters, optional)
    let steps: Int?               // Number of steps taken (if applicable)
}


class WorkoutModel{
    var userWorkoutData: [Int: [workoutData]] = [:] // Key: UserID, Value: Array of workoutData

    // Method to get total steps for a user
    func getTotalSteps(forUserId userId: Int) -> Int {
        // Retrieve workout data for the given user ID
        guard let workouts = userWorkoutData[userId] else {
            print("No workouts found for the given user ID.")
            return 0
        }

        // Calculate total steps
        let totalSteps = workouts.reduce(0) { $0 + ($1.steps ?? 0) }
        return totalSteps
    }

    // Method to get total workout minutes for a user
    func getWorkoutMinutes(forUserId userId: Int) -> Int {
        // Retrieve workout data for the given user ID
        guard let workouts = userWorkoutData[userId] else {
            print("No workouts found for the given user ID.")
            return 0
        }

        // Calculate total workout duration in minutes
        let totalMinutes = workouts.reduce(0) { $0 + Int($1.duration / 60) }
        return totalMinutes
    }

    // Method to get total calories burned for a user
    func getCaloriesBurned(forUserId userId: Int) -> Double {
        // Retrieve workout data for the given user ID
        guard let workouts = userWorkoutData[userId] else {
            print("No workouts found for the given user ID.")
            return 0.0
        }

        // Calculate total calories burned
        let totalCalories = workouts.reduce(0.0) { $0 + $1.caloriesBurned }
        return totalCalories
    }}
