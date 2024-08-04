//
//  AnyContainer.swift
//  WB
//
//  Created by Aleksei Sablin on 21.07.2024.
//

import Foundation

class AnyContainer<Item>: Container {

    private var _add: (Item) -> Void
    private var _remove: () -> Item?

    init<C: Container>(_ container: C) where C.Item == Item {
        var mutableContainer = container
        _add = { mutableContainer.add($0) }
        _remove = { mutableContainer.remove() }
    }

    func add(_ item: Item) {
        _add(item)
    }

    func remove() -> Item? {
        _remove()
    }
}
