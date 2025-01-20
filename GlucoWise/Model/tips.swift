struct Tip {
    var name: String
    var description: String
    var imageName: String
    var buttonText: String
    var details: String // Contains additional details and why the tip is recommended
}
class Tips{
    
    private var tipsData = [
        Tip(
            name: "Tip 1: Stay Hydrated",
            description: "Drinking water helps regulate blood sugar levels.",
            imageName: "hydrationImage",
            buttonText: "Learn More",
            details: "Staying hydrated is essential for managing blood sugar levels as dehydration can cause glucose concentration in the blood to rise. Aim to drink at least 8 glasses of water daily."
        ),
        Tip(
            name: "Tip 2: Eat Balanced Meals",
            description: "A balanced diet helps manage glucose levels effectively.",
            imageName: "balancedMealImage",
            buttonText: "Get Recipe",
            details: "Balanced meals provide essential nutrients and prevent blood sugar spikes. Include complex carbohydrates, lean proteins, and healthy fats in every meal."
        ),
        Tip(
            name: "Tip 3: Exercise Regularly",
            description: "Regular exercise helps improve insulin sensitivity.",
            imageName: "exerciseImage",
            buttonText: "Get Routine",
            details: "Exercise increases insulin sensitivity, allowing cells to use glucose more effectively. Regular physical activity also helps maintain a healthy weight and reduces stress levels."
        ),
        Tip(
            name: "Tip 4: Monitor Your Blood Sugar",
            description: "Regular monitoring is essential to understanding your glucose patterns.",
            imageName: "monitoringImage",
            buttonText: "Learn More",
            details: "Monitoring blood sugar helps you understand how your body responds to different foods, activities, and medications. This information can guide better glucose management strategies."
        ),
        Tip(
            name: "Tip 5: Manage Stress",
            description: "Stress can affect blood glucose levels, so managing it is crucial.",
            imageName: "stressImage",
            buttonText: "Learn More",
            details: "Stress hormones such as cortisol can raise blood sugar levels. Incorporate stress management techniques like meditation, yoga, or deep breathing exercises into your daily routine."
        )
    ]
    
    private init(){}
    static let shared = Tips()
    func numberOfTips() -> Int {
        return tipsData.count
    }
    func tip(at index: Int) -> Tip {
        return tipsData[index]
    }
    func getAllTips() -> [Tip] {
        return tipsData
    }
}
