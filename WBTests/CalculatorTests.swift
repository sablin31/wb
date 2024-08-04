//
//  CalculatorTests.swift
//  WBTests
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import XCTest
@testable import WBCalculator

class CalculatorTests: XCTestCase {

    // MARK: Public properties

    var calculator: DefaultCalculator<Double>!

    // MARK: Inheritance

    override func setUp() {
        super.setUp()
        calculator = DefaultCalculator<Double>()
    }
    
    override func tearDown() {
        calculator = nil
        super.tearDown()
    }

    // MARK: Testcased

    func testAddition() {
        XCTAssertEqual(calculator.add(2, 3), 5)
        XCTAssertEqual(calculator.add(-2, -3), -5)
        XCTAssertEqual(calculator.add(-2, 3), 1)
    }
    
    func testSubtraction() {
        XCTAssertEqual(calculator.subtract(5, 3), 2)
        XCTAssertEqual(calculator.subtract(-5, -3), -2)
        XCTAssertEqual(calculator.subtract(3, 5), -2)
    }
    
    func testMultiplication() {
        XCTAssertEqual(calculator.multiply(2, 3), 6)
        XCTAssertEqual(calculator.multiply(-2, -3), 6)
        XCTAssertEqual(calculator.multiply(-2, 3), -6)
    }
    
    func testDivision() {
        XCTAssertEqual(try calculator.divide(6, 3), 2)
        XCTAssertEqual(try calculator.divide(-6, -3), 2)
        XCTAssertEqual(try calculator.divide(-6, 3), -2)
    }
    
    func testDivisionByZero() {
        XCTAssertThrowsError(try calculator.divide(6, 0))
    }
}
