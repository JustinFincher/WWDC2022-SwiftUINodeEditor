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
    
    func addNode(newNode : NodeData, position: CGPoint) -> NodeData {
        newNode.nodeID = getNextNodeID()
        newNode.canvasPosition = position
        nodes.append(newNode)
        return newNode
    }
    
    func addNode(newNodeType : NodeData.Type, position: CGPoint) -> NodeData {
        var newNode = newNodeType.init(nodeID: getNextNodeID())
        newNode.canvasPosition = position
        nodes.append(newNode)
        return newNode
    }
    
    func getNextNodeID () -> Int {
        return (nodes.map { node in
            node.nodeID
        }.max() ?? -1) + 1
    }
    
    func withTestConfig() -> NodeCanvasData {
        self.nodes = [
            IntNode(nodeID: 0, canvasPosition: .init(x: 100, y: 450)),
            IntNode(nodeID: 1, canvasPosition: .init(x: 100, y: 600)),
            UpdateNode(nodeID: 2, canvasPosition: .init(x: 200, y: 300)),
            
            StartNode(nodeID: 3, canvasPosition: .init(x: 200, y: 150)),
            IfNode(nodeID: 4, canvasPosition: .init(x: 500, y: 450)),
            EqualNode(nodeID: 5, canvasPosition: .init(x: 300, y: 600)),
            PrintNode(nodeID: 6, canvasPosition: .init(x: 700, y: 600))
        ]
        
        self.nodes[0].outDataPorts[0].connectTo(anotherPort: self.nodes[5].inDataPorts[0])
        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[5].inDataPorts[1])
        self.nodes[5].outDataPorts[0].connectTo(anotherPort: self.nodes[4].inDataPorts[0])
        self.nodes[3].outControlPorts[0].connectTo(anotherPort: self.nodes[4].inControlPorts[0])
        self.nodes[4].outControlPorts[1].connectTo(anotherPort: self.nodes[6].inControlPorts[0])
        
        
        return self
    }
}
