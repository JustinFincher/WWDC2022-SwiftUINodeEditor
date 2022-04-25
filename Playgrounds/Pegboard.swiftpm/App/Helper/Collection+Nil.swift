//
//  Collection+Nil.swift
//  ScriptNode
//
//  Created by fincher on 4/22/22.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
