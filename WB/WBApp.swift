//
//  WBApp.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import SwiftUI

@main
struct WBApp: App {
    var body: some Scene {
        WindowGroup {
            SMSScreen(phoneNumber: "+7 (921) 233-123-44")
        }
    }
}
