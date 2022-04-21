//
//  CoreGraphics+Hashable.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation
import UIKit

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}

extension CGSize : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
    }
}


extension CGRect: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(origin)
        hasher.combine(size)
    }
}
