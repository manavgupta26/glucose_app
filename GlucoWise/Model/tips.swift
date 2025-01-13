//
//  tips.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 1/12/25.
//

import Foundation
struct Tip {
    var name: String
    var description: String
    var imageName: String
    var buttonText: String
}

let tipsData = [
    Tip(name: "Tip 1: Stay Hydrated", description: "Drinking water helps regulate blood sugar levels.", imageName: "hydrationImage", buttonText: "Learn More"),
    Tip(name: "Tip 2: Eat Balanced Meals", description: "A balanced diet helps manage glucose levels effectively.", imageName: "balancedMealImage", buttonText: "Get Recipe"),
    Tip(name: "Tip 3: Exercise Regularly", description: "Regular exercise helps improve insulin sensitivity.", imageName: "exerciseImage", buttonText: "Get Routine"),
    Tip(name: "Tip 4: Monitor Your Blood Sugar", description: "Regular monitoring is essential to understanding your glucose patterns.", imageName: "monitoringImage", buttonText: "Learn More"),
    Tip(name: "Tip 5: Manage Stress", description: "Stress can affect blood glucose levels, so managing it is crucial.", imageName: "stressImage", buttonText: "Learn More")
]
