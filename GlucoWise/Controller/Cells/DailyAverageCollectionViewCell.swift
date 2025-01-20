// Place this at the top or bottom of DailyAverageCollectionViewCell.swift
import UIKit


protocol DailyAverageCollectionViewCellDelegate: AnyObject {
    func didTapInsightsButton()
}


class DailyAverageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var glucoseReactionLbl: UIImageView!
    @IBOutlet var glucoseChangeLabel: UILabel!
    @IBOutlet var glucoseLastUppdatedLbl: UILabel!
    @IBOutlet var glucoseLabel: UILabel!
    @IBOutlet var glucoseValueLabel: UILabel!
    var insightsButton: UIButton!
    
    weak var delegate: DailyAverageCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        // Initialize UI elements
        glucoseLabel = UILabel()
        glucoseChangeLabel = UILabel()
        glucoseLastUppdatedLbl = UILabel()
        glucoseValueLabel = UILabel()
        glucoseReactionLbl = UIImageView()
        insightsButton = UIButton(type: .system)
        
        glucoseReactionLbl.contentMode = .scaleAspectFit
        insightsButton.setTitle(">", for: .normal)
        insightsButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        insightsButton.setTitleColor(.systemGray2, for: .normal)
        
        // Add components to the content view
        contentView.addSubview(glucoseLabel)
        contentView.addSubview(glucoseValueLabel)
        contentView.addSubview(glucoseChangeLabel)
        contentView.addSubview(glucoseLastUppdatedLbl)
        contentView.addSubview(glucoseReactionLbl)
        contentView.addSubview(insightsButton)
        
        // Configure UI and layout
        configureUI()
        setupConstraints()
        
        // Add button action
        insightsButton.addTarget(self, action: #selector(insightsButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        glucoseLabel.font = UIFont.boldSystemFont(ofSize: 22)
        glucoseLabel.textColor = .black
        
        glucoseValueLabel.font = UIFont.systemFont(ofSize: 40)
        glucoseValueLabel.textColor = UIColor(.black)
        
        glucoseChangeLabel.font = UIFont.systemFont(ofSize: 12)
        glucoseChangeLabel.textColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        
        glucoseLastUppdatedLbl.font = UIFont.systemFont(ofSize: 10)
        glucoseLastUppdatedLbl.textColor = UIColor(.black)
        insightsButton.titleLabel?.textColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
    }
    
    private func setupConstraints() {
        glucoseLabel.translatesAutoresizingMaskIntoConstraints = false
        glucoseValueLabel.translatesAutoresizingMaskIntoConstraints = false
        glucoseChangeLabel.translatesAutoresizingMaskIntoConstraints = false
        glucoseLastUppdatedLbl.translatesAutoresizingMaskIntoConstraints = false
        glucoseReactionLbl.translatesAutoresizingMaskIntoConstraints = false
        insightsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Insights Button (Top Left Corner)
            insightsButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            insightsButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            insightsButton.widthAnchor.constraint(equalToConstant: 30),
            insightsButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Glucose Label (Below Button)
            glucoseLabel.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            glucoseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            glucoseLabel.trailingAnchor.constraint(lessThanOrEqualTo: glucoseReactionLbl.leadingAnchor, constant: -20),
            
            
            // Glucose Value Label
            glucoseValueLabel.topAnchor.constraint(equalTo: glucoseLabel.bottomAnchor, constant: 20),
            glucoseValueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Glucose Change Label
            glucoseChangeLabel.topAnchor.constraint(equalTo: glucoseValueLabel.bottomAnchor, constant: 25),
            glucoseChangeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Glucose Last Updated Label
            glucoseLastUppdatedLbl.topAnchor.constraint(equalTo: glucoseChangeLabel.bottomAnchor, constant: 10),
            glucoseLastUppdatedLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            // Glucose Reaction Image View
            glucoseReactionLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            glucoseReactionLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            glucoseReactionLbl.widthAnchor.constraint(equalToConstant: 120),
            glucoseReactionLbl.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    
    
       @objc func insightsButtonTapped() {
           delegate?.didTapInsightsButton()
       }
    
}
