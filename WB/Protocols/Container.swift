//
//  Container.swift
//  WB
//
//  Created by Aleksei Sablin on 21.07.2024.
//

import Foundation

protocol Container {

    associatedtype Item

    mutating func add(_ item: Item)
    mutating func remove() -> Item?
}
