//
//  PageManager.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SwiftUI

class PageManager : BaseManager, ObservableObject {
    
    static let instance = PageManager()
    
    override class var shared: PageManager {
        return instance
    }
    
    @Published var nodePageData : NodePageData = NodePageDataChapterOne()
    
    @State var pages : [NodePageDataProxy] = [
        NodePageDataProxy(index: 0, type: NodePageDataChapterZero.self),
        NodePageDataProxy(index: 1, type: NodePageDataChapterOne.self),
        NodePageDataProxy(index: 2, type: NodePageDataChapterTwo.self)
    ]
    
    func switchTo(type : NodePageData.Type) {
        nodePageData.nodeCanvasData.destroy()
        nodePageData = type.init()
        objectWillChange.send()
    }
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}
