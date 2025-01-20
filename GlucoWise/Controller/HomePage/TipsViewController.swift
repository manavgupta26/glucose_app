import UIKit

class TipsViewController: UIViewController {
    
    // MARK: - Properties
    var tip: Tip? // The Tip object passed to this view controller
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let headingLabel = UILabel()
    private let tipImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let detailsLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 247/255, alpha: 1.0)
        
        setupScrollView()
        setupHeadingLabel()
        setupImageView()
        setupDescriptionLabel()
        setupDetailsLabel()
        populateData()
    }
    
    // MARK: - Setup Methods
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupHeadingLabel() {
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.textColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        headingLabel.textAlignment = .center
        headingLabel.numberOfLines = 0
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headingLabel)
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupImageView() {
        tipImageView.contentMode = .scaleAspectFit
        tipImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tipImageView)
        
        NSLayoutConstraint.activate([
            tipImageView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            tipImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tipImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            tipImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupDescriptionLabel() {
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: tipImageView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupDetailsLabel() {
        detailsLabel.font = UIFont.systemFont(ofSize: 14)
        detailsLabel.textColor = UIColor(red: 85/255, green: 173/255, blue: 156/255, alpha: 1.0)
        detailsLabel.numberOfLines = 0
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(detailsLabel)
        
        NSLayoutConstraint.activate([
            detailsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Data Population
    private func populateData() {
        guard let tip = tip else { return }
        headingLabel.text = tip.name
        tipImageView.image = UIImage(named: tip.imageName)
        descriptionLabel.text = tip.description
        detailsLabel.text = tip.details
    }
}
