//
//  WBTests.swift
//  WBTests
//
//  Created by Aleksei Sablin on 21.07.2024.
//

import XCTest
@testable import WB

final class WBTests: XCTestCase {

    func testHW4() {
        // Использование Stack
        var intStack = Stack<Int>()
        intStack.push(1)
        intStack.push(2)
        XCTAssertEqual(intStack.pop(), Optional(2))
        XCTAssertEqual(intStack.pop(), Optional(1))
        
        // Использование Queue
        let stringQueue = Queue<String>()
        stringQueue.enqueue("A")
        stringQueue.enqueue("B")
        XCTAssertEqual(stringQueue.dequeue(), Optional("A"))
        XCTAssertEqual(stringQueue.dequeue(), Optional("B"))
        
        // Использование AnyContainer со Stack
        let anyStack = AnyContainer(intStack)
        anyStack.add(3)
        anyStack.add(4)
        XCTAssertEqual(anyStack.remove(), Optional(4))
        XCTAssertEqual(anyStack.remove(), Optional(3))

        // Использование AnyContainer с Queue
        let anyQueue = AnyContainer(stringQueue)
        anyQueue.add("C")
        anyQueue.add("D")
        XCTAssertEqual(anyQueue.remove(), Optional("C"))
        XCTAssertEqual(anyQueue.remove(), Optional("D"))

        // Использование makeOpaqueContainer
        let queue = Queue<String>()
        queue.add("WB")
        var opaqueQueue = makeOpaqueContainer(queue)
        let removedValue = opaqueQueue.remove() as? String
        XCTAssertEqual(removedValue, Optional("WB"))
    }
}
// MARK: - Helpers

extension WBTests {

    func makeOpaqueContainer<T: Container>(_ container: T) -> some Container {
        return container
    }
}
