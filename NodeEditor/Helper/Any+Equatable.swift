//
//  Any+Equatable.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation

func equals(_ x : Any, _ y : Any) -> Bool {
    guard x is AnyHashable else { return false }
    guard y is AnyHashable else { return false }
    return (x as! AnyHashable) == (y as! AnyHashable)
}
