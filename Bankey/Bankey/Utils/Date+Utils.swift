//
//  Date+Utils.swift
//  Bankey
//
//  Created by Martin on 2023/05/30.
//

import Foundation

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }
    
    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        return dateFormatter.string(from: self)
    }
}
