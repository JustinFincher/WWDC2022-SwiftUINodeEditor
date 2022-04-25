//
//  RenderManager.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation

import Foundation
import SwiftUI
import SpriteKit

class RenderManager : BaseManager, SKViewDelegate {
    
    static let instance = RenderManager()
    
    override class var shared: RenderManager {
        return instance
    }
    
    func view(_ view: SKView, shouldRenderAtTime time: TimeInterval) -> Bool {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "newFrameRendered"), object: nil)
        return true
    }
    
}
