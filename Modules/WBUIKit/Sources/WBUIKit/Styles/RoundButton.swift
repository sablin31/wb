//
//  RoundButton.swift
//  
//
//  Created by Aleksei Sablin on 03.07.2024.
//

import SwiftUI

public struct RoundButton: ButtonStyle {

    // MARK: Public properties

    var backgroundColorBase: Color
    var foregroundColorBase: Color
    var height: CGFloat
    var cornerRadius: CGFloat
    var font: Font
    
    // MARK: Init
    
    public init(
        backgroundColorBase: Color = UIHelper.buttonBaseBackgroundColor,
        foregroundColorBase: Color = UIHelper.baseTextColor,
        height: CGFloat = 48,
        cornerRadius: CGFloat = 12,
        font: Font = .custom("Montserrat", size:20).weight(.medium)
    ) {
        self.backgroundColorBase = backgroundColorBase
        self.foregroundColorBase = foregroundColorBase
        self.height = height
        self.cornerRadius = cornerRadius
        self.font = font
    }
    
    // MARK: Public methods

    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(foregroundColorBase)
            .font(font)
            .frame(maxWidth: .infinity)
            .frame(height: height)
            .background(backgroundColorBase)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}
