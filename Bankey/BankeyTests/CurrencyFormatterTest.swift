//
//  CurrencyFormatterTest.swift
//  BankeyTests
//
//  Created by Martin on 2023/05/25.
//

import Foundation
import XCTest

@testable import Bankey

class CurrencyFormatterTest: XCTestCase {
    var formatter: CurrencyFormatter!
    

    
    override func setUp() {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    func testBreakDollarsIntoCents() throws {
        let testingNumber: Decimal = 929466.23
        let result = formatter.breakIntoDollarsAndCents(testingNumber)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    func testDollarsFormatted() throws {
        let testingNumber: Double = 929466.23
        let result = formatter.dollarsFormatted(testingNumber)
        XCTAssertEqual(result, "$929,466.23")
    }
    
    func testZeroDollarFormatted() throws {
        let testingNumber: Double = 0.000
        let result = formatter.dollarsFormatted(testingNumber)
        XCTAssertEqual(result, "$0.00")
    }
}
