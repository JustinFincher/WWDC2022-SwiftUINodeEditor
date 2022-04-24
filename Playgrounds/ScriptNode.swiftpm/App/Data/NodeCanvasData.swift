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
    
    func addNode(newNodeType : NodeData.Type, position: CGPoint) -> NodeData {
        let newNode = newNodeType.init(nodeID: getNextNodeID())
            .withCanvasPosition(canvasPosition: position)
            .withCanvas(canvasData: self)
        nodes.append(newNode)
        return newNode
    }
    
    func getNextNodeID () -> Int {
        return (nodes.map { node in
            node.nodeID
        }.max() ?? -1) + 1
    }
    
    func deleteNode(node : NodeData) {
        node.destroy()
        nodes.removeAll { nodeData in
            nodeData == node
        }
    }
    
    func destroy() {
        nodes.forEach { nodeData in
            deleteNode(node: nodeData)
        }
        pendingConnections.forEach { connectionData in
            connectionData.destroy()
        }
    }
}
