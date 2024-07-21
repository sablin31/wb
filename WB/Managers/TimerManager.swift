//
//  TimerManager.swift
//  WB
//
//  Created by Aleksei Sablin on 02.07.2024.
//

import SwiftUI
import Combine

final class SMSTimerManager: ObservableObject {

    // MARK: Public properties

    static let shared = SMSTimerManager()

    @Published var timeRemaining: Int?

    // MARK: Private properties

    private var timer: Timer?

    // MARK: Init

    private init() {}

    // MARK: Public methods

    func start(on timeRemaining: Int) {
        if self.timeRemaining == nil || self.timeRemaining == 0 {
            self.timeRemaining = timeRemaining
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self, var timeRemaining = self.timeRemaining else { return }
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    self.timeRemaining = timeRemaining
                } else {
                    timer.invalidate()
                }
            }
        }
    }

    func stop() {
        timer?.invalidate()
    }
}
