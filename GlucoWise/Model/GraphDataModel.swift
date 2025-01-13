import Foundation



class Getinsights{
    private init(){
        
    }
    func getReadingsAndSteps(userId: Int,
                             glucoseData: [BloodGlucoseDataVariables],
                             workoutData: [workoutData]) -> ([(reading: Double, timestamp: Date)], [(steps: Int?, duration: TimeInterval)]) {
        
        // Filter blood glucose readings for the specified user
        let filteredGlucoseData = glucoseData.filter { $0.userId == userId }
        let glucoseReadings = filteredGlucoseData.map { (reading: $0.reading, timestamp: $0.timestamp) }
        
        // Filter workout data
        let filteredWorkoutData = workoutData.filter { _ in true } // If workouts are user-specific, add filter logic
        let workoutSteps = filteredWorkoutData.map { (steps: $0.steps, duration: $0.duration) }
        
        return (glucoseReadings, workoutSteps)
    }
}

