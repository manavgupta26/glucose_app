////
////  TrackingViewController.swift
////  GlucoWise
////
////  Created by student-2 on 24/12/24.
////
//
import UIKit

class TrackingViewController: UIViewController {
    
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var containerView: UIView!
    private var currentViewController: UIViewController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        switchToViewController(at: 0)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        switchToViewController(at: sender.selectedSegmentIndex)
    }
    private func switchToViewController(at index: Int) {
        // Remove the current child view controller
        if let currentVC = currentViewController {
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.removeFromParent()
        }
        
        // Instantiate the new child view controller
        let newViewController: UIViewController
        switch index {
        case 0:
            
            newViewController = storyboard?.instantiateViewController(withIdentifier: "bloodSugar") as! trackBloodSugarViewController
        case 1:
            let storyboard = UIStoryboard(name: "MealsPage", bundle: nil)
            newViewController = storyboard.instantiateViewController(withIdentifier: "meals") as! trackMealsViewController
        case 2:
            let storyboard = UIStoryboard(name: "ActivityTrackpg", bundle: nil)
            newViewController = storyboard.instantiateViewController(withIdentifier: "tracking") as! trackActivityViewController
        default:
            return
        }
        addChild(newViewController)
               containerView.addSubview(newViewController.view)
               newViewController.view.frame = containerView.bounds
               newViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
               newViewController.didMove(toParent: self)
               
               currentViewController = newViewController
        
    }
}
