//
//  bloodReadingsTableViewCell.swift
//  GlucoWise
//
//  Created by student-2 on 17/01/25.
//

import UIKit

class bloodReadingsTableViewCell: UITableViewCell {

    let titleLabel = UILabel()
        let timeLabel = UILabel()
        let readingLabel = UILabel()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupViews()
        }

        private func setupViews() {
            // Configure titleLabel
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.textColor = .black
            
            // Configure timeLabel
            timeLabel.font = UIFont.systemFont(ofSize: 14)
            timeLabel.textColor = .gray
            
            // Configure readingLabel
            readingLabel.font = UIFont.systemFont(ofSize: 16)
            readingLabel.textColor = .black
            readingLabel.textAlignment = .right

            // Add subviews
            contentView.addSubview(titleLabel)
            contentView.addSubview(timeLabel)
            contentView.addSubview(readingLabel)

            // Set up constraints
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            readingLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // Title label constraints
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                
                // Time label constraints
                timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                
                // Reading label constraints
                readingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                readingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }

}
