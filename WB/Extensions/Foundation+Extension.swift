//
//  Foundation+Extension.swift
//  WB
//
//  Created by Aleksei Sablin on 01.07.2024.
//

import Foundation

infix operator +++

extension String {
    var localized: String {
        LanguageManager.shared.localizedString(forKey: self)
    }

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

extension Date {
    static let formatter = DateFormatter()

    func formattedDate(dateStyle: DateFormatter.Style,
                       timeStyle: DateFormatter.Style? = nil) -> String {
        Date.formatter.dateFormat = nil
        Date.formatter.dateStyle = dateStyle
        if let timeStyle {
            Date.formatter.timeStyle = timeStyle
        }
        return Date.formatter.string(from: self)
    }
    
    func formattedDate(dateFormat: String) -> String {
        Date.formatter.dateFormat = nil
        Date.formatter.dateFormat = dateFormat
        return Date.formatter.string(from: self)
    }
}

extension Stack: Container {
    mutating func add(_ item: Element) {
        push(item)
    }

    mutating func remove() -> Element? {
        pop()
    }
}

extension Queue: Container {
    func add(_ item: Element) {
        enqueue(item)
    }

    func remove() -> Element? {
        dequeue()
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
