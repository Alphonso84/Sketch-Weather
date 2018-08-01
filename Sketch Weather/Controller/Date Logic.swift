//
//  Date Logic.swift
//  Sketch Weather
//
//  Created by user on 3/8/18.
//  Copyright © 2018 Alphonso. All rights reserved.
//

import Foundation


func getDayOfWeek(today:String)->Int? {
    
    let formatter  = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    let todayDate = formatter.date(from: today)!
    let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
    let myComponents = myCalendar.components(.weekday, from: todayDate)
    let weekDay = myComponents.weekday
    return weekDay!
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    
        
    }
    func timeOfDay() -> Int {
        var timeOfDay = Int()
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        timeOfDay = hour
        return timeOfDay
    }
}

//@objc func startTimer(theTimer: Timer) {
//    UIView.animate(withDuration: 1, delay:0, options:.curveEaseOut, animations: {
//        self.collectionView.scrollToItem(at: IndexPath(row: theTimer.userInfo! as! Int,section:0), at: .centeredHorizontally, animated: false)
//    })
//}


