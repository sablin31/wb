//
//  LanguageManager.swift
//  WB
//
//  Created by Aleksei Sablin on 24.07.2024.
//

import SwiftUI
import Combine

final class LanguageManager: ObservableObject {

    // MARK: Public properties

    static let shared = LanguageManager()

    @Published var currentLanguage: String = "en" {
        didSet {
            setLanguage(currentLanguage)
        }
    }

    // MARK: Private properties

    private var customBundle = Bundle.main

    // MARK: Init

    private init() { }

    // MARK: Public methods

    func setLanguage(_ language: String) {
        if let path = Bundle.main.path(forResource: language, ofType: "lproj"),
           let newLanguageBundle = Bundle(path: path) {
            self.customBundle = newLanguageBundle
        } else {
            self.customBundle = Bundle.main
        }
    }

    func localizedString(forKey key: String) -> String {
        return customBundle.localizedString(
            forKey: key,
            value: nil,
            table: nil
        )
    }
}
