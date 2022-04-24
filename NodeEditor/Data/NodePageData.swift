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

class NodePageDataProxy : Identifiable {
    required init(index: Int, type: NodePageData.Type) {
        self.index = index
        self.type = type
    }
    var index : Int = 0
    var type : NodePageData.Type = NodePageData.self
}

class NodePageData : ObservableObject
{
    @Published var nodeCanvasData : NodeCanvasData
    @Published var docView : () -> AnyView
    @Published var liveScene : SKScene
    @Published var playing : Bool = true
    var bird : SKSpriteNode = SKSpriteNode()
    
    class func getTitle() -> String {
        return ""
    }
    
    required init() {
        nodeCanvasData = NodeCanvasData()
        docView = {
            AnyView(ZStack{})
        }
        liveScene = SKScene()
        
        reset()
        objectWillChange.send()
    }
    
    func reset() {
        print("NodePageData.reset")
        nodeCanvasData.destroy()
    }
    
    func cheat() {
        
    }
}
