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

enum NodePortDirection : String {
    case input
    case output
}

class NodePortConnection : ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: NodePortConnection, rhs: NodePortConnection) -> Bool {
        return lhs.startPort == rhs.startPort
        && lhs.endPort == rhs.endPort
        && lhs.startPosIfPortNull == rhs.startPosIfPortNull
        && lhs.endPosIfPortNull == rhs.endPosIfPortNull
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startPos)
        hasher.combine(endPos)
    }
    
    weak var startPort : NodePortData? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var startPosIfPortNull : CGPoint = .zero
    var startPos : CGPoint {
        return startPort?.canvasRect.toCenter() ?? startPosIfPortNull
    }
    weak var endPort : NodePortData?{
        willSet {
            objectWillChange.send()
        }
    }
    @Published var endPosIfPortNull : CGPoint = .zero
    var endPos : CGPoint {
        return endPort?.canvasRect.toCenter() ?? endPosIfPortNull
    }
    
    // get the port that is not connected
    var getPendingPortDirection : NodePortDirection? {
        if startPort == nil {
            return .output
        }
        if endPort == nil {
            return .input
        }
        return nil
    }
    
    func disconnect(portDirection : NodePortDirection) {
        if portDirection == .output {
            startPort?.connections.removeAll { connection in
                connection == self
            }
            startPort = nil
        } else {
            endPort?.connections.removeAll { connection in
                connection == self
            }
            endPort = nil
        }
    }
}

class NodePortData : ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: NodePortData, rhs: NodePortData) -> Bool {
        return lhs.portID == rhs.portID
        && lhs.direction == rhs.direction
        && lhs.name == rhs.name
        && lhs.canvasRect == rhs.canvasRect
        && lhs.connections == rhs.connections
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(portID)
        hasher.combine(direction)
        hasher.combine(name)
        hasher.combine(canvasRect)
        hasher.combine(connections)
    }
    
    @Published var portID : Int
    @Published var direction : NodePortDirection = .input
    @Published var name = ""
    @Published var canvasRect = CGRect.zero
    @Published var connections : [NodePortConnection] = [] {
        willSet {
            newValue.forEach({ connection in
                connection.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    
    @Published private var childWillChange: Void = ()
    
    init(portID: Int, direction: NodePortDirection) {
        self.portID = portID
        self.direction = direction
    }
    
    convenience init(portID: Int, name: String, direction: NodePortDirection) {
        self.init(portID: portID, direction: direction)
        self.name = name
    }
    
    func canConnect() -> Bool {
        if (self.direction == .input && !self.connections.isEmpty) {
            return false
        }
        return true
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
        if direction == .output {
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

class NodeData : NodeProtocol, Identifiable, Hashable, Equatable {
    
    static func == (lhs: NodeData, rhs: NodeData) -> Bool {
        return lhs.canvasPosition == rhs.canvasPosition
        && lhs.nodeID == rhs.nodeID
        && lhs.title == rhs.title
        && lhs.inPorts == rhs.inPorts
        && lhs.outPorts == rhs.outPorts
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(canvasPosition)
        hasher.combine(nodeID)
        hasher.combine(title)
    }
    
    func getDefaultTitle() -> String {
        return ""
    }
    
    func getDefaultInPorts() -> [NodePortData] {
        return []
    }
    
    func getDefaultOutPorts() -> [NodePortData] {
        return []
    }
    
    
    @Published var canvasPosition = CGPoint.zero
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
    
    convenience init(nodeID: Int, canvasPosition: CGPoint) {
        self.init(nodeID: nodeID)
        self.canvasPosition = canvasPosition
    }
    
    convenience init(nodeID: Int, title: String) {
        self.init(nodeID: nodeID)
        self.title = title
    }
    
    convenience init(nodeID: Int, title: String, canvasPosition: CGPoint) {
        self.init(nodeID: nodeID, title: title)
        self.canvasPosition = canvasPosition
    }
    
    convenience init(nodeID: Int, title: String, canvasPosition: CGPoint, inPorts: [NodePortData], outPorts: [NodePortData]) {
        self.init(nodeID: nodeID, title: title, canvasPosition: canvasPosition)
        self.inPorts = inPorts
        self.outPorts = outPorts
    }
    
}
