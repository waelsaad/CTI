//
//  Date+.swift
//  Library
//
//  Created by Wael Saad on 30/1/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import Foundation

// MARK: - Time Intervals

extension Date {
        
    // Constants representing time intervals in seconds.
    
    static let oneSecond: TimeInterval = 1
    
    static let oneMinute: TimeInterval = 60
    
    static let fiveMinutesInSeconds: TimeInterval = 5 * oneMinute
    
    var randomDate: Date {
        let randomYear = Int.random(in: 2000...2023)
        let randomMonth = Int.random(in: 1...12)
        let randomDay = Int.random(in: 1...28) // Assuming 28 days in February for simplicity
        
        let components = DateComponents(
            calendar: .current,
            year: randomYear,
            month: randomMonth,
            day: randomDay
        )
        
        if let date = components.date {
            return date
        } else {
            return Date()
        }
    }
    
}

// MARK: - Date Formatting

extension Date {

    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: self)
    }
    
}
