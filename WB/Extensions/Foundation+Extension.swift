//
//  Foundation+Extension.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import Foundation

extension String {
    func isValid(regex: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }

    func format(mask: String) -> String {
        var formattedValue = ""
        let cleanValue = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        var index = cleanValue.startIndex
        for char in mask where index < cleanValue.endIndex {
            if char == "X" {
                formattedValue.append(cleanValue[index])
                index = cleanValue.index(after: index)
            } else {
                formattedValue.append(char)
            }
        }

        return formattedValue
    }
}
