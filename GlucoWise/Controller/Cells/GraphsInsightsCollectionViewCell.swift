////
////  GraphsInsightsCollectionViewCell.swift
////  GlucoWise
////
////  Created by Harnoor Kaur on 12/23/24.
////
//
//import UIKit
//import DGCharts
//
//

import UIKit
import DGCharts

class GraphsInsightsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var graphContainerView: UIView!
    @IBOutlet weak var graphLbl: UILabel!
    var pieChartView: PieChartView!

        override func awakeFromNib() {
            super.awakeFromNib()

            // Initialize PieChartView and add it to the container view
            pieChartView = PieChartView(frame: graphContainerView.bounds)
            pieChartView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            graphContainerView.addSubview(pieChartView)
            
            // Set up the chart
            setUpGraph()
        }

        func setUpGraph() {
            var entries = [PieChartDataEntry]()

            // Example data for the pie chart
            entries.append(PieChartDataEntry(value: 70, label: "Completed"))
            entries.append(PieChartDataEntry(value: 30, label: "Remaining"))

            // Create a PieChartDataSet
            let dataSet = PieChartDataSet(entries: entries, label: "Progress")
            dataSet.colors = ChartColorTemplates.joyful() // Customize chart colors
            dataSet.valueTextColor = .white

            // Create a PieChartData
            let data = PieChartData(dataSet: dataSet)

            // Set data to the chart view
            pieChartView.data = data
            
            // Customize pie chart appearance
            pieChartView.holeColor = .clear  //  
            pieChartView.transparentCircleRadiusPercent = 0.6
            
            pieChartView.drawSlicesUnderHoleEnabled = false
        }
}
