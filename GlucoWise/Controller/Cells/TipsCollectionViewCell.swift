//
//  TipsCollectionViewCell.swift
//  GlucoWise
//
//  Created by Harnoor Kaur on 12/23/24.
//

import UIKit

class TipsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tipsImage: UIImageView!
    
    @IBOutlet weak var tipsNameLbl: UILabel!
    @IBOutlet weak var tipsDescriptionLbl: UILabel!
    @IBOutlet weak var actionNameBtn: UIButton!
    @IBAction func btnPressed(_ sender: UIButton) {
        print("Button pressed")
    }
}
