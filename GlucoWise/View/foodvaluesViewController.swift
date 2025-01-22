//
//  FoodValuesViewController.swift
//  GlucoWise
//
//  Created by Manav Gupta on 20/01/25.
//

import UIKit

class foodvaluesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let nutrients = [("Carbs", "73 g"), ("Protein", "19 g"), ("Fats", "21 g"), ("Fiber", "9 g")]
    private let tableView = UITableView()
    private var quantityDropdown: UIButton!
    var imagew : UIImage!
        private var measureDropdown: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGray5

        // Configure navigation bar'
        navigationItem.largeTitleDisplayMode = .never
        //navigationItem.title = "Aloo Paratha"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))

        setupViews()
    }

    @objc private func doneButtonTapped() {
        self.dismiss(animated: true)
    }
    
    private func setupViews() {
        // Image
        let imageView = UIImageView(image : imagew)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        // Quantity Label
        let quantityLabel = UILabel()
        quantityLabel.text = "Quantity"
        quantityLabel.font = UIFont.systemFont(ofSize: 14)
        quantityLabel.textColor = .gray
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityLabel)

        // Quantity Dropdown
        let quantityDropdown = UIButton(type: .system)
        quantityDropdown.setTitle("2.0 ▼", for: .normal)
        quantityDropdown.setTitleColor(.black, for: .normal)
        quantityDropdown.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        quantityDropdown.backgroundColor = UIColor.systemGray6
        quantityDropdown.layer.cornerRadius = 8
        quantityDropdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quantityDropdown)

        // Measure Label
        let measureLabel = UILabel()
        measureLabel.text = "Measure"
        measureLabel.font = UIFont.systemFont(ofSize: 14)
        measureLabel.textColor = .gray
        measureLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(measureLabel)

        // Measure Dropdown
        let measureDropdown = UIButton(type: .system)
        measureDropdown.setTitle("Piece ▼", for: .normal)
        measureDropdown.setTitleColor(.black, for: .normal)
        measureDropdown.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        measureDropdown.backgroundColor = UIColor.systemGray6
        measureDropdown.layer.cornerRadius = 8
        measureDropdown.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(measureDropdown)
        quantityDropdown.addTarget(self, action: #selector(showQuantityOptions), for: .touchUpInside)
        measureDropdown.addTarget(self, action: #selector(showMeasureOptions), for: .touchUpInside)

        let giContainer = UIView()
        giContainer.backgroundColor = .white
        giContainer.layer.cornerRadius = 8
        giContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giContainer)

        // GI Index View
        let giIndexLabel = UILabel()
        giIndexLabel.text = "GI Index"
        giIndexLabel.font = UIFont.systemFont(ofSize: 14)
        giIndexLabel.textColor = .gray
        giIndexLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giIndexLabel)

        let giCircle = UILabel()
        giCircle.text = "GI"
        giCircle.textColor = .white
        giCircle.textAlignment = .center
        giCircle.font = UIFont.boldSystemFont(ofSize: 16)
        giCircle.backgroundColor = UIColor(hex: "#6CAB9C")
        giCircle.layer.cornerRadius = 25
        giCircle.clipsToBounds = true
        giCircle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giCircle)

        let giValueLabel = UILabel()
        giValueLabel.text = "80"
        giValueLabel.font = UIFont.boldSystemFont(ofSize: 28)
        giValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giValueLabel)

        let giDescriptionLabel = UILabel()
        giDescriptionLabel.text = "Glycemic Index"
        giDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        giDescriptionLabel.textColor = .gray
        giDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giDescriptionLabel)

        let giSummaryLabel = UILabel()
        giSummaryLabel.text = """
        It will take 40 minutes of running to burn 400 calories. Your meal has high carbs. Add more fibre or protein in your next meal to help stabilize blood sugar.
        """
        giSummaryLabel.font = UIFont.systemFont(ofSize: 14)
        giSummaryLabel.textColor = .gray
        giSummaryLabel.numberOfLines = 4
        giSummaryLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(giSummaryLabel)

        // Macronutrient Label
        let macronutrientLabel = UILabel()
        macronutrientLabel.text = "Macronutrient Breakdown"
        macronutrientLabel.font = UIFont.systemFont(ofSize: 14)
        macronutrientLabel.textColor = .gray
        macronutrientLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(macronutrientLabel)

        // Macronutrient TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NutrientCell")
        tableView.layer.cornerRadius = 8
        //tableView.backgroundColor = UIColor.systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        // Constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 370),
            imageView.heightAnchor.constraint(equalToConstant: 170),

            quantityLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            quantityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            quantityDropdown.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 8),
            quantityDropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            quantityDropdown.widthAnchor.constraint(equalToConstant: 100),
            quantityDropdown.heightAnchor.constraint(equalToConstant: 40),

            measureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            measureLabel.leadingAnchor.constraint(equalTo: quantityDropdown.trailingAnchor, constant: 16),

            measureDropdown.topAnchor.constraint(equalTo: measureLabel.bottomAnchor, constant: 8),
            measureDropdown.leadingAnchor.constraint(equalTo: quantityDropdown.trailingAnchor, constant: 16),
            measureDropdown.widthAnchor.constraint(equalToConstant: 100),
            measureDropdown.heightAnchor.constraint(equalToConstant: 40),

            // GI Container
                giContainer.topAnchor.constraint(equalTo: quantityDropdown.bottomAnchor, constant: 16),
                giContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                giContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                giContainer.bottomAnchor.constraint(equalTo: giSummaryLabel.bottomAnchor, constant: 16),

                // GI Index Label
                giIndexLabel.topAnchor.constraint(equalTo: giContainer.topAnchor, constant: 16),
                giIndexLabel.leadingAnchor.constraint(equalTo: giContainer.leadingAnchor, constant: 16),

                // GI Circle
                giCircle.topAnchor.constraint(equalTo: giIndexLabel.bottomAnchor, constant: 8),
                giCircle.leadingAnchor.constraint(equalTo: giContainer.leadingAnchor, constant: 16),
                giCircle.widthAnchor.constraint(equalToConstant: 50),
                giCircle.heightAnchor.constraint(equalToConstant: 50),

                // GI Value Label
                giValueLabel.centerYAnchor.constraint(equalTo: giCircle.centerYAnchor),
                giValueLabel.leadingAnchor.constraint(equalTo: giCircle.trailingAnchor, constant: 16),

                // GI Description Label
                giDescriptionLabel.topAnchor.constraint(equalTo: giValueLabel.bottomAnchor, constant: 4),
                giDescriptionLabel.leadingAnchor.constraint(equalTo: giCircle.trailingAnchor, constant: 16),

                // GI Summary Label
                giSummaryLabel.topAnchor.constraint(equalTo: giCircle.bottomAnchor, constant: 16),
                giSummaryLabel.leadingAnchor.constraint(equalTo: giContainer.leadingAnchor, constant: 16),
            giSummaryLabel.trailingAnchor.constraint(equalTo: giContainer.trailingAnchor, constant: -16),
            
            macronutrientLabel.topAnchor.constraint(equalTo: giSummaryLabel.bottomAnchor, constant: 35),
            macronutrientLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            tableView.topAnchor.constraint(equalTo: macronutrientLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            //tableView.heightAnchor.constraint(equalToConstant: 200)
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(nutrients.count * 40))
        ])
        
    }
    @objc private func showQuantityOptions() {
        let alert = UIAlertController(title: "Select Quantity", message: nil, preferredStyle: .actionSheet)
        let options = ["1.0", "2.0", "3.0", "4.0"]
        for option in options {
            alert.addAction(UIAlertAction(title: option, style: .default, handler: { [weak self] _ in
                self?.quantityDropdown.setTitle("\(option) ▼", for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    @objc private func showMeasureOptions() {
        let alert = UIAlertController(title: "Select Measure", message: nil, preferredStyle: .actionSheet)
        let options = ["Piece", "Gram", "Cup"]
        for option in options {
            alert.addAction(UIAlertAction(title: option, style: .default, handler: { [weak self] _ in
                self?.measureDropdown.setTitle("\(option) ▼", for: .normal)
            }))
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutrients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientCell", for: indexPath)
        let (name, value) = nutrients[indexPath.row]
        cell.textLabel?.text = "\(name): \(value)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

