//
//  NodeData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import UIKit
import Combine


protocol NodeProtocol : ObservableObject {
    func getDefaultTitle() -> String
    func getDefaultInPorts() -> [NodePortData]
    func getDefaultOutPorts() -> [NodePortData]
}

enum NodePortDirection {
    case input
    case output
}

class NodePortConnection : ObservableObject, Identifiable {
    weak var startPort : NodePortData?
    @Published var startPosIfPortNull : CGPoint = .zero
    var startPos : CGPoint {
        return startPort?.canvasOffset ?? startPosIfPortNull
    }
    weak var endPort : NodePortData?
    @Published var endPosIfPortNull : CGPoint = .zero
    var endPos : CGPoint {
        return endPort?.canvasOffset ?? endPosIfPortNull
    }
}

class NodePortData : ObservableObject, Identifiable {
    
    @Published var portID : Int
    @Published var direction : NodePortDirection = .input
    @Published var name = ""
    @Published var canvasOffset = CGPoint.zero
    @Published var connections : [NodePortConnection] = []
    
    init(portID: Int) {
        self.portID = portID
    }
    
    init(portID: Int, name: String, direction: NodePortDirection) {
        self.portID = portID
        self.name = name
        self.direction = direction
    }
    
    func canConnectTo(anotherPort : NodePortData) -> Bool {
        // input node can only connect at most 1
        if (self.direction == .input && !self.connections.isEmpty) {
            return false
        }
        // cannot connect same direction
        if (self.direction == anotherPort.direction) {
            return false
        }
        // cannot connect port on same node
        return true
    }
    
    func connectTo(anotherPort : NodePortData) {
        if (!canConnectTo(anotherPort: anotherPort)) {
            return
        }
        let nodePortConnection = NodePortConnection()
        if direction == .input {
            nodePortConnection.startPort = self
            nodePortConnection.endPort = anotherPort
        } else {
            nodePortConnection.endPort = self
            nodePortConnection.startPort = anotherPort
        }
        self.connections.append(nodePortConnection)
        anotherPort.connections.append(nodePortConnection)
        
    }
}

class NodeData : NodeProtocol, Identifiable {
    func getDefaultTitle() -> String {
        return ""
    }
    
    func getDefaultInPorts() -> [NodePortData] {
        return []
    }
    
    func getDefaultOutPorts() -> [NodePortData] {
        return []
    }
    
    
    @Published var canvasOffset = CGPoint.zero
    @Published var nodeID : Int
    @Published var title = ""
    @Published var inPorts : [NodePortData] = [] {
        willSet {
            // TODO: should cancel objectWillChange on old value?
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published var outPorts : [NodePortData] = [] {
        willSet {
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    
    @Published private var childWillChange: Void = ()
    
    init(nodeID: Int) {
        self.nodeID = nodeID
        self.title = getDefaultTitle()
        self.inPorts = getDefaultInPorts()
        self.outPorts = getDefaultOutPorts()
        let _ = $childWillChange.sink { newVoid in
            self.objectWillChange.send()
        }
    }
    
    convenience init(nodeID: Int, canvasOffset: CGPoint) {
        self.init(nodeID: nodeID)
        self.canvasOffset = canvasOffset
    }
    
    convenience init(nodeID: Int, title: String) {
        self.init(nodeID: nodeID)
        self.title = title
    }
    
    convenience init(nodeID: Int, title: String, canvasOffset: CGPoint) {
        self.init(nodeID: nodeID, title: title)
        self.canvasOffset = canvasOffset
    }
    
    convenience init(nodeID: Int, title: String, canvasOffset: CGPoint, inPorts: [NodePortData], outPorts: [NodePortData]) {
        self.init(nodeID: nodeID, title: title, canvasOffset: canvasOffset)
        self.inPorts = inPorts
        self.outPorts = outPorts
    }
    
}
