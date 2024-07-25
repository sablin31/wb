//
//  Cargo.swift
//  WB
//
//  Created by Aleksei Sablin on 25.07.2024.
//

import Foundation

struct Cargo {

    // MARK: Public properties

    var width: Double
    var height: Double
    var length: Double

    // MARK: Computed properties

    var volume: Double {
        width * height * length
    }

    // MARK: Public methods

    static func +++(lhs: Cargo, rhs: Cargo) -> Double {
        lhs.volume + rhs.volume
    }
}
