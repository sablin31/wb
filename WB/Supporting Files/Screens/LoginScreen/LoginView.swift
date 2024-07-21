//
//  LoginView.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import SwiftUI
import WBUIKit

struct LoginView: View {

    // MARK: Private properties

    @State private var phoneNumber = Constants.phoneNumberTextFieldInitialText
    @State private var errorMessage: String?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject private var router: Router

    // MARK: Computed properties

    var body: some View {
        CustomNavigationView(router: router) {
            ZStack {
                BackgroundView()
                BaseView {
                    VStack {
                        Text(Constants.titleText)
                            .customTextStyle()
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.titlePaddingCompactValue : Constants.titlePaddingDefaultValue)
                        CustomRoundImage(imageName: Constants.avatarImageName)
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.avatarPaddingCompactValue : Constants.avatarPaddingDefaultValue)
                        Text(Constants.descriptionText)
                            .customTextStyle(font: Constants.descriptionFont)
                            .padding(.top, Constants.descriptionPaddingDefaultValue)
                        CustomTextField(
                            text: $phoneNumber,
                            errorMessage: errorMessage,
                            initialText: Constants.phoneNumberTextFieldInitialText
                        )
                        .frame(height: Constants.baseFrameHeight)
                        .padding(.top, horizontalSizeClass == .compact ?
                                 Constants.phoneNumberPaddingCompactValue : Constants.phoneNumberPaddingDefaultValue)
                        Spacer()
                        VStack {
                            Button(Constants.requestCodeBtnTitle) {
                                checkPhoneNumber()
                            }
                            .buttonStyle(RoundButton())
                            .frame(height: Constants.baseFrameHeight)
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.requestCodeBtnPaddingCompactValue : Constants.requestCodeBtnPaddingDefaultValue)
                        }
                    }
                    .padding(.horizontal, Constants.viewHorizontalPaddingValue)
                }
                .onChange(of: phoneNumber) { newValue in
                    guard newValue != "+8" else {
                        phoneNumber = "+7"
                        return
                    }
                    phoneNumber = newValue.format(mask: Constants.phoneNumberMask)
                    errorMessage = nil
                }
            }
        }
    }
}
// MARK: - Private methods

private extension LoginView {
    func checkPhoneNumber() {
        if phoneNumber.isValid(regex: Constants.phoneNumberRegEx) {
            errorMessage = nil
            router.custom(SMSScreen(phoneNumber: phoneNumber), transition: .move(edge: .trailing))
        } else {
            errorMessage = Constants.errorMessage
        }
    }
}
// MARK: - Constants

private extension LoginView {
    enum Constants {

        // MARK: UI constants

        static let titleText = "Авторизация"
        static let titlePaddingDefaultValue = CGFloat(40)
        static let titlePaddingCompactValue = CGFloat(10)

        static let avatarImageName = "avatarProfile"
        static let avatarPaddingDefaultValue = CGFloat(28)
        static let avatarPaddingCompactValue = CGFloat(10)

        static let descriptionText = "Вход по номеру телефона"
        static let descriptionFont = Font.custom("Montserrat", size: 20).weight(.regular)
        static let descriptionPaddingDefaultValue = CGFloat(16)

        static let phoneNumberPaddingDefaultValue = CGFloat(24)
        static let phoneNumberPaddingCompactValue = CGFloat(12)
        static let phoneNumberTextFieldInitialText = "+7"
        static let phoneNumberRegEx = "^\\+7\\ \\(\\d{3}\\) \\d{3}-\\d{2}-\\d{2}$"
        static let phoneNumberMask = "+X (XXX) XXX-XX-XX"

        static let requestCodeBtnTitle = "Запросить код"
        static let requestCodeBtnPaddingDefaultValue = CGFloat(48)
        static let requestCodeBtnPaddingCompactValue = CGFloat(0)

        static let errorMessage = "Некорректный формат номера"

        static let baseFrameHeight = CGFloat(48)
        static let viewHorizontalPaddingValue = CGFloat(24)
    }
}
// MARK: - Preview

#Preview {
    LoginView()
}
