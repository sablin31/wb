//
//  CustomNavigationView.swift
//
//
//  Created by Aleksei Sablin on 13.07.2024.
//

import SwiftUI

struct CustomNavigationView<Content: View>: View {

    // MARK: Private properties

    @ObservedObject private var router: Router
    let content: Content

    // MARK: Computed properties

    var body: some View {
        ZStack { 
            if router.stack.isEmpty {
                content
                    .transition(.move(edge: .leading))
            } else {
                if let lastView = router.stack.last {
                    lastView
                        .view
                        .transition(self.transition(for: lastView.type))
                        .environmentObject(router)
                }
            }
        }
        .sheet(item: $router.modalItem) {
            $0.view.environmentObject(router)
        }
    }

    // MARK: Init

    init(router: Router, @ViewBuilder content: () -> Content) {
        self.router = router
        self.content = content()
    }
}
// MARK: - Private methods

private extension CustomNavigationView {
    func transition(for type: Router.NavigationType) -> AnyTransition {
        switch type {
        case .push:
            return .slide
        case .present:
            return .move(edge: .bottom)
        case .custom(let transition):
            return transition
        case .modal:
            return .identity
        }
    }
}
