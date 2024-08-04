//
//  Calculator.swift
//  
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import Foundation

public protocol Calculator {

    associatedtype Number: Numeric & Comparable

    func add(_ a: Number, _ b: Number) -> Number
    func subtract(_ a: Number, _ b: Number) -> Number
    func multiply(_ a: Number, _ b: Number) -> Number
    func divide(_ a: Number, _ b: Number) throws -> Number
}

enum CalculatorError: Error {
    case divisionByZero
}
