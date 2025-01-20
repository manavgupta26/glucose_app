//
//  foodItemhViewController.swift
//  GlucoWise
//
//  Created by Manav Gupta on 18/01/25.
//

import UIKit

class foodItemhViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource {
    
    

    
    @IBOutlet weak var collectview: UICollectionView!
    @IBOutlet weak var tablview: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       


               // Set data source and delegate
               collectview.dataSource = self
               collectview.delegate = self
        tablview.dataSource=self
        tablview.delegate=self
               // Register cells using nib files (if you use XIBs)
        collectview.register(foodItemimageCollectionViewCell.self, forCellWithReuseIdentifier: "imagecell")
                collectview.register(giIndexCollectionViewCell.self, forCellWithReuseIdentifier: "gicell")


    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 2 // Return the number of items you want to display
       }

       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           print("Creating cell for index \(indexPath.item)")  // Debugging output

           if indexPath.item == 0 {
               let cell = collectview.dequeueReusableCell(withReuseIdentifier: "imagecell", for: indexPath) as! foodItemimageCollectionViewCell
               cell.img.image = UIImage(named: "aalo")
               return cell
           } else {
               let cell = collectview.dequeueReusableCell(withReuseIdentifier: "gicell", for: indexPath) as! giIndexCollectionViewCell
               return cell
           }
       }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    let arr = ["Carbs","Protiens","Fats","Fiber"]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablview.dequeueReusableCell(withIdentifier: "mac", for: indexPath)
        cell.textLabel?.text = arr[indexPath.row]
        cell.detailTextLabel?.text = arr[indexPath.row]
        return cell
    }


}
