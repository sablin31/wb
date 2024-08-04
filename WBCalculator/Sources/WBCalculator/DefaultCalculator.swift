//
//  DefaultCalculator.swift
//
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import Foundation

public struct DefaultCalculator<T: FloatingPoint>: Calculator {

    public typealias Number = T
    
    public func add(_ a: T, _ b: T) -> T {
        return a + b
    }
    
    public func subtract(_ a: T, _ b: T) -> T {
        return a - b
    }
    
    public func multiply(_ a: T, _ b: T) -> T {
        return a * b
    }
    
    public func divide(_ a: T, _ b: T) throws -> T {
        guard b != 0 else {
            throw CalculatorError.divisionByZero
        }
        return a / b
    }
    
    public init() {}
}
