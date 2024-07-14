//
//  Router.swift
//  WB
//
//  Created by Aleksei Sablin on 13.07.2024.
//

import SwiftUI

public class Router: ObservableObject {

    // MARK: Public propetries

    @Published public var stack: [AnyView]

    // MARK: Init

    public init(stack: [AnyView] = []) {
        self.stack = stack
    }
}
// MARK: - Public methods

public extension Router {
    func push<Content: View>(_ view: Content) {
        stack.append(AnyView(view))
    }

    func pop() {
        _ = stack.popLast()
    }

    func popToRoot() {
        if let root = stack.first {
            stack = [root]
        }
    }
}
