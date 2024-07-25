//
//  Router.swift
//  WB
//
//  Created by Aleksei Sablin on 13.07.2024.
//

import SwiftUI

public class Router: ObservableObject {

    // MARK: Public propetries

    @Published var stack: [NavigationItem] = []
    @Published var modalItem: NavigationItem?

    // MARK: Nested types

    public enum NavigationType {
        case push
        case present
        case custom(transition: AnyTransition)
        case modal
    }

    public struct NavigationItem: Identifiable {
        public let id = UUID()
        public let view: AnyView
        public let type: NavigationType
    }

    // MARK: Init

    public init(stack: [NavigationItem] = []) {
        self.stack = stack
    }
}
// MARK: - Public methods

public extension Router {
    func push<V: View>(_ view: V, withAnimation animation: Animation = .easeInOut) {
        withAnimation(animation) {
            stack.append(NavigationItem(view: AnyView(view), type: .push))
        }
    }

    func present<V: View>(_ view: V, withAnimation animation: Animation = .easeInOut) {
        withAnimation(animation) {
            stack.append(NavigationItem(view: AnyView(view), type: .present))
        }
    }

    func custom<V: View>(_ view: V, transition: AnyTransition, withAnimation animation: Animation = .easeInOut) {
        withAnimation(animation) {
            stack.append(NavigationItem(view: AnyView(view), type: .custom(transition: transition)))
        }
    }

    func pop(withAnimation animation: Animation = .easeInOut) {
        withAnimation(animation) {
            _ = stack.popLast()
        }
    }

    func popToRoot(withAnimation animation: Animation = .easeInOut) {
        withAnimation(animation) {
            stack.removeAll()
        }
    }

    func showModal<V: View>(_ view: V) {
        modalItem = NavigationItem(view: AnyView(view), type: .modal)
    }

    func dismissModal() {
        modalItem = nil
    }
}
