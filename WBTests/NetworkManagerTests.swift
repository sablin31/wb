//
//  NetworkManagerTests.swift
//  WBTests
//
//  Created by Aleksei Sablin on 04.08.2024.
//

import XCTest
import Combine
@testable import WB

class NetworkManagerTests: XCTestCase {

    // MARK: Public properties

    var networkManager: NetworkManager!
    var fakeManager: NetworkManager!
    var cancellables: Set<AnyCancellable> = []

    // MARK: Inheritance

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        fakeManager = FakeNetworkManager()
    }

    override func tearDown() {
        networkManager = nil
        cancellables.removeAll()
        super.tearDown()
    }

    // MARK: Network manager with testable api

    func testGetRequestWithTestableURL() {
        let expectation = XCTestExpectation(description: "GET request should succeed")

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!

        networkManager.get(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("GET request failed with error: \(error)")
                }
            }, receiveValue: { (mock: MockStruct) in
                XCTAssertNotNil(mock, "No data received")
                XCTAssertEqual(mock.id, 1)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
    }

    func testPostRequestWithTestableURL() {
        let expectation = XCTestExpectation(description: "POST request should succeed")

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
        let mockForPost = MockStruct(userId: 1, title: "foo", body: "bar")

        networkManager.post(url: url, body: mockForPost)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("POST request failed with error: \(error)")
                }
            }, receiveValue: { (mock: MockStruct) in
                XCTAssertNotNil(mock, "No data received")
                XCTAssertEqual(mockForPost.title, mock.title)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

    func testPutRequestWithTestableURL() {
        let expectation = XCTestExpectation(description: "PUT request should succeed")

        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1")!
        let updatedMock = MockStruct(userId: 1, id: 1, title: "foo", body: "bar")

        networkManager.put(url: url, body: updatedMock)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("PUT request failed with error: \(error)")
                }
            }, receiveValue: { (mock: MockStruct) in
                XCTAssertNotNil(mock, "No data received")
                XCTAssertEqual(mock.id, updatedMock.id)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

    // MARK: Fake Network manager

    func testGetRequestWithFakeManager() {
        let expectation = XCTestExpectation(description: "GET request should succeed")

        let url = URL(string: "https://api.fakeURL.com")!
        let getMock = MockStruct(userId: 1, id: 1, title: "foo", body: "bar")
        (fakeManager as? FakeNetworkManager)?.getResponse = getMock

        fakeManager.get(url: url)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("GET request failed with error: \(error)")
                }
            }, receiveValue: { (responce: MockStruct) in
                XCTAssertNotNil(responce, "No data received")
                XCTAssertEqual(responce.id, 1)
                XCTAssertEqual(responce.title, "foo")
                XCTAssertEqual(responce.body, "bar")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testPostRequestWithFakeManager() {
            let expectation = XCTestExpectation(description: "POST request should succeed")
            
            let url = URL(string: "https://api.fakeURL.com/mock")!
            let makeMock = MockStruct(userId: 1, title: "foo", body: "bar")
            let fakeResponsePost = MockStruct(userId: 1, id: 101, title: "foo", body: "bar")
            (fakeManager as? FakeNetworkManager)?.postResponse = fakeResponsePost
            
            fakeManager.post(url: url, body: makeMock)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("POST request failed with error: \(error)")
                    }
                }, receiveValue: { (responce: MockStruct) in
                    XCTAssertNotNil(responce, "No data received")
                    XCTAssertEqual(responce.id, 101)
                    XCTAssertEqual(responce.title, "foo")
                    XCTAssertEqual(responce.body, "bar")
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }

        func testPutRequestWithFakeManager() {
            let expectation = XCTestExpectation(description: "PUT request should succeed")
            
            let url = URL(string: "https://https://api.fakeURL.com/mocks")!
            let updatedMock = MockStruct(userId: 1, id: 1, title: "foo", body: "bar")
            (fakeManager as? FakeNetworkManager)?.putResponse = updatedMock
            
            fakeManager.put(url: url, body: updatedMock)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("PUT request failed with error: \(error)")
                    }
                }, receiveValue: { (responce: MockStruct) in
                    XCTAssertNotNil(responce, "No data received")
                    XCTAssertEqual(responce.id, updatedMock.id)
                    XCTAssertEqual(responce.title, updatedMock.title)
                    XCTAssertEqual(responce.body, updatedMock.body)
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }

        func testDeleteRequestWithFakeManager() {
            let expectation = XCTestExpectation(description: "DELETE request should succeed")
            
            let url = URL(string: "https://api.fakeURL.com/removeMock")!
            let fakeDeletedMock = MockStruct(userId: 1, id: 1, title: "foo", body: "bar")
            (fakeManager as? FakeNetworkManager)?.deleteResponse = fakeDeletedMock
            
            fakeManager.delete(url: url)
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        XCTFail("DELETE request failed with error: \(error)")
                    }
                }, receiveValue: { (responce: MockStruct) in
                    XCTAssertNotNil(responce, "No data received")
                    XCTAssertEqual(responce.id, fakeDeletedMock.id)
                    XCTAssertEqual(responce.title, fakeDeletedMock.title)
                    XCTAssertEqual(responce.body, fakeDeletedMock.body)
                    expectation.fulfill()
                })
                .store(in: &cancellables)
            
            wait(for: [expectation], timeout: 1.0)
        }
}
// MARK: - Helpers

extension NetworkManagerTests {

    // MARK: Mock test structs

    struct MockStruct: Codable {
        var userId: Int
        var id: Int?
        var title: String
        var body: String
    }
}
// MARK: - Fake manager (Just for testing)

class FakeNetworkManager: NetworkManager {
    var getResponse: Any?
    var postResponse: Any?
    var putResponse: Any?
    var deleteResponse: Any?

    override func get<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        if let response = getResponse as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    override func post<T: Decodable, U: Encodable>(url: URL, body: U) -> AnyPublisher<T, Error> {
        if let response = postResponse as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    override func put<T: Decodable, U: Encodable>(url: URL, body: U) -> AnyPublisher<T, Error> {
        if let response = putResponse as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }

    override func delete<T: Decodable>(url: URL) -> AnyPublisher<T, Error> {
        if let response = deleteResponse as? T {
            return Just(response)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
}
