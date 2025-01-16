//
//  CalenderCollectionViewCell.swift
//  practise
//
//  Created by Harnoor Kaur on 1/12/25.
//

import UIKit

class CalenderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    override init(frame: CGRect) {
           super.init(frame: frame)

           // Initialize labels
           dayLabel = UILabel()
           dateLabel = UILabel()

           // Add labels to the content view
           contentView.addSubview(dayLabel)
           contentView.addSubview(dateLabel)
        contentView.backgroundColor=UIColor.white
           // Set up layout constraints for labels (Example)
           dayLabel.translatesAutoresizingMaskIntoConstraints = false
           dateLabel.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
               dateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
               dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 5)
           ])
       }

       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
