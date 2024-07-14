//
//  BackgroundView.swift
//
//
//  Created by Aleksei Sablin on 14.07.2024.
//

import SwiftUI

public struct BackgroundView: View {

    // MARK: Private properties

    private let currentDevice = UIDevice.current.userInterfaceIdiom

    // MARK: Computed properties

    public var body: some View {
        if currentDevice == .pad {
            UIHelper.baseColor
                .edgesIgnoringSafeArea(.all)
            Image("bgImage")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture { hideKeyboard() }
        }
    }

    // MARK: Init

    public init() {}
}
