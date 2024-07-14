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

    // MARK: Computed properties

    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(router)
        }
    }
}
