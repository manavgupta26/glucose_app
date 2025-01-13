////
////  trackBloodSugarViewController.swift
////  GlucoWise
////
////  Created by student-2 on 24/12/24.
////
//
import UIKit

//import DGCharts
class trackBloodSugarViewController: UIViewController {
    
    
    @IBOutlet weak var readingsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func addReadingBtnTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "mainPage", bundle: nil)
        if let secondvc = storyboard.instantiateViewController(withIdentifier: "addBloodReading") as? addBloodReadingTableViewController{
            if secondvc.navigationController == nil {
                        let navController = UINavigationController(rootViewController: secondvc)
                navController.modalPresentationStyle = .popover
                        self.present(navController, animated: true, completion: nil)
                    } else {
                        secondvc.modalPresentationStyle = .popover
                        self.present(secondvc, animated: true, completion: nil)
                    }
        }
        
    }
    
}
    
  
