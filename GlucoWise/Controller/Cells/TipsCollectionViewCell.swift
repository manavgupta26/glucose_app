//
//  TipsCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var tipImageView: UIImageView!
    
    @IBOutlet var tipTitleLabel: UILabel!
   
    @IBOutlet var tipDescriptionLabel: UILabel!
  
    
    @IBOutlet var actionNameBtn: UIButton!
    @IBAction func btnPressed(_ sender: UIButton) {
        print("Button pressed")
    }
    override init(frame: CGRect) {
            super.init(frame: frame)
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = true
            
            // Initialize components
            tipImageView = UIImageView()
            tipTitleLabel = UILabel()
            tipDescriptionLabel = UILabel()
        actionNameBtn = UIButton()
            // Configure components
            tipImageView?.contentMode = .scaleAspectFit
            tipImageView?.clipsToBounds = true
            
            tipTitleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            tipTitleLabel?.textColor = .black
            tipTitleLabel?.numberOfLines = 2
            
            tipDescriptionLabel?.font = UIFont.systemFont(ofSize: 12)
            tipDescriptionLabel?.textColor = .darkGray
            tipDescriptionLabel?.numberOfLines = 3
            
            actionNameBtn?.setTitle("Learn More", for: .normal)
            actionNameBtn?.tintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        configureUI()
            actionNameBtn?.addTarget(self, action: #selector(btnPressed(_:)), for: .touchUpInside)
            // Add components to the content view
            contentView.addSubview(tipImageView)
            contentView.addSubview(tipTitleLabel)
            contentView.addSubview(tipDescriptionLabel)
        contentView.addSubview(actionNameBtn)
            // Set up layout constraints
        
            setupConstraints()
        
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    private func configureUI(){
        if #available(iOS 15.0, *) {
            var config = UIButton.Configuration.filled()
            config.baseBackgroundColor = .clear // Transparent background
            config.baseForegroundColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0) // Teal color for text and icon
            config.cornerStyle = .medium // Rounded corners

            // Set the title with a custom font
            var titleAttr = AttributedString("View Recipe")
            titleAttr.font = UIFont.systemFont(ofSize: 12, weight: .medium) // Custom font size and weight
            config.attributedTitle = titleAttr

            config.image = UIImage(systemName: "chevron.right") // ">" icon
            config.imagePlacement = .trailing // Icon on the right
            config.imagePadding = 2 // Padding between title and icon

            actionNameBtn.configuration = config
            actionNameBtn.tintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        } else {
            // Fallback for older iOS versions
            actionNameBtn.layer.cornerRadius = 4
            actionNameBtn.clipsToBounds = true

            let greaterThanImage = UIImage(systemName: "chevron.right") // System-provided ">" icon
            actionNameBtn.setImage(greaterThanImage, for: .normal)
            actionNameBtn.tintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
            // Set the icon color to teal

            actionNameBtn.setTitle("View Recipe", for: .normal)
            actionNameBtn.setTitleColor(UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0), for: .normal)
            actionNameBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)

            // Adjust the alignment of title and image
            actionNameBtn.contentHorizontalAlignment = .leading
            actionNameBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
            actionNameBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 30)
        }
    }
        private func setupConstraints() {
            
            // Disable autoresizing masks
            tipImageView.translatesAutoresizingMaskIntoConstraints = false
            tipTitleLabel.translatesAutoresizingMaskIntoConstraints = false
            tipDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            actionNameBtn.translatesAutoresizingMaskIntoConstraints = false
            // Add constraints
            NSLayoutConstraint.activate([
                // Tip Image View - Top and Center
                tipImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                tipImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                tipImageView.widthAnchor.constraint(equalToConstant: 80),
                tipImageView.heightAnchor.constraint(equalToConstant: 80),
                
                // Tip Title Label - Below Image
                tipTitleLabel.topAnchor.constraint(equalTo: tipImageView.bottomAnchor, constant: 10),
                tipTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                tipTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                // Tip Description Label - Below Title
                tipDescriptionLabel.topAnchor.constraint(equalTo: tipTitleLabel.bottomAnchor, constant: 5),
                tipDescriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                tipDescriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                tipDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
                actionNameBtn.topAnchor.constraint(equalTo: tipDescriptionLabel.bottomAnchor, constant: 10),
                        actionNameBtn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                        actionNameBtn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                        actionNameBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),  // 10 points from bottom
                        actionNameBtn.heightAnchor.constraint(equalToConstant: 40)  
            ])
        }
}
