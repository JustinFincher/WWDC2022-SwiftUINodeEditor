//
//  PageManager.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SwiftUI

class PageManager : BaseManager {
    
    static let instance = PageManager()
    
    override class var shared: PageManager {
        return instance
    }
    
    @ObservedObject var nodePageData : NodePageData = NodePageDataChapterOne()
    
    
    override func setup() {
        
    }
    
    override func destroy() {
        
    }
}
