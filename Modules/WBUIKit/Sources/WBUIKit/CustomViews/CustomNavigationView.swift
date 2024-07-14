//
//  CustomNavigationView.swift
//
//
//  Created by Aleksei Sablin on 13.07.2024.
//

import SwiftUI

public struct CustomNavigationView<Content: View>: View {

    // MARK: Public propetries

    @ObservedObject private var router: Router
    private let content: Content

    // MARK: Init propetries

    public init(router: Router, @ViewBuilder content: () -> Content) {
        self.router = router
        self.content = content()
    }

    // MARK: Computed properties

    public var body: some View {
        ZStack {
            if router.stack.isEmpty {
                content
                    .transition(.move(edge: .leading))
            } else {
                router.stack.last?
                    .transition(.move(edge: .trailing))
            }
        }
    }
}
