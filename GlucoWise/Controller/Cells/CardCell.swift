//
//  CardCell.swift
//  GlucoWise
//
//  Created by student-2 on 19/12/24.
//

import UIKit

class CardCell: UICollectionViewCell {
    static let identifier = "CardCell"
       
       private let titleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.boldSystemFont(ofSize: 18)
           label.textColor = .black
           return label
       }()
       
       private let detailLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 16)
           label.textColor = .darkGray
           return label
       }()
       
       private let subtitleLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 14)
           label.textColor = .gray
           label.numberOfLines = 0
           return label
       }()
       
       private let emojiLabel: UILabel = {
           let label = UILabel()
           label.font = UIFont.systemFont(ofSize: 40)
           label.textAlignment = .right
           return label
       }()
       
       private let progressBar: UIProgressView = {
           let progress = UIProgressView(progressViewStyle: .default)
           progress.tintColor = .systemTeal
           progress.trackTintColor = .lightGray
           return progress
       }()
       
       private let graphView: UIView = {
           let view = UIView()
           view.backgroundColor = .systemGray5
           view.layer.cornerRadius = 8
           return view
       }()
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           contentView.layer.cornerRadius = 10
           contentView.layer.borderWidth = 1
           contentView.layer.borderColor = UIColor.lightGray.cgColor
           contentView.backgroundColor = .white
           contentView.addSubview(titleLabel)
           contentView.addSubview(detailLabel)
           contentView.addSubview(subtitleLabel)
           contentView.addSubview(emojiLabel)
           contentView.addSubview(progressBar)
           contentView.addSubview(graphView)
           setupConstraints()
       }
       
       private func setupConstraints() {
           titleLabel.translatesAutoresizingMaskIntoConstraints = false
           detailLabel.translatesAutoresizingMaskIntoConstraints = false
           subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
           emojiLabel.translatesAutoresizingMaskIntoConstraints = false
           progressBar.translatesAutoresizingMaskIntoConstraints = false
           graphView.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
               // Title
               titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
               titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               
               // Detail
               detailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
               detailLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               
               // Subtitle
               subtitleLabel.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10),
               subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               
               // Emoji
               emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
               emojiLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               emojiLabel.widthAnchor.constraint(equalToConstant: 50),
               emojiLabel.heightAnchor.constraint(equalToConstant: 50),
               
               // Progress Bar
               progressBar.topAnchor.constraint(equalTo: detailLabel.bottomAnchor, constant: 10),
               progressBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               progressBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               progressBar.heightAnchor.constraint(equalToConstant: 4),
               
               // Graph View
               graphView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
               graphView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
               graphView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
               graphView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
           ])
       }
       
       func configure(title: String, detail: String, subtitle: String, emoji: String? = nil) {
           titleLabel.text = title
           detailLabel.text = detail
           subtitleLabel.text = subtitle
           emojiLabel.text = emoji
           progressBar.isHidden = true
           graphView.isHidden = true
       }
       
       func configure(title: String, progress: Float, subtitle: String) {
           titleLabel.text = title
           detailLabel.isHidden = true
           subtitleLabel.text = subtitle
           emojiLabel.isHidden = true
           progressBar.isHidden = false
           progressBar.progress = progress
           graphView.isHidden = true
       }
       
       func configureGraph() {
           titleLabel.isHidden = true
           detailLabel.isHidden = true
           subtitleLabel.isHidden = true
           emojiLabel.isHidden = true
           progressBar.isHidden = true
           graphView.isHidden = false
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
