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
    func canConnectTo(anotherPort : NodeDataPortData)
    func connectTo(anotherPort : NodeDataPortData)
}

enum NodePortDirection : String {
    case input
    case output
}


class NodeDataPortData : ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: NodeDataPortData, rhs: NodeDataPortData) -> Bool {
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
    
    func canConnect() -> Bool {
        if (self.direction == .input && !self.connections.isEmpty) {
            return false
        }
        return true
    }
    
    func canConnectTo(anotherPort : NodeDataPortData) -> Bool {
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
    
    func connectTo(anotherPort : NodeDataPortData) {
        if (!canConnectTo(anotherPort: anotherPort)) {
            return
        }
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
