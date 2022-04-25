//
//  String+Identifiable.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
