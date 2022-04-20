//
//  NodeCanvasData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation
import Combine
import SwiftUI

class NodeCanvasData : ObservableObject {
    
    @Published var canvasSize : CGSize = .init(width: 3200, height: 3200)
    @Published var nodes : [NodeData] = [] {
        willSet {
            newValue.forEach({ node in
                node.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published var pendingConnections : [NodePortConnection] = [] {
        willSet {
            newValue.forEach({ node in
                node.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published private var childWillChange: Void = ()
    
    init() {
    }
    
    convenience init(nodes : [NodeData]) {
        self.init()
        self.nodes = nodes
    }
    
    func withTestConfig() -> NodeCanvasData {
        self.nodes = [
            IntNode(nodeID: 0, canvasPosition: .init(x: 130, y: 130)),
            DummyNode(nodeID: 1, canvasPosition: .init(x: 400, y: 200)),
            DummyNode(nodeID: 2, canvasPosition: .init(x: 400, y: 600)),
        ]
        
        self.nodes[0].outPorts[0].connectTo(anotherPort: self.nodes[1].inPorts[0])
        self.nodes[1].outPorts[0].connectTo(anotherPort: self.nodes[2].inPorts[0])
        
        
        return self
    }
}
