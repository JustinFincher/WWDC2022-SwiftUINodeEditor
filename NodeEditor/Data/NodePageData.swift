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

protocol NodePageDataProvider {
    func modifyCanvas(nodePageData : NodePageData)
    func modifyDocView(nodePageData : NodePageData)
    func modifyLiveScene(nodePageData : NodePageData)
    func cheat(nodePageData : NodePageData)
    func destroy(nodePageData : NodePageData)
}

class NodePageData : ObservableObject
{
    @ObservedObject var nodeCanvasData : NodeCanvasData
    @Published var docView : AnyView
    @Published var liveScene : SKScene
    @Published var playing : Bool = true
    var bird : SKSpriteNode = SKSpriteNode()
    
    var modifier : NodePageDataProvider = NodePageDataProviderChapterZero()
    
    required init() {
        nodeCanvasData = NodeCanvasData()
        docView = AnyView(ZStack{})
        liveScene = SKScene()
        
        switchTo(index: 0)
    }
    
    func cheat() {
        
    }
    
    func reset() {
        modifier.modifyCanvas(nodePageData: self)
        modifier.modifyDocView(nodePageData: self)
        modifier.modifyLiveScene(nodePageData: self)
    }
    
    func switchTo(index : Int) {
        modifier.destroy(nodePageData: self)
        // switch modifer
        switch index {
        case 0:
            modifier = NodePageDataProviderChapterZero()
            break
        case 1:
            modifier = NodePageDataProviderChapterOne()
            break
        default:
            break
        }
        reset()
    }
}
