//
//  foodvaluesViewController.swift
//  GlucoWise
//
//  Created by Manav Gupta on 20/01/25.
//

import UIKit
import SwiftUI

class foodvaluesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let foodDetailsView = FoodDetailsView()
               
               // Embed the SwiftUI view in a UIHostingController
               let hostingController = UIHostingController(rootView: foodDetailsView)
               
               // Add the HostingController as a child view controller
               addChild(hostingController)
               view.addSubview(hostingController.view)
               
               // Set constraints for the hostingController's view
               hostingController.view.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                   hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
                   hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                   hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
               ])
        hostingController.didMove(toParent: self)

    }
    
  

}
