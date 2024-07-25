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

    func testHW5() {
        // Работа с subscript
        let array = [1,2,3]
        XCTAssertEqual(array[safe: 0], 1)
        XCTAssertEqual(array[safe: 3], nil)
        
        // Работа с +++
        let cargo1 = Cargo(width: 1, height: 2, length: 3)
        let cargo2 = Cargo(width: 4, height: 5, length: 6)
        let result = cargo1 +++ cargo2
        XCTAssertEqual(result, 126)
    }
}
// MARK: - Helpers

extension WBTests {

    func makeOpaqueContainer<T: Container>(_ container: T) -> some Container {
        return container
    }
}
