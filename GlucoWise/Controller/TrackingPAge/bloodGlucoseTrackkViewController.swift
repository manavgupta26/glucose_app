import UIKit

class bloodGlucoseTrackkViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate {

    let images = ["graphh", "graphh", "graphh"] // Replace with your image names
    let readings = [
        ("Post Meal", "10:00 PM", "120 mg/dL"),
        ("Pre Meal", "4:00 PM", "90 mg/dL"),
        ("Fasting", "7:00 AM", "85 mg/dL"),
        ("Post Meal", "10:00 PM", "120 mg/dL"),
        ("Pre Meal", "4:00 PM", "90 mg/dL"),
        ("Fasting", "7:00 AM", "85 mg/dL"),
        ("Post Meal", "10:00 PM", "120 mg/dL"),
        ("Pre Meal", "4:00 PM", "90 mg/dL"),
        ("Fasting", "7:00 AM", "85 mg/dL")
    ]
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!
    var tableView: UITableView!
    var scrollView: UIScrollView!
    var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // MARK: - ScrollView Setup
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        // MARK: - Horizontal Scrollable Collection View
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 360, height: 310)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)

        pageControl = UIPageControl()
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageControl)

        // MARK: - Readings Section
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(headerView)

        let readingsLabel = UILabel()
        readingsLabel.text = "Readings"
        readingsLabel.font = .boldSystemFont(ofSize: 18)
        readingsLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(readingsLabel)

        let addReadingButton = UIButton(type: .custom)
        addReadingButton.setTitle("Add Reading", for: .normal)
        addReadingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)

        // Set background color using hex
        addReadingButton.backgroundColor = UIColor(hex: "#6CAB9C") // Make sure the background color is applied

        // Set text color (white)
        addReadingButton.setTitleColor(UIColor(hex: "#FFFFFF"), for: .normal)

        // Optional: Make the button corners rounded
        addReadingButton.layer.cornerRadius = 10
        addReadingButton.layer.masksToBounds = true

        addReadingButton.addTarget(self, action: #selector(addReadingTapped), for: .touchUpInside)
        addReadingButton.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(addReadingButton)

        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ReadingCell")
        tableView.isScrollEnabled = false // Disable table view scrolling; rely on scroll view
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)

        // MARK: - Constraints
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            // ContentView inside ScrollView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Collection View
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 310),

            // Page Control
            pageControl.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            pageControl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            // Readings Header
            headerView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 40),

            // Readings Label
            readingsLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            readingsLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),

            // Add Reading Button (shifted to extreme right)
            addReadingButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 10), // Adjusted constant for margin
            addReadingButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            addReadingButton.widthAnchor.constraint(equalToConstant: 120), // Set width of the button to be visible
            addReadingButton.heightAnchor.constraint(equalToConstant: 30), // Set height of the button

            // Table View
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: CGFloat(readings.count * 50)), // Calculate height based on rows
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20) // Bottom padding
        ])
    }

    // MARK: - UICollectionView DataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = round(scrollView.contentOffset.x / collectionView.frame.width)
            pageControl.currentPage = Int(pageIndex)
        }
    }

    // MARK: - UITableView DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReadingCell", for: indexPath)
        let reading = readings[indexPath.row]

        cell.textLabel?.text = reading.0
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.detailTextLabel?.text = reading.1
        cell.detailTextLabel?.font = .systemFont(ofSize: 14)
        cell.detailTextLabel?.textColor = .gray

        let glucoseLabel = UILabel()
        glucoseLabel.text = reading.2
        glucoseLabel.font = .systemFont(ofSize: 16)
        glucoseLabel.textColor = .darkGray
        glucoseLabel.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(glucoseLabel)

        NSLayoutConstraint.activate([
            glucoseLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            glucoseLabel.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -20)
        ])

        cell.selectionStyle = .none
        return cell
    }

    // MARK: - Actions

    @objc func addReadingTapped() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "addBloodReading") as? addBloodReadingTableViewController {
            vc.modalPresentationStyle = .popover
            vc.popoverPresentationController?.delegate = self
            present(vc, animated: true)
        }
    }
}

// MARK: - Custom UICollectionViewCell

class ImageCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.frame = contentView.bounds
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIColor Extension for Hex Values

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
