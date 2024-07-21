//
//  Stack.swift
//  WB
//
//  Created by Aleksei Sablin on 21.07.2024.
//

import Foundation

struct Stack<Element> {

    private var elements: [Element] = []

    mutating func push(_ element: Element) {
        elements.append(element)
    }

    mutating func pop() -> Element? {
        elements.popLast()
    }
}
