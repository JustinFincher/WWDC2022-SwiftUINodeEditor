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
    func perform() -> Void
    func exposedToUser() -> Bool
    func getDefaultTitle() -> String
    func getDefaultControlInPorts() -> [NodeControlPortData]
    func getDefaultControlOutPorts() -> [NodeControlPortData]
    func getDefaultDataInPorts() -> [NodeDataPortData]
    func getDefaultDataOutPorts() -> [NodeDataPortData]
}

class NodeData : NodeProtocol, Identifiable, Hashable, Equatable {
    
    static func == (lhs: NodeData, rhs: NodeData) -> Bool {
        return lhs.canvasPosition == rhs.canvasPosition
        && lhs.nodeID == rhs.nodeID
        && lhs.title == rhs.title
        && lhs.inDataPorts == rhs.inDataPorts
        && lhs.outDataPorts == rhs.outDataPorts
        && lhs.inControlPorts == rhs.inControlPorts
        && lhs.outControlPorts == rhs.outControlPorts
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(canvasPosition)
        hasher.combine(nodeID)
        hasher.combine(title)
        hasher.combine(inDataPorts)
        hasher.combine(outDataPorts)
        hasher.combine(inControlPorts)
        hasher.combine(outControlPorts)
    }
    
    func getDefaultTitle() -> String {
        return ""
    }
    
    func getDefaultDataInPorts() -> [NodeDataPortData] {
        return []
    }
    
    func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return []
    }
    
    func getDefaultControlInPorts() -> [NodeControlPortData] {
        return []
    }
    
    func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return []
    }
    
    func perform() {
        
    }
    
    func exposedToUser() -> Bool {
        true
    }
    
    @Published var canvasPosition = CGPoint.zero
    @Published var nodeID : Int
    @Published var title = ""
    @Published var inDataPorts : [NodeDataPortData] = [] {
        willSet {
            // TODO: should cancel objectWillChange on old value?
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published var outDataPorts : [NodeDataPortData] = [] {
        willSet {
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published var inControlPorts : [NodeControlPortData] = [] {
        willSet {
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    @Published var outControlPorts : [NodeControlPortData] = [] {
        willSet {
            newValue.forEach({ port in
                port.objectWillChange.assign(to: &$childWillChange)
            })
        }
    }
    
    @Published private var childWillChange: Void = ()
    
    var inPorts : [NodePortData] {
        return inDataPorts + inControlPorts
    }
    
    var outPorts : [NodePortData] {
        return outDataPorts + outControlPorts
    }
    
    required init(nodeID: Int) {
        self.nodeID = nodeID
        self.title = getDefaultTitle()
        self.inDataPorts = getDefaultDataInPorts()
        self.outDataPorts = getDefaultDataOutPorts()
        self.inControlPorts = getDefaultControlInPorts()
        self.outControlPorts = getDefaultControlOutPorts()
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
}
