//
//  glucoseReadings.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 1/14/25.
//
//


import Foundation

struct GlucoseReading {
    var date: String          // In "MM/DD/YYYY" format
    var averageReading: Double
    var change: Double
    var lastUpdated: String   // Timestamp of the last update (in "MM/DD/YYYY HH:mm" format)
    var isSelected: Bool      // Indicates if this reading is currently selected
 // Timestamp of the last update (in "MM/DD/YYYY HH:mm" format)
}
class GlucoseDataSet {
    
    // Example dataset
    var glucoseReadings: [GlucoseReading] = [
        GlucoseReading(date: "01/01/2025", averageReading: 120.5, change: 2.0, lastUpdated: "01/01/2025 10:30", isSelected: false),
        GlucoseReading(date: "01/02/2025", averageReading: 115.0, change: -5.5, lastUpdated: "01/02/2025 12:00", isSelected: false),
        GlucoseReading(date: "01/03/2025", averageReading: 118.0, change: 3.0, lastUpdated: "01/03/2025 08:45", isSelected: false),
        GlucoseReading(date: "01/04/2025", averageReading: 130.0, change: 12.0, lastUpdated: "01/04/2025 09:15", isSelected: true),  // Default selected
        GlucoseReading(date: "01/05/2025", averageReading: 125.0, change: -5.0, lastUpdated: "01/05/2025 11:30", isSelected: false),
        GlucoseReading(date: "01/06/2025", averageReading: 135.0, change: 10.0, lastUpdated: "01/06/2025 07:00", isSelected: false),
        GlucoseReading(date: "01/07/2025", averageReading: 140.0, change: 5.0, lastUpdated: "01/07/2025 06:30", isSelected: false)
    ]
}

