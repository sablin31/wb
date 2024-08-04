//
//  Queue.swift
//  WB
//
//  Created by Aleksei Sablin on 21.07.2024.
//

import Foundation

class Queue<Element> {

    private var elements: [Element] = []

    func enqueue(_ element: Element) {
        elements.append(element)
    }

    func dequeue() -> Element? {
        elements.isEmpty ? nil : elements.removeFirst()
    }
}
