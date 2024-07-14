//
//  CustomTextField.swift
//
//
//  Created by Aleksei Sablin on 03.07.2024.
//

import SwiftUI

public struct CustomTextField: View {

    // MARK: Public properties

    @Binding var text: String

    // MARK: Private properties

    private var textFont: Font
    private var errorMessage: String?
    private var errorMessageFont: Font
    private var initialText: String
    private var withClearBtn: Bool
    private var keyboardType: UIKeyboardType
    private var multilineTextAlignment: TextAlignment
    private var borderColor: Color?

    // MARK: Computed properties

    public var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(UIHelper.opacityColor)
                .opacity(0.08)
                .cornerRadius(12)
            ZStack {
                if errorMessage != nil {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(UIHelper.alertColor, lineWidth: 1)
                } else if let borderColor {
                    RoundedRectangle(cornerRadius: 12)
                        .inset(by: 0.5)
                        .stroke(borderColor, lineWidth: 1)
                }
                VStack(spacing: 0) {
                    if let errorMessage {
                        HStack {
                            Text(errorMessage)
                                .font(errorMessageFont)
                                .foregroundColor(UIHelper.alertColor)
                                .padding(.horizontal, 16)
                            Spacer()
                        }
                    }
                    TextField("", text: $text)
                        .multilineTextAlignment(multilineTextAlignment)
                        .tint(.white)
                        .font(textFont)
                        .foregroundColor(UIHelper.baseTextColor)
                        .padding(.horizontal, 16)
                        .keyboardType(keyboardType)
                }
                if !text.isEmpty, withClearBtn {
                    HStack {
                        Spacer()
                        Button(action: { text = initialText }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(UIHelper.baseTextColor)
                        }
                        .buttonStyle(NoTapAnimationStyle())
                        .padding(.trailing, 16)
                    }
                }
            }
        }
    }

    // MARK: Init

    public init(
        text: Binding<String>,
        textFont: Font = .custom("Montserrat", size: 20).weight(.medium),
        errorMessage: String? = nil,
        errorMessageFont: Font = .custom("Montserrat", size: 12).weight(.medium),
        initialText: String = "",
        withClearBtn: Bool = true,
        keyboardType: UIKeyboardType = .numberPad,
        multilineTextAlignment: TextAlignment = .leading,
        borderColor: Color? = nil
    ) {
        self._text = text
        self.textFont = textFont
        self.errorMessage = errorMessage
        self.errorMessageFont = errorMessageFont
        self.initialText = initialText
        self.withClearBtn = withClearBtn
        self.keyboardType = keyboardType
        self.multilineTextAlignment = multilineTextAlignment
        self.borderColor = borderColor
    }
}
