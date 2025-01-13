//
//  CalenderCellCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit

class CalenderCellCollectionViewCell: UICollectionViewCell {
  
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    override init(frame: CGRect) {
           super.init(frame: frame)

           // Initialize labels
           dayLabel = UILabel()
           dateLabel = UILabel()

           // Add labels to the content view
           contentView.addSubview(dayLabel)
           contentView.addSubview(dateLabel)

           // Set up layout constraints for labels (Example)
           dayLabel.translatesAutoresizingMaskIntoConstraints = false
           dateLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
               dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4)
           ])
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
