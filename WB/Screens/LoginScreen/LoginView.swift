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

    @State private var phoneNumber = ""
    @State private var errorMessage: String?
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var languageManager: LanguageManager

    // MARK: Computed properties

    var body: some View {
        CustomNavigationView(router: router) {
            ZStack {
                BackgroundView()
                BaseView {
                    VStack {
                        Button("switchLanguage".localized.capitalized) {
                            languageManager.currentLanguage = languageManager.currentLanguage == "en" ? "ru" : "en"
                        }
                        .buttonStyle(RoundButton())
                        .padding(.vertical)
                        Button("HW5") {
                            router.showModal(HW5View().environmentObject(languageManager))
                        }
                        .buttonStyle(RoundButton())
                        .padding(.vertical)
                        Text(Constants.titleText.localized.capitalized)
                            .customTextStyle()
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.titlePaddingCompactValue : Constants.titlePaddingDefaultValue)
                        CustomRoundImage(imageName: Constants.avatarImageName)
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.avatarPaddingCompactValue : Constants.avatarPaddingDefaultValue)
                        Text(Constants.descriptionText.localized.capitalized)
                            .customTextStyle(font: Constants.descriptionFont)
                            .padding(.top, Constants.descriptionPaddingDefaultValue)
                        CustomTextField(
                            text: $phoneNumber,
                            errorMessage: errorMessage?.localized.capitalized,
                            initialText: ""
                        )
                        .frame(height: Constants.baseFrameHeight)
                        .padding(.top, horizontalSizeClass == .compact ?
                                 Constants.phoneNumberPaddingCompactValue : Constants.phoneNumberPaddingDefaultValue)
                        Spacer()
                        VStack {
                            Button(Constants.requestCodeBtnTitle.localized.capitalized) {
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

        static let titleText = "authorization"
        static let titlePaddingDefaultValue = CGFloat(40)
        static let titlePaddingCompactValue = CGFloat(10)

        static let avatarImageName = "avatarProfile"
        static let avatarPaddingDefaultValue = CGFloat(28)
        static let avatarPaddingCompactValue = CGFloat(10)

        static let descriptionText = "loginByPhoneNumber"
        static let descriptionFont = Font.custom("Montserrat", size: 20).weight(.regular)
        static let descriptionPaddingDefaultValue = CGFloat(16)

        static let phoneNumberPaddingDefaultValue = CGFloat(24)
        static let phoneNumberPaddingCompactValue = CGFloat(12)
        static let phoneNumberRegEx = "^\\+\\d \\(\\d{3}\\) \\d{3}-\\d{2}-\\d{2}$"
        static let phoneNumberMask = "+X (XXX) XXX-XX-XX"

        static let requestCodeBtnTitle = "requestCode"
        static let requestCodeBtnPaddingDefaultValue = CGFloat(48)
        static let requestCodeBtnPaddingCompactValue = CGFloat(0)

        static let errorMessage = "incorrectNumberFormat"

        static let baseFrameHeight = CGFloat(48)
        static let viewHorizontalPaddingValue = CGFloat(24)

        static let languageSwitch = "switchLanguage"
    }
}
// MARK: - Preview

#Preview {
    LoginView()
        .environmentObject(Router())
        .environmentObject(LanguageManager.shared)
}
