//
//  Date+Extensions.swift
//  Greensheet
//
//  Created by Rome on 7/26/25.
//

import Foundation

extension Date {
    // MARK: - Golf-Specific Date Formatting
    
    var roundDateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
    var roundDateTimeString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
    
    var scorecardDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: self)
    }
    
    // MARK: - Date Calculations
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    var isYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }
    
    var isThisWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    var isThisMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }
    
    // MARK: - Golf Round Specific
    
    var golfSeason: String {
        let month = Calendar.current.component(.month, from: self)
        
        switch month {
        case 3...5: return "Spring"
        case 6...8: return "Summer"
        case 9...11: return "Fall"
        default: return "Winter"
        }
    }
    
    var isGolfSeason: Bool {
        let month = Calendar.current.component(.month, from: self)
        return month >= 3 && month <= 11
    }
    
    var daysSince: Int {
        return Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
    }
} 