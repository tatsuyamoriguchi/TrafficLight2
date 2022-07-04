//
//  Helper.swift
//  TrafficLight
//
//  Created by Tatsuya Moriguchi on 7/3/22.
//

import Foundation

class Helper {
    
    // Convert Date type data to String (Tue, 28 Jun 2022 16:52:04 EST)
    func date2String(date: Date) -> String {
        
        var dateString: String
        guard date == date else { return "No Date Info"}

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM y HH:mm:ss T"
        dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    
}
