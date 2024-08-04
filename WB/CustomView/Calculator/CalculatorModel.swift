//
//  CalculatorModel.swift
//  WB
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import Foundation

class CalculatorModel: ObservableObject {

    // MARK: Nested types

    enum CalculatorOperation {
        case addition, subtraction, multiplication, division
    }

    // MARK: Public properties

    @Published var input: String = ""
    @Published var result: String = "0"

    // MARK: Private properties

    private var currentOperation: CalculatorOperation?
    private var currentValue: Double?

    // MARK: Public methods (Intent's)

    func buttonTapped(_ title: String) {
        switch title {
        case "C":
            reset()
        case "=":
            calculateResult()
        case "/", "*", "-", "+":
            performOperation(title)
        default:
            appendToInput(title)
        }
    }
    
    // MARK: - Private methods

    // MARK: Helpers

    func reset() {
        input = ""
        result = "0"
        currentValue = nil
        currentOperation = nil
    }

    func appendToInput(_ title: String) {
        input += title
        result = input
    }

    func performOperation(_ operation: String) {
        guard let value = Double(input) else { return }
        if currentValue == nil {
            currentValue = value
        } else {
            calculateResult()
            currentValue = resultToDouble()
        }
        currentOperation = operationForSymbol(operation)
        input = ""
    }

    func calculateResult() {
        guard let value = Double(input), let operation = currentOperation else { return }
        if let currentValue = currentValue {
            switch operation {
            case .addition:
                self.result = "\(currentValue + value)"
            case .subtraction:
                self.result = "\(currentValue - value)"
            case .multiplication:
                self.result = "\(currentValue * value)"
            case .division:
                self.result = "\(currentValue / value)"
            }
        }
        input = ""
        self.currentValue = nil
        self.currentOperation = nil
    }

    func resultToDouble() -> Double? {
        Double(result)
    }

    func operationForSymbol(_ symbol: String) -> CalculatorOperation {
        switch symbol {
        case "+": return .addition
        case "-": return .subtraction
        case "*": return .multiplication
        case "/": return .division
        default: fatalError("Unknown operation")
        }
    }
}
