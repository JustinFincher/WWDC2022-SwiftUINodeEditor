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
    @Published var pendingConnections : [NodePortConnectionData] = [] {
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
            DummyNode(nodeID: 2, canvasPosition: .init(x: 800, y: 200)),
            
            StartNode(nodeID: 3, canvasPosition: .init(x: 300, y: 450)),
            IfNode(nodeID: 4, canvasPosition: .init(x: 500, y: 450))
        ]
        
        self.nodes[0].outDataPorts[0].connectTo(anotherPort: self.nodes[1].inDataPorts[0])
        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[2].inDataPorts[0])
        
        
        return self
    }
}
