//
//  WBApp.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import SwiftUI
import WBUIKit

@main
struct WBApp: App {

    // MARK: Private properties

    @StateObject private var router = Router()
    @StateObject private var languageManager = LanguageManager.shared

    // MARK: Computed properties

    var body: some Scene {
        WindowGroup {
            CalculatorView()
//            LoginView()
//                .environmentObject(router)
//                .environmentObject(languageManager)
        }
    }
}
