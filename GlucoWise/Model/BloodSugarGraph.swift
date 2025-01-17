//
//  BloodSugarGraph.swift
//  GlucoWise
//
//  Created by student-2 on 17/01/25.
//

import Foundation
import DGCharts
struct BloodSugarReading {
    let title: String
    let time: String
    let reading: String
    let chartData: [ChartDataEntry]
}
let bloodSugarReadings = [
    BloodSugarReading(title: "Post Meal", time: "10:00 PM", reading: "120 mg/dL", chartData: [
        ChartDataEntry(x: 1, y: 120), ChartDataEntry(x: 2, y: 110), ChartDataEntry(x: 3, y: 115)
    ]),
    BloodSugarReading(title: "Pre Meal", time: "4:00 PM", reading: "90 mg/dL", chartData: [
        ChartDataEntry(x: 1, y: 90), ChartDataEntry(x: 2, y: 85), ChartDataEntry(x: 3, y: 95)
    ]),
    BloodSugarReading(title: "Fasting", time: "7:00 AM", reading: "85 mg/dL", chartData: [
        ChartDataEntry(x: 1, y: 85), ChartDataEntry(x: 2, y: 87), ChartDataEntry(x: 3, y: 88)
    ])
]
