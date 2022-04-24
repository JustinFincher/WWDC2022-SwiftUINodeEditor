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
        let newNode = newNodeType.init(nodeID: getNextNodeID())
        newNode.canvasPosition = position
        nodes.append(newNode)
        return newNode
    }
    
    func getNextNodeID () -> Int {
        return (nodes.map { node in
            node.nodeID
        }.max() ?? -1) + 1
    }
    
    func withTestConfig1() -> NodeCanvasData {
        self.nodes = [
            UpdateNode(nodeID: 0, canvasPosition: .init(x: 200, y: 300)),
            StartNode(nodeID: 1, canvasPosition: .init(x: 200, y: 150)),
            PrintNode(nodeID: 2, canvasPosition: .init(x: 1000, y: 560)),
            TriggerNode(nodeID: 3, canvasPosition: .init(x: 450, y: 150)),
            StringNode(nodeID: 4, canvasPosition: .init(x: 740, y: 600))
        ]
        
        
        self.nodes[4].outDataPorts[0].connectTo(anotherPort: self.nodes[2].inDataPorts[0])
        self.nodes[3].outControlPorts[0].connectTo(anotherPort: self.nodes[2].inControlPorts[0])
        self.nodes[1].outControlPorts[0].connectTo(anotherPort: self.nodes[2].inControlPorts[0])
        
        
        return self
    }
    
    func withTestConfig2() -> NodeCanvasData {
        self.nodes = [
            StartNode(nodeID: 0, canvasPosition: .init(x: 150, y: 150)),
            UpdateNode(nodeID: 1, canvasPosition: .init(x: 150, y: 300)),
            SceneNode(nodeID: 2, canvasPosition: .init(x: 420, y: 180)),
            PreviewNode(nodeID: 3, canvasPosition: .init(x: 800, y: 250))
        ]
        
        self.nodes[0].outControlPorts[0].connectTo(anotherPort: self.nodes[2].inControlPorts[0])
        self.nodes[2].outDataPorts[0].connectTo(anotherPort: self.nodes[3].inDataPorts[0])
        
        
        return self
    }
    
    func withTestConfig3() -> NodeCanvasData {
        self.nodes = [
            TriggerNode(nodeID: 0, canvasPosition: .init(x: 180, y: 180)),
            BirdNode(nodeID: 1, canvasPosition: .init(x: 300, y: 180)),
            ApplyForceNode(nodeID: 2, canvasPosition: .init(x: 400, y: 180)),
            VectorNode(nodeID: 3, canvasPosition: .init(x: 400, y: 300))
        ]
//
//        self.nodes[0].outControlPorts[0].connectTo(anotherPort: self.nodes[3].inControlPorts[0])
//        self.nodes[3].outControlPorts[0].connectTo(anotherPort: self.nodes[2].inControlPorts[0])
//        self.nodes[2].outControlPorts[0].connectTo(anotherPort: self.nodes[4].inControlPorts[0])
//
//        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[3].inDataPorts[0])
//        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[2].inDataPorts[0])
//        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[4].inDataPorts[0])
        
        return self
    }
    
    func withTestConfig4() -> NodeCanvasData {
        self.nodes = [
            TriggerNode(nodeID: 0, canvasPosition: .init(x: 180, y: 180)),
            BoolNode(nodeID: 1, canvasPosition: .init(x: 200, y: 400)),
            SetValueNode(nodeID: 2, canvasPosition: .init(x: 700, y: 480)),
            WhileNode(nodeID: 3, canvasPosition: .init(x: 500, y: 200)),
            PrintNode(nodeID: 4, canvasPosition: .init(x: 450, y: 650)),
        ]
        
        self.nodes[0].outControlPorts[0].connectTo(anotherPort: self.nodes[3].inControlPorts[0])
        self.nodes[3].outControlPorts[0].connectTo(anotherPort: self.nodes[2].inControlPorts[0])
        self.nodes[2].outControlPorts[0].connectTo(anotherPort: self.nodes[4].inControlPorts[0])
        
        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[3].inDataPorts[0])
        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[2].inDataPorts[0])
        self.nodes[1].outDataPorts[0].connectTo(anotherPort: self.nodes[4].inDataPorts[0])
        
        return self
    }
}
