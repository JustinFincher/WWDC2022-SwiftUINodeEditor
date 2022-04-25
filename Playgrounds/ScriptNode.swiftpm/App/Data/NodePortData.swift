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

enum NodePortConnectionAbility {
    case can
    case cannot(String)
}

protocol NodePortProtocol : ObservableObject, Identifiable, Hashable {
    func canConnect() -> NodePortConnectionAbility
    func canConnectTo(anotherPort : Self) -> NodePortConnectionAbility
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
    
    func canConnect() -> NodePortConnectionAbility {
        .cannot("")
    }
    
    func canConnectTo(anotherPort: NodePortData) -> NodePortConnectionAbility {
        .cannot("")
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
    
    override func canConnect() -> NodePortConnectionAbility {
        if (self.direction == .output && !self.connections.isEmpty) {
            return .cannot("port already occupied")
        }
        return .can
    }
    
    override func canConnectTo(anotherPort: NodePortData) -> NodePortConnectionAbility {
        switch canConnect() {
        case .cannot(let reason):
            return .cannot(reason)
        case .can:
            break
        }
        if let anotherPort = anotherPort as? NodeControlPortData {
            
                // cannot connect same port
                if (self == anotherPort) {
                    return .cannot("cannot connect itself")
                }
            // cannot connect same direction
            if (self.direction == anotherPort.direction) {
                return .cannot("cannot connect ports on the same side, has to be one out, one in")
            }
            // cannot connect same node
            if (self.nodeData == anotherPort.nodeData) {
                return .cannot("cannot connect ports on the same node")
            }
            return .can
        }
        return .cannot("control port has to be connected to control port (arrows)")
    }
    
    override func connectTo(anotherPort: NodePortData) {
        switch canConnectTo(anotherPort: anotherPort) {
        case .can:
            break
        case .cannot(let reason):
            print("\(reason)")
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
    
    class func getDefaultValueType() -> Any.Type {
        return Void.self
    }
    
    private var _value : Any?
    private var _valueGetter : (() -> Any?)?
    private var _valueSetter : ((Any?) -> ())?
    var value : Any? {
        get {
            if self.direction == .input, let remote = self.connections[safe: 0]?.startPort as? NodeDataPortData {
                return remote.value
            } else if let _valueGetter = _valueGetter, let _ = _valueSetter {
                return _valueGetter() // for get from outside
            } else {
                return _value
            }
        }
        set {
            if self.direction == .input, let remote = self.connections[safe: 0]?.startPort as? NodeDataPortData {
                remote.value = newValue
            } else if let _ = _valueGetter, let _valueSetter = _valueSetter {
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
    
    override func canConnect() -> NodePortConnectionAbility {
        // input node can only connect at most 1
        if (self.direction == .input && !self.connections.isEmpty) {
            return .cannot("port already occupied")
        }
        return .can
    }
    
    override func canConnectTo(anotherPort: NodePortData) -> NodePortConnectionAbility {
        switch canConnect() {
        case .cannot(let reason):
            return .cannot(reason)
        case .can:
            break
        }
        if let anotherPort = anotherPort as? NodeDataPortData {
            // cannot connect same port
            if (self == anotherPort) {
                return .cannot("cannot connect itself")
            }
            // cannot connect same direction
            if (self.direction == anotherPort.direction) {
                return .cannot("cannot connect ports on the same side, has to be one out, one in")
            }
            // cannot connect same node
            if (self.nodeData == anotherPort.nodeData) {
                return .cannot("cannot connect ports on the same node")
            }
            if type(of: self).getDefaultValueType() != type(of: anotherPort).getDefaultValueType() {
                return .cannot("cannot connect different type (\(type(of: self).getDefaultValueType()), \(type(of: anotherPort).getDefaultValueType()))")
            }
            return .can
        }
        return .cannot("data port has to be connected to data port (circles)")
    }
    
    override func connectTo(anotherPort: NodePortData) {
        switch canConnectTo(anotherPort: anotherPort) {
        case .can:
            break
        case .cannot(let reason):
            print("\(reason)")
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
