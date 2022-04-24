//
//  NodePortData.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation
import UIKit
import Combine
import SwiftUI

protocol NodePortProtocol : ObservableObject, Identifiable, Hashable {
    func canConnect() -> Bool
    func canConnectTo(anotherPort : Self) -> Bool
    func connectTo(anotherPort :Self)
    func icon() -> Image
    func color() -> Color
    func nodePortDescription() -> String
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
            print("\(nodePortDescription()) connections willSet \(connections) -> \(newValue)")
            newValue.forEach({ connection in
                connection.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published private var childWillChange: Void = ()
    
    weak var nodeData : NodeData?
    
    required init(portID: Int, direction: NodePortDirection) {
        self.portID = portID
        self.direction = direction
    }
    
    convenience init(portID: Int, name: String, direction: NodePortDirection, nodeData: NodeData) {
        self.init(portID: portID, direction: direction)
        self.name = name
        self.nodeData = nodeData
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
    
    func icon() -> Image {
        Image(systemName: "circlebadge.fill")
    }
    
    func color() -> Color {
        Color.black
    }
    
    func canConnect() -> Bool {
        false
    }
    
    func canConnectTo(anotherPort: NodePortData) -> Bool {
        false
    }
    
    func connectTo(anotherPort: NodePortData) {
        
    }
    
    func destroy() {
        connections.forEach { connectionData in
            nodeData?.canvas?.pendingConnections.removeAll(where: { pendingConnection in
                pendingConnection == connectionData
            })
            connectionData.destroy()
        }
        connections.removeAll()
        nodeData = nil
    }
    
    func nodePortDescription() -> String {
        return "Port \(type(of: self)) \(nodeData?.nodeID ?? -1)-\(direction)-\(portID) (\(name))"
    }

}

// Control flow
class NodeControlPortData : NodePortData {
    
    override func icon() -> Image {
        return Image(systemName: "arrowtriangle.forward.fill")
    }
    
    override func color() -> Color {
        Color.blue
    }
    
    override func canConnect() -> Bool {
        if (self.direction == .output && !self.connections.isEmpty) {
            return false
        }
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
            let nodePortConnection : NodePortConnectionData
            if direction == .output {
                nodePortConnection = NodePortConnectionData(startPort: self, endPort: anotherPort)
            } else {
                nodePortConnection = NodePortConnectionData(startPort: anotherPort, endPort: self)
            }
            nodePortConnection.connect()
        }
    }
}


// Data flow
class NodeDataPortData : NodePortData {
    
    class func getDefaultValue() -> Any? {
        return {}
    }
    
    class func getDefaultValueType() -> Any {
        return Void.self
    }
    
    private var _value : Any?
    private var _valueGetter : (() -> Any?)?
    private var _valueSetter : ((Any?) -> ())?
    var value : Any? {
        get {
            if self.direction == .input, let remote = self.connections[safe: 0]?.startPort as? NodeDataPortData {
                return remote.value
            } else if let _valueGetter = _valueGetter, let _valueSetter = _valueSetter {
                return _valueGetter() // for get from outside
            } else {
                return _value
            }
        }
        set {
            if self.direction == .input, let remote = self.connections[safe: 0]?.startPort as? NodeDataPortData {
                remote.value = newValue
            } else if let _valueGetter = _valueGetter, let _valueSetter = _valueSetter {
                _valueSetter(newValue) // for set from outside
            } else {
                _value = newValue
            }
            self.objectWillChange.send()
        }
    }
    
    required init(portID: Int, direction: NodePortDirection) {
        _value = type(of: self).getDefaultValue()
        _valueGetter = { return nil }
        super.init(portID: portID, direction: direction)
    }
    
    convenience init(portID: Int, direction: NodePortDirection, name: String, defaultValueGetter: @escaping (() -> Any?), defaultValueSetter: @escaping ((Any?) -> ())) {
        self.init(portID: portID, direction: direction)
        self.name = name
        _valueGetter = defaultValueGetter
        _valueSetter = defaultValueSetter
    }
    convenience init(portID: Int, direction: NodePortDirection, name: String, defaultValue: Any) {
        self.init(portID: portID, direction: direction)
        self.name = name
        _value = defaultValue
    }
    
    override func icon() -> Image {
        return Image(systemName: "circlebadge.fill")
    }
    
    override func color() -> Color {
        Color.green
    }
    
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
            let nodePortConnection : NodePortConnectionData
            if direction == .output {
                nodePortConnection = NodePortConnectionData(startPort: self, endPort: anotherPort)
            } else {
                nodePortConnection = NodePortConnectionData(startPort: anotherPort, endPort: self)
            }
            nodePortConnection.connect()
        }
    }
    

}
