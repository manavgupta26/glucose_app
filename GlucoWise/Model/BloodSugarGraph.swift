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
    init(title: String, time: String, reading: String, chartData: [ChartDataEntry]) {
        self.title = title
        self.time = time
        self.reading = reading
        self.chartData = chartData
    }
}
