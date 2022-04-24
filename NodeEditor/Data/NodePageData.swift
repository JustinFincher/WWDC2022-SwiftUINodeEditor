//
//  NodePageData.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SwiftUI
import Combine
import SpriteKit

class NodePageData : ObservableObject
{
    @ObservedObject var nodeCanvasData : NodeCanvasData
    @Published var docView : AnyView
    @Published var liveScene : SKScene
    @Published var playing : Bool = true
    var bird : SKSpriteNode = SKSpriteNode()
    
    required init() {
        nodeCanvasData = NodeCanvasData()
        docView = AnyView(ZStack{})
        liveScene = SKScene()
        
        reset()
    }
    
    func reset() {
        nodeCanvasData.destroy()

    }
    
    func cheat() {
        
    }
}
