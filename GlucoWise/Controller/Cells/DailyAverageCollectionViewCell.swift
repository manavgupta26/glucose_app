//
//  DailyAverageCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit

class DailyAverageCollectionViewCell: UICollectionViewCell {
    
    
   
    @IBOutlet var glucoseReactionLbl: UIImageView!
    @IBOutlet var glucoseChangeLabel: UILabel!
    @IBOutlet var glucoseLastUppdatedLbl: UILabel!
    @IBOutlet var glucoseLabel: UILabel!
    @IBOutlet var glucoseValueLabel: UILabel!
    override init(frame: CGRect) {
           super.init(frame: frame)
        contentView.backgroundColor = .white
           // Initialize labels
           glucoseLabel = UILabel()
           glucoseChangeLabel = UILabel()
           glucoseLastUppdatedLbl = UILabel()
        glucoseValueLabel=UILabel()
           // Initialize image view
           glucoseReactionLbl = UIImageView()
           glucoseReactionLbl.contentMode = .scaleAspectFit
           
           // Add components to the content view
           contentView.addSubview(glucoseLabel)
        contentView.addSubview(glucoseValueLabel)
           contentView.addSubview(glucoseChangeLabel)
           contentView.addSubview(glucoseLastUppdatedLbl)
           contentView.addSubview(glucoseReactionLbl)
           
           // Set up layout constraints
        configureUI()
           setupConstraints()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    private func configureUI() {
            // Glucose Label
            glucoseLabel.font = UIFont.boldSystemFont(ofSize: 22)
            glucoseLabel.textColor = .black
        //glucose Value
        glucoseValueLabel.font = UIFont.systemFont(ofSize: 40)
        glucoseValueLabel.textColor = UIColor(.black)
            
            // Glucose Change Label
            glucoseChangeLabel.font = UIFont.systemFont(ofSize: 12)
            glucoseChangeLabel.textColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
            
            // Glucose Last Updated Label
            glucoseLastUppdatedLbl.font = UIFont.systemFont(ofSize: 10)
        glucoseLastUppdatedLbl.textColor = UIColor(.black)
            
            // Glucose Reaction Image View
            glucoseReactionLbl.contentMode = .scaleAspectFit
        }
       
       private func setupConstraints() {
           // Disable autoresizing masks
           glucoseLabel.translatesAutoresizingMaskIntoConstraints = false
           glucoseValueLabel.translatesAutoresizingMaskIntoConstraints = false
           glucoseChangeLabel.translatesAutoresizingMaskIntoConstraints = false
           glucoseLastUppdatedLbl.translatesAutoresizingMaskIntoConstraints = false
           glucoseReactionLbl.translatesAutoresizingMaskIntoConstraints = false
           
           // Add constraints
           NSLayoutConstraint.activate([
               // Glucose Label - Top Left
               glucoseLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
               glucoseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               glucoseLabel.trailingAnchor.constraint(lessThanOrEqualTo: glucoseReactionLbl.leadingAnchor, constant: -20),
               //glucoseValueLabel
               glucoseValueLabel.topAnchor.constraint(equalTo: glucoseLabel.bottomAnchor, constant: 20),
               glucoseValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               glucoseValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: glucoseReactionLbl.leadingAnchor, constant: -20),
               // Glucose Change Label - Below Glucose Label
               glucoseChangeLabel.topAnchor.constraint(equalTo: glucoseValueLabel.bottomAnchor, constant: 20),
               glucoseChangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               glucoseChangeLabel.trailingAnchor.constraint(lessThanOrEqualTo: glucoseReactionLbl.leadingAnchor, constant: -20),
               
               // Glucose Last Updated Label - Below Glucose Change Label
               glucoseLastUppdatedLbl.topAnchor.constraint(equalTo: glucoseChangeLabel.bottomAnchor, constant: 10),
               glucoseLastUppdatedLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
               glucoseLastUppdatedLbl.trailingAnchor.constraint(lessThanOrEqualTo: glucoseReactionLbl.leadingAnchor, constant: -20),
               glucoseLastUppdatedLbl.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -20),
               
               // Glucose Reaction Image View - Right Aligned
               glucoseReactionLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               glucoseReactionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
               glucoseReactionLbl.widthAnchor.constraint(equalToConstant: 120),
               glucoseReactionLbl.heightAnchor.constraint(equalToConstant: 120)
           ])
       }
}
