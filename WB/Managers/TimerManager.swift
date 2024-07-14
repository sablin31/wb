//
//  TimerManager.swift
//  WB
//
//  Created by Aleksei Sablin on 02.07.2024.
//

import SwiftUI
import Combine

class TimerManager: ObservableObject {

    // MARK: Public properties

    @Published var timeRemaining: Int = 0
    var timer: Timer?

    // MARK: Public methods

    func start(on timeRemaining: Int) {
        self.timeRemaining = timeRemaining
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
            }
        }
    }

    func stop() {
        timer?.invalidate()
    }
}
