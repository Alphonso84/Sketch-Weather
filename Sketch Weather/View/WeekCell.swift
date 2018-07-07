//
//  WeekCell.swift
//  Sketch Weather
//
//  Created by user on 3/6/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit

class MyCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundCellImage: UIImageView!
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var summary: UILabel?
    @IBOutlet weak var chanceOfRain: UILabel?
    @IBOutlet weak var HighTemp: UILabel?
    @IBOutlet weak var LowTemp: UILabel?
    @IBOutlet weak var weatherImage: UIImageView?
    
    func setBackgroundForTimeOfDay() {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        _ = calendar.component(.minute, from: date)
        _ = calendar.component(.second, from: date)
        
        if (21...23).contains(hour) {
            backgroundCellImage.image = UIImage(named: "dark")
        }else if (0...4).contains(hour) {
            backgroundCellImage.image = UIImage(named:"dark")
        }else{
            backgroundCellImage.image = UIImage(named:"Blueback")
        }
    }
    
   
    
}
