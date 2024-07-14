//
//  BaseView.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import SwiftUI

public struct BaseView<Content>: View where Content: View {

    // MARK: Public properties

    let content: () -> Content
    let frameSize: CGSize = .init(width: 400, height: 450)

    // MARK: Private properties

    private let currentDevice = UIDevice.current.userInterfaceIdiom

    // MARK: Computed properties

    public var body: some View {
        ZStack {
            if currentDevice == .pad {
                UIHelper.baseColor
                    .edgesIgnoringSafeArea(.all)
                Image("bgImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { hideKeyboard() }
            }
            ZStack {
                UIHelper.baseColor
                    .cornerRadius(currentDevice == .pad ? 28 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture { hideKeyboard() }
                content()
                    .padding(.bottom, currentDevice == .pad ? 32 : 0)
            }
            .frame(
                maxWidth: currentDevice == .phone ? .infinity : frameSize.width,
                maxHeight: currentDevice == .phone ? .infinity : frameSize.height
            )
        }
    }

    // MARK: Init

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}
