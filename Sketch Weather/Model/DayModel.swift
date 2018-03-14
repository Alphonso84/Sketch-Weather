//
//  DayModel.swift
//  Sketch Weather
//
//  Created by user on 3/6/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation
import UIKit

struct Day {
    
    var summary: String?
    var chanceOfRain: Double?
    var HighTemp: Double?
    var LowTemp: Double?
   
    
    init(summary:String?, chanceOfRain: Double?, HighTemp: Double?, LowTemp: Double?) {
        self.summary = summary
        self.chanceOfRain = chanceOfRain
        self.HighTemp = HighTemp
        self.LowTemp = LowTemp
        }
}
