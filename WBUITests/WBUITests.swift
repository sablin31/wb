//
//  WBUITests.swift
//  WBUITests
//
//  Created by Aleksei Sablin on 04.08.2024.
//

@testable import WB
import XCTest

final class WBUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    func testAddition() throws {
        let app = XCUIApplication()
        let button1 = app.buttons["1"]
        let button2 = app.buttons["2"]
        let plusButton = app.buttons["+"]
        let equalsButton = app.buttons["="]
        let resultLabel = app.staticTexts["resultLabel"]

        button1.tap()
        plusButton.tap()
        button2.tap()
        equalsButton.tap()

        XCTAssertEqual(resultLabel.label, "3.0")
    }

    func testSubtraction() throws {
        let app = XCUIApplication()
        let button5 = app.buttons["5"]
        let button3 = app.buttons["3"]
        let minusButton = app.buttons["-"]
        let equalsButton = app.buttons["="]
        let resultLabel = app.staticTexts["resultLabel"]

        button5.tap()
        minusButton.tap()
        button3.tap()
        equalsButton.tap()

        XCTAssertEqual(resultLabel.label, "2.0")
    }

    func testMultiplication() throws {
        let app = XCUIApplication()
        let button2 = app.buttons["2"]
        let button3 = app.buttons["3"]
        let multiplyButton = app.buttons["*"]
        let equalsButton = app.buttons["="]
        let resultLabel = app.staticTexts["resultLabel"]

        button2.tap()
        multiplyButton.tap()
        button3.tap()
        equalsButton.tap()

        XCTAssertEqual(resultLabel.label, "6.0")
    }

    func testDivision() throws {
        let app = XCUIApplication()
        let button6 = app.buttons["6"]
        let button2 = app.buttons["2"]
        let divideButton = app.buttons["/"]
        let equalsButton = app.buttons["="]
        let resultLabel = app.staticTexts["resultLabel"]

        button6.tap()
        divideButton.tap()
        button2.tap()
        equalsButton.tap()

        // Assert that the result is 3
        XCTAssertEqual(resultLabel.label, "3.0")
    }

    func testClearButton() throws {
        let app = XCUIApplication()
        let button7 = app.buttons["7"]
        let clearButton = app.buttons["C"]
        let resultLabel = app.staticTexts["resultLabel"]

        button7.tap()
        clearButton.tap()

        XCTAssertEqual(resultLabel.label, "0")
    }
}
