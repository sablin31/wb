//
//  NoTapAnimationStyle.swift
//  
//
//  Created by Aleksei Sablin on 03.07.2024.
//

import SwiftUI

public struct NoTapAnimationStyle: PrimitiveButtonStyle {
    public func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .contentShape(Rectangle())
            .onTapGesture(perform: configuration.trigger)
    }
}
