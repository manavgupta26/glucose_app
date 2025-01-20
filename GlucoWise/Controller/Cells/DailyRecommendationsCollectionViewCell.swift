//
//  DailyRecommendationsCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit
protocol DailyRecommendationsCollectionViewCellDelegate: AnyObject {
    func didTapOnViewRecipieButton()
}

class DailyRecommendationsCollectionViewCell: UICollectionViewCell {
    weak var delegate: DailyRecommendationsCollectionViewCellDelegate?
    
    @IBOutlet var lastMealLabel: UILabel!
    
    @IBOutlet var nextMealImage: UILabel!
    @IBOutlet var lastMealImage: UILabel!
    @IBOutlet var carbsPointer: UIProgressView!
    @IBOutlet var gIlbl: UILabel!
    @IBOutlet var carbsLbl: UILabel!
    @IBOutlet var nextMealRecommendation: UILabel!
    @IBOutlet var GIPointer: UIProgressView!
    
    @IBOutlet var recommendedNextMealLabel: UILabel!
    
    @IBOutlet var viewRecipieButton: UIButton!
    
    var carbsTooltip: UILabel!
    var giTooltip: UILabel!
   @IBAction func recipieButtonClicked(_ sender: UIButton) {
       print("Recipe button clicked for recommended meal: \(recommendedNextMealLabel.text ?? "Unknown")")
       
    }
    

   
    override init(frame: CGRect) {
                super.init(frame: frame)
             lastMealLabel = UILabel()
                carbsLbl = UILabel()
                carbsPointer = UIProgressView()
                  gIlbl = UILabel()
                  GIPointer = UIProgressView()
                 lastMealImage = UILabel()
                 recommendedNextMealLabel = UILabel()
                nextMealRecommendation = UILabel()
                 nextMealImage = UILabel()
        viewRecipieButton=UIButton()
        contentView.backgroundColor = .white
                configureUI()
//                setupConstraints()
                setupLayout()
            }
            
            required init?(coder: NSCoder) {
                super.init(coder: coder)
                configureUI()
//                setupConstraints()
                setupLayout()
            }
        
        // MARK: - UI Configuration
         func configureUI() {
            // Configure labels
             carbsTooltip = UILabel()
             carbsTooltip.backgroundColor = UIColor.black.withAlphaComponent(0.8)
             carbsTooltip.textColor = .white
             carbsTooltip.font = UIFont.systemFont(ofSize: 10, weight: .medium)
             carbsTooltip.textAlignment = .center
             carbsTooltip.layer.cornerRadius = 4
             carbsTooltip.clipsToBounds = true
             carbsTooltip.isHidden = true
             contentView.addSubview(carbsTooltip)
             
             giTooltip = UILabel()
             giTooltip.backgroundColor = UIColor.black.withAlphaComponent(0.8)
             giTooltip.textColor = .white
             giTooltip.font = UIFont.systemFont(ofSize: 10, weight: .medium)
             giTooltip.textAlignment = .center
             giTooltip.layer.cornerRadius = 4
             giTooltip.clipsToBounds = true
             giTooltip.isHidden = true
             contentView.addSubview(giTooltip)
             let carbsLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showCarbsTooltip(_:)))
             carbsPointer.addGestureRecognizer(carbsLongPressGesture)
             carbsPointer.isUserInteractionEnabled = true
             
             let giLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showGITooltip(_:)))
            lastMealLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            lastMealLabel.textColor = .label
             lastMealLabel.adjustsFontSizeToFitWidth = true
                 lastMealLabel.minimumScaleFactor = 0.5 // Font can shrink to 50% of its original size
                 lastMealLabel.numberOfLines = 1
//             lastMealLabel.lineBreakMode = .byWordWrapping
             lastMealLabel.preferredMaxLayoutWidth = 30
             lastMealLabel.textAlignment = .left
            carbsLbl.text = "Carb"
            carbsLbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            carbsLbl.textColor = .secondaryLabel
            
            gIlbl.text = "G.I."
            gIlbl.font = UIFont.systemFont(ofSize: 12, weight: .regular)
            gIlbl.textColor = .secondaryLabel
            
            recommendedNextMealLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
            recommendedNextMealLabel.textColor = .label
            
            nextMealRecommendation.font = UIFont.systemFont(ofSize: 12, weight: .regular)
             nextMealRecommendation.textColor = .darkGray
             nextMealRecommendation.textAlignment = .left
            
            // Configure progress views
            carbsPointer.trackTintColor = .lightGray
            carbsPointer.progressTintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
            carbsPointer.layer.cornerRadius = 2
            carbsPointer.clipsToBounds = true
            
            GIPointer.trackTintColor = .lightGray
            GIPointer.progressTintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
            GIPointer.layer.cornerRadius = 2
            GIPointer.clipsToBounds = true
            
            // Configure image views
             lastMealImage.font = UIFont.systemFont(ofSize: 40, weight: .medium)
            nextMealImage.font = UIFont.systemFont(ofSize: 40, weight: .medium)
             viewRecipieButton.addTarget(self, action: #selector(didTapOnViewRecipieButton), for: .touchUpInside)


                 
            
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

                 viewRecipieButton.configuration = config
                 viewRecipieButton.tintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
             } else {
                 // Fallback for older iOS versions
                 viewRecipieButton.layer.cornerRadius = 4
                 viewRecipieButton.clipsToBounds = true

                 let greaterThanImage = UIImage(systemName: "chevron.right") // System-provided ">" icon
                 viewRecipieButton.setImage(greaterThanImage, for: .normal)
                 viewRecipieButton.tintColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
                 // Set the icon color to teal

                 viewRecipieButton.setTitle("View Recipe", for: .normal)
                 viewRecipieButton.setTitleColor(UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0), for: .normal)
                 viewRecipieButton.titleLabel?.font = UIFont.systemFont(ofSize: 10, weight: .medium)

                 // Adjust the alignment of title and image
                 viewRecipieButton.contentHorizontalAlignment = .leading
                 viewRecipieButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
                 viewRecipieButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 30)
             }



            // Add subviews to the contentView
            contentView.addSubview(lastMealImage)
            contentView.addSubview(lastMealLabel)
            contentView.addSubview(carbsLbl)
            contentView.addSubview(carbsPointer)
            contentView.addSubview(gIlbl)
            contentView.addSubview(GIPointer)
            contentView.addSubview(nextMealImage)
            contentView.addSubview(recommendedNextMealLabel)
            contentView.addSubview(nextMealRecommendation)
            contentView.addSubview(viewRecipieButton)
        }
        
       
         
        
        // MARK: - Cell Configuration
        
         func setupLayout() {
            // Disable autoresizing masks
            [lastMealImage, lastMealLabel, carbsLbl, carbsPointer, gIlbl, GIPointer,
             nextMealImage, recommendedNextMealLabel, nextMealRecommendation,viewRecipieButton].forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
            }
            
            // Left Stack (Last Meal Section)
            let carbStack = UIStackView(arrangedSubviews: [carbsLbl, carbsPointer])
            carbStack.axis = .horizontal
            carbStack.spacing = 2
            carbStack.alignment = .center
            
            let giStack = UIStackView(arrangedSubviews: [gIlbl, GIPointer])
            giStack.axis = .horizontal
            giStack.spacing = 22
            giStack.alignment = .center
            
            let semiStack = UIStackView(arrangedSubviews: [carbStack, giStack])
             semiStack.axis = .vertical
             semiStack.spacing = 8
             semiStack.alignment = .leading
            
            // Right Stack (Recommended Next Meal Section)
             let leftSemiStack = UIStackView(arrangedSubviews: [lastMealImage, semiStack])
             leftSemiStack.axis = .horizontal
                 leftSemiStack.spacing = 2
                 leftSemiStack.alignment = .center
//             leftStack.distribution = .fillProportionally
             let leftStack=UIStackView(arrangedSubviews: [lastMealLabel, leftSemiStack])
             leftStack.axis = .vertical
             leftStack.spacing = 10
             leftStack.alignment = .leading
             
            let rightSemiStack = UIStackView(arrangedSubviews: [  nextMealRecommendation,viewRecipieButton])
            rightSemiStack.axis = .vertical
            rightSemiStack.spacing = 20
            rightSemiStack.alignment = .leading
             let rightImStack=UIStackView(arrangedSubviews: [nextMealImage, rightSemiStack])
             rightImStack.axis = .horizontal
             rightImStack.spacing = 3
             rightImStack.alignment = .center
             
             let rightStack=UIStackView(arrangedSubviews: [recommendedNextMealLabel, rightImStack])
             rightStack.axis = .vertical
             rightStack.spacing = 10
             rightStack.alignment = .leading
            
            // Main Horizontal Stack
            let mainStack = UIStackView(arrangedSubviews: [leftStack, rightStack])
            mainStack.axis = .horizontal
            mainStack.spacing = 16
            mainStack.alignment = .center
             mainStack.distribution = .fillEqually
            
            contentView.addSubview(mainStack)
             carbsTooltip.translatesAutoresizingMaskIntoConstraints = false
             giTooltip.translatesAutoresizingMaskIntoConstraints = false
             

             mainStack.translatesAutoresizingMaskIntoConstraints = false
                    lastMealImage.translatesAutoresizingMaskIntoConstraints = false
                    nextMealImage.translatesAutoresizingMaskIntoConstraints = false
             viewRecipieButton.translatesAutoresizingMaskIntoConstraints=false
                    // Constraints
                    NSLayoutConstraint.activate([
                        
                        carbsTooltip.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                        carbsTooltip.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -10),
                        giTooltip.leadingAnchor.constraint(equalTo:  contentView.leadingAnchor, constant: 10),
                        giTooltip.trailingAnchor.constraint(equalTo:  contentView.trailingAnchor, constant: -10),
                        
                        mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                        mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                        mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                        mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),

                        lastMealImage.widthAnchor.constraint(equalToConstant: 50),
                        lastMealImage.heightAnchor.constraint(equalToConstant: 50),

                        nextMealImage.widthAnchor.constraint(equalToConstant: 50),
                        nextMealImage.heightAnchor.constraint(equalToConstant: 50),
                        carbsPointer.widthAnchor.constraint(equalToConstant: 80),
                        carbsPointer.heightAnchor.constraint(equalToConstant: 5),
                        GIPointer.widthAnchor.constraint(equalToConstant: 80),
                        GIPointer.heightAnchor.constraint(equalToConstant: 5),
                        viewRecipieButton.heightAnchor.constraint(equalToConstant: 10),
                        viewRecipieButton.widthAnchor.constraint(equalToConstant: 150),
                        
                    ])
            // Constraints
        }
        
        func configureCell(lastMeal: String, lastMealImage: String, carbProgress: Float, giProgress: Float, nextMeal: String, nextMealImage: String, viewRecipe: String) {
            // Left Section
            self.lastMealLabel.text = "Last Meal: \(lastMeal)"
            self.lastMealImage.text = lastMealImage
            self.carbsPointer.progress = carbProgress
            self.GIPointer.progress = giProgress
            
            // Right Section
            self.recommendedNextMealLabel.text = nextMeal
            self.nextMealImage.text = nextMealImage
            self.nextMealRecommendation.text = viewRecipe
//            self.nextMealRecommendation.textColor = .systemBlue
        }
    @objc private func showCarbsTooltip(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            carbsTooltip.text = "Carbs: \(Int(carbsPointer.progress * 100))%"
            carbsTooltip.sizeToFit()
            
            // Position tooltip above the carbsPointer (UIProgressView)
            let progressFrame = carbsPointer.convert(carbsPointer.bounds, to: contentView)
            carbsTooltip.frame = CGRect(
                x: progressFrame.midX  - carbsTooltip.frame.width / 3,
                y: progressFrame.minY - carbsTooltip.frame.height - 8,
                width: carbsTooltip.frame.width + 8,
                height: carbsTooltip.frame.height + 4
            )
            
            carbsTooltip.isHidden = false
        } else if gesture.state == .ended || gesture.state == .cancelled {
            carbsTooltip.isHidden = true
        }
    }

    @objc private func showGITooltip(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            giTooltip.text = "G.I.: \(Int(GIPointer.progress * 100))%"
            giTooltip.sizeToFit()
            
            // Position tooltip above the GIPointer (UIProgressView)
            let progressFrame = GIPointer.convert(GIPointer.bounds, to: contentView)
            giTooltip.frame = CGRect(
                x: progressFrame.midX ,
                y: progressFrame.minY,
                width: giTooltip.frame.width + 8,
                height: giTooltip.frame.height + 4
            )
            
            giTooltip.isHidden = false
        } else if gesture.state == .ended || gesture.state == .cancelled {
            giTooltip.isHidden = true
        }
    }
    @objc func didTapOnViewRecipieButton() {
        delegate?.didTapOnViewRecipieButton()
    }

}
