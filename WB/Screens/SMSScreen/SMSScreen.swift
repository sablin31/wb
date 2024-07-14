//
//  SMSScreen.swift
//  WB
//
//  Created by Aleksei Sablin on 02.07.2024.
//

import SwiftUI
import WBUIKit

struct SMSScreen: View {

    // MARK: Private properties

    @StateObject private var timerManager = SMSTimerManager.shared
    @State private var codeDigit1 = ""
    @State private var codeDigit2 = ""
    @State private var codeDigit3 = ""
    @State private var codeDigit4 = ""
    @State private var borderColor: Color? = nil
    @FocusState private var isFocusedDigit1: Bool
    @FocusState private var isFocusedDigit2: Bool
    @FocusState private var isFocusedDigit3: Bool
    @FocusState private var isFocusedDigit4: Bool
    @EnvironmentObject private var router: Router
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var phoneNumber: String
    private let currentDevice = UIDevice.current.userInterfaceIdiom

    // MARK: Computed properties

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                BaseView {
                    VStack {
                        Image(Constants.letterImageName)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: Constants.letterImageSize.width,
                                   height: Constants.letterImageSize.height)
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.letterImagePaddingCompactValue :
                                        Constants.letterImagePaddingDefaultValue)
                        Text(phoneNumber)
                            .customTextStyle()
                            .padding(.top, Constants.phoneNumberPadding)
                        HStack {
                            CustomTextField(
                                text: $codeDigit1,
                                textFont: Constants.codeTextFieldFont,
                                withClearBtn: false,
                                multilineTextAlignment: .center,
                                borderColor: borderColor
                            )
                            .focused($isFocusedDigit1)
                            .frame(width: Constants.codeTextFieldFrame.width,
                                   height: Constants.codeTextFieldFrame.height)
                            .padding(.horizontal, Constants.codeTextFieldrPadding)
                            
                            CustomTextField(
                                text: $codeDigit2,
                                textFont: Constants.codeTextFieldFont,
                                withClearBtn: false,
                                multilineTextAlignment: .center,
                                borderColor: borderColor
                            )
                            .focused($isFocusedDigit2)
                            .frame(width: Constants.codeTextFieldFrame.width,
                                   height: Constants.codeTextFieldFrame.height)
                            .padding(.horizontal, Constants.codeTextFieldrPadding)
                            
                            CustomTextField(
                                text: $codeDigit3,
                                textFont: Constants.codeTextFieldFont,
                                withClearBtn: false,
                                multilineTextAlignment: .center,
                                borderColor: borderColor
                            )
                            .focused($isFocusedDigit3)
                            .frame(width: Constants.codeTextFieldFrame.width,
                                   height: Constants.codeTextFieldFrame.height)
                            .padding(.horizontal, Constants.codeTextFieldrPadding)
                            
                            CustomTextField(
                                text: $codeDigit4,
                                textFont: Constants.codeTextFieldFont,
                                withClearBtn: false,
                                multilineTextAlignment: .center,
                                borderColor: borderColor
                            )
                            .focused($isFocusedDigit4)
                            .frame(width: Constants.codeTextFieldFrame.width,
                                   height: Constants.codeTextFieldFrame.height)
                            .padding(.horizontal, Constants.codeTextFieldrPadding)
                        }
                        .frame(height: Constants.hStackHeight)
                        if let borderColor, borderColor != UIHelper.acceptColor {
                            Text(Constants.errorText)
                                .customTextStyle(font: Constants.timerTextFont,color: borderColor)
                        }
                        if let timeRemaining = timerManager.timeRemaining {
                            if timeRemaining > 0 {
                                Text("\(Constants.timerTitle) \(timeRemaining) \(Constants.timerTitleSec)")
                                    .customTextStyle(font: Constants.timerTextFont)
                                    .padding(.top, Constants.timerTextPadding)
                            } else {
                                Button(action: {
                                    timerManager.start(on: Constants.timeRemaingRequestCode)
                                }) {
                                    Text(Constants.requestCodeBtnTitle)
                                        .customTextStyle(font: Constants.timerTextFont)
                                        .padding(.top, Constants.timerTextPadding)
                                }
                            }
                        }
                        Spacer()
                        VStack {
                            Button(Constants.requestAuthorizationBtnTitle) {
                                if checkCodeIsValid() {
                                    borderColor = UIHelper.acceptColor
                                } else {
                                    borderColor = UIHelper.alertColor
                                }
                            }
                            .buttonStyle(RoundButton())
                            .frame(height: Constants.baseFrameHeight)
                            .padding(.top, horizontalSizeClass == .compact ?
                                     Constants.requestAuthorizationBtnPaddingCompactValue :
                                        Constants.requestAuthorizationBtnPaddingDefaultValue
                            )
                        }
                    }
                    .padding(.horizontal, Constants.viewHorizontalPaddingValue)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            timerManager.start(on: Constants.timeRemaingRequestCode)
                        }
                    }
                    .onChange(of: codeDigit1) {
                        modifired(numberOfTextFields: 1, newValue: $0)
                    }
                    .onChange(of: codeDigit2) {
                        modifired(numberOfTextFields: 2, newValue: $0)
                    }
                    .onChange(of: codeDigit3) {
                        modifired(numberOfTextFields: 3, newValue: $0)
                    }
                    .onChange(of: codeDigit4) {
                        modifired(numberOfTextFields: 4, newValue: $0)
                    }
                }
                if currentDevice == .pad {
                    makeBackBtn()
                        .padding()
                }
            }
            if currentDevice == .phone {
                VStack {
                    HStack {
                        makeBackBtn()
                            .padding(.horizontal)
                        Spacer()
                    }
                    Spacer()
                }
            }
        }
    }

    // MARK: Init

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
// MARK: - Private methods

private extension SMSScreen {
    func makeBackBtn() -> some View {
        HStack {
            Button(action: {
                withAnimation(.easeInOut) {
                    router.pop()
                }
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(UIHelper.baseTextColor)
                        .frame(width: 20, height: 20)
                    Text("Вернуться назад")
                        .customTextStyle(font: Constants.backBtnTextFont)
                }
            }
        }
    }

    func checkCodeIsValid() -> Bool {
        let code = codeDigit1 + codeDigit2 + codeDigit3 + codeDigit4
        return code == "3221"
    }

    func modifired(numberOfTextFields: Int, newValue: String) {
        switch numberOfTextFields {
        case 1:
            codeDigit1 = newValue.format(mask: Constants.codeTextFieldMask)
            if newValue.count == 1 {
                isFocusedDigit2 = true
            }
        case 2:
            codeDigit2 = newValue.format(mask: Constants.codeTextFieldMask)
            if newValue.count == 1 {
                isFocusedDigit3 = true
            } else {
                isFocusedDigit1 = true
            }
        case 3:
            codeDigit3 = newValue.format(mask: Constants.codeTextFieldMask)
            if newValue.count == 1 {
                isFocusedDigit4 = true
            } else {
                isFocusedDigit2 = true
            }
        case 4:
            codeDigit4 = newValue.format(mask: Constants.codeTextFieldMask)
            if newValue.count == 0 {
                isFocusedDigit3 = true
                borderColor = nil
            }
        default:
            break
        }
    }
}
// MARK: - Constants

private extension SMSScreen {
    enum Constants {

        // MARK: UI constants

        static let letterImageName = "letter"
        static let letterImageSize = CGSize(width: 40, height: 40)
        static let letterImagePaddingDefaultValue = CGFloat(40)
        static let letterImagePaddingCompactValue = CGFloat(10)

        static let phoneNumberPadding = CGFloat(16)

        static let codeTextFieldMask = "X"
        static let codeTextFieldFont = Font.custom("Montserrat", size: 36).weight(.semibold)
        static let codeTextFieldFrame = CGSize(width: 64, height: 80)
        static let codeTextFieldrPadding = CGFloat(8)

        static let errorText = "Неверный код"
        static let requestCodeBtnTitle = "Запросить новый код"
        static let timerTitle = "Запросить повторно через"
        static let timerTitleSec = "сек"
        static let timerTextFont = Font.custom("Montserrat", size: 14).weight(.regular)
        static let timerTextPadding = CGFloat(16)

        static let hStackHeight = CGFloat(128)

        static let requestAuthorizationBtnTitle = "Авторизоваться"
        static let requestAuthorizationBtnPaddingDefaultValue = CGFloat(48)
        static let requestAuthorizationBtnPaddingCompactValue = CGFloat(0)

        static let baseFrameHeight = CGFloat(48)
        static let viewHorizontalPaddingValue = CGFloat(24)
        
        static let timeRemaingRequestCode = 60
        
        static let backBtnTextFont = Font.custom("Montserrat", size: 14).weight(.regular)

    }
}
// MARK: - Preview

#Preview {
    SMSScreen(phoneNumber: "+7 (921) 233-123-44")
}
