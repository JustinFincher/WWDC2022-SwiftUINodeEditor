//
//  NodePortData.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation
import UIKit
import Combine

protocol NodePortProtocol : ObservableObject, Identifiable, Hashable {
    func canConnect() -> Bool
    func canConnectTo(anotherPort : Self) -> Bool
    func connectTo(anotherPort :Self)
}

enum NodePortDirection : String {
    case input
    case output
}

class NodePortData : NodePortProtocol {
    
    @Published var portID : Int
    @Published var direction : NodePortDirection = .input
    @Published var name = ""
    @Published var canvasRect = CGRect.zero
    @Published var connections : [NodePortConnectionData] = [] {
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
    
    func canConnect() -> Bool {
        false
    }
    
    func canConnectTo(anotherPort: NodePortData) -> Bool {
        false
    }
    
    func connectTo(anotherPort: NodePortData) {
        
    }
}

// Control flow
class NodeControlPortData : NodePortData {
    
    override func canConnect() -> Bool {
        return true
    }
    
    override func canConnectTo(anotherPort: NodePortData) -> Bool {
        if let anotherPort = anotherPort as? NodeControlPortData {
            // cannot connect same direction
            if (self.direction == anotherPort.direction) {
                return false
            }
            // TODO: cannot connect port on same node
            return true
        }
        return false
    }
    
    override func connectTo(anotherPort: NodePortData) {
        if (!canConnectTo(anotherPort: anotherPort)) {
            return
        }
        if let anotherPort = anotherPort as? NodeControlPortData {
            let nodePortConnection = NodePortConnectionData()
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
}


// Data flow
class NodeDataPortData : NodePortData {
    
    override func canConnect() -> Bool {
        if (self.direction == .input && !self.connections.isEmpty) {
            return false
        }
        return true
    }
    
    override func canConnectTo(anotherPort: NodePortData) -> Bool {
        if let anotherPort = anotherPort as? NodeDataPortData {
            // input node can only connect at most 1
            if (self.direction == .input && !self.connections.isEmpty) {
                return false
            }
            // cannot connect same direction
            if (self.direction == anotherPort.direction) {
                return false
            }
            // TODO: cannot connect port on same node
            return true
        }
        return false
    }
    
    override func connectTo(anotherPort: NodePortData) {
        if (!canConnectTo(anotherPort: anotherPort)) {
            return
        }
        if let anotherPort = anotherPort as? NodeDataPortData {
            let nodePortConnection = NodePortConnectionData()
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
}
