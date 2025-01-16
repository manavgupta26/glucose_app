//
//  TipsCollectionHeaderViewCollectionReusableView.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 1/15/25.
//

import UIKit

class TipsCollectionHeaderViewCollectionReusableView: UICollectionReusableView {
    static let reuseIdentifier = "TipsCollectionHeaderView"
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .black
//            label.text = "Daily Tips"
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            addSubview(titleLabel)
            
            // Layout the title label
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
