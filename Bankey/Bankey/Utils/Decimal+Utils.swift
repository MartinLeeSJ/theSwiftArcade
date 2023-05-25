//
//  Decimal+Utils.swift
//  Bankey
//
//  Created by Martin on 2023/05/25.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
