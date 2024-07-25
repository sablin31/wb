//
//  TitleTextStyle.swift
//
//
//  Created by Aleksei Sablin on 04.07.2024.
//

import SwiftUI

struct TitleTextStyle: ViewModifier {

    // MARK: Private properties

    private var font: Font
    private var color: Color

    // MARK: Computed properties

    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }

    // MARK: Init

    init(
        font: Font,
        color: Color
    ) {
        self.font = font
        self.color = color
    }
}
