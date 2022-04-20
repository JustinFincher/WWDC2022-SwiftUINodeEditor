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
    
    @Published var canvasSize : CGSize = .init(width: 1200, height: 1200)
    @Published var nodes : [NodeData] = [] {
        willSet {
            newValue.forEach({ node in
                node.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published private var childWillChange: Void = ()
    
    init() {
        let _ = $childWillChange.sink { newVoid in
            self.objectWillChange.send()
        }
    }
    
    convenience init(nodes : [NodeData]) {
        self.init()
        self.nodes = nodes
    }
    
    func withTestConfig() -> NodeCanvasData {
        self.nodes = [
            IntNode(nodeID: 0, canvasOffset: .init(x: 500, y: 500)),
            DummyNode(nodeID: 1, canvasOffset: .init(x: 150, y: 200))
        ]
        
        self.nodes[0].outPorts[0].connectTo(anotherPort: self.nodes[1].inPorts[0])
        
        
        return self
    }
}
