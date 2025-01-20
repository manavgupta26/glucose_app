import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // UI Components
    var tableView: UITableView!
    var recipeImageView: UIImageView!
    var recipeTitleLabel: UILabel!
    var recipeDescriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupUI()
        layoutUI()
    }

    private func setupUI() {
        // Recipe Image View
        recipeImageView = UIImageView()
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.image = UIImage(named: recipeData[0].imageName)
        recipeImageView.clipsToBounds = true
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(recipeImageView)
        NSLayoutConstraint.activate([
             // Example top constraint
            recipeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor), // Center horizontally
            recipeImageView.widthAnchor.constraint(equalToConstant: 100), // Set the desired width
            recipeImageView.heightAnchor.constraint(equalToConstant: 200) // Adjust height as needed
        ])

        // Recipe Title Label
        recipeTitleLabel = UILabel()
        recipeTitleLabel.text = recipeData[0].title
        recipeTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        recipeTitleLabel.textColor = .black
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeTitleLabel)

        // Recipe Description Label
        recipeDescriptionLabel = UILabel()
        recipeDescriptionLabel.text = recipeData[0].description
        recipeDescriptionLabel.font = UIFont.systemFont(ofSize: 16)
        recipeDescriptionLabel.textColor = .black
        recipeDescriptionLabel.numberOfLines = 0
        recipeDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recipeDescriptionLabel)

        // Table View
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "IngredientCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }

    private func layoutUI() {
        NSLayoutConstraint.activate([
            // Recipe Image View
            recipeImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
               recipeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
               recipeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
               recipeImageView.heightAnchor.constraint(equalToConstant: 200),

            // Recipe Title Label
            recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.bottomAnchor, constant: 16),
            recipeTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipeTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Recipe Description Label
            recipeDescriptionLabel.topAnchor.constraint(equalTo: recipeTitleLabel.bottomAnchor, constant: 8),
            recipeDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipeDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            // Table View
            tableView.topAnchor.constraint(equalTo: recipeDescriptionLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        recipeImageView.layer.cornerRadius = 20
        recipeImageView.layer.masksToBounds = true
    }

    // MARK: - Table View Data Source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipeData[0].ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = recipeData[0].ingredients[indexPath.row]
        cell.textLabel?.textColor = .black
        return cell
    }
}
