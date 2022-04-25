//
//  NodeData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import UIKit
import Combine
import SwiftUI

protocol NodeProtocol : ObservableObject {
    associatedtype BaseImpType where BaseImpType : NodeProtocol
    func perform() -> Void
    func nodeDescription() -> String
    static func getDefaultPerformImplementation() -> ((_ node: BaseImpType) -> ())
    static func getDefaultExposedToUser() -> Bool
    static func getDefaultTitle() -> String
    static func getDefaultUsage() -> String
    static func getDefaultCategory() -> String
    static func getDefaultControlInPorts() -> [NodeControlPortData]
    static func getDefaultControlOutPorts() -> [NodeControlPortData]
    static func getDefaultDataInPorts() -> [NodeDataPortData]
    static func getDefaultDataOutPorts() -> [NodeDataPortData]
    static func getDefaultCustomRendering(node: BaseImpType) -> AnyView?
}

class NodeData : NodeProtocol, Identifiable, Hashable, Equatable {
    
    
    typealias BaseImpType = NodeData
    
    
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
    
    class func getDefaultCategory() -> String {
        return ""
    }
    
    class func getDefaultTitle() -> String {
        return ""
    }
    
    class func getDefaultUsage() -> String {
        return ""
    }
    
    class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return []
    }
    
    class func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return []
    }
    
    class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return []
    }
    
    class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return []
    }
    
    class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        nil
    }
    
    class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            
        }
    }
    
    func nodeDescription() -> String {
        "Node \(type(of: self)) \(self.nodeID) (\(self.title))"
    }
    
    func perform() {
//        print("\(nodeDescription()) perform()")
        type(of: self).getDefaultPerformImplementation()(self)
    }
    
    func getDataPortValue(direction : NodePortDirection, portID: Int) -> Any? {
        var nodePortData : NodeDataPortData?
        if direction == .input {
            nodePortData = inDataPorts.filter({ port in
                port.portID == portID
            }).first
        } else {
            nodePortData = outDataPorts.filter({ port in
                port.portID == portID
            }).first
        }
        if let nodePortData = nodePortData {
            return getDataPortValue(nodePortData: nodePortData)
        } else {
            return nil
        }
    }
    
    func getDataPortValue(nodePortData : NodeDataPortData) -> Any? {
        return nodePortData.value
    }
    
    class func getDefaultExposedToUser() -> Bool {
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
    
    weak var canvas : NodeCanvasData?
    
    var inPorts : [NodePortData] {
        return inDataPorts + inControlPorts
    }
    
    var outPorts : [NodePortData] {
        return outDataPorts + outControlPorts
    }
    
    required init(nodeID: Int) {
        self.nodeID = nodeID
        self.title = type(of: self).getDefaultTitle()
        self.inDataPorts = type(of: self).getDefaultDataInPorts().map({ nodePortData in
            nodePortData.nodeData = self
            return nodePortData
        })
        self.outDataPorts = type(of: self).getDefaultDataOutPorts().map({ nodePortData in
            nodePortData.nodeData = self
            return nodePortData
        })
        self.inControlPorts = type(of: self).getDefaultControlInPorts().map({ nodePortData in
            nodePortData.nodeData = self
            return nodePortData
        })
        self.outControlPorts = type(of: self).getDefaultControlOutPorts().map({ nodePortData in
            nodePortData.nodeData = self
            return nodePortData
        })
        
        postInit()
    }
    
    func destroy() {
        inPorts.forEach { portData in
            portData.destroy()
        }
        outPorts.forEach { portData in
            portData.destroy()
        }
        inDataPorts.removeAll()
        inControlPorts.removeAll()
        outControlPorts.removeAll()
        outDataPorts.removeAll()
        canvas = nil
    }
    
    func withCanvas(canvasData: NodeCanvasData) -> Self
    {
        self.canvas = canvasData
        return self
    }
    
    func withCanvasPosition(canvasPosition: CGPoint) -> Self
    {
        self.canvasPosition = canvasPosition
        return self
    }
    
    func postInit() {
        
    }
    
    deinit {
        print("\(nodeDescription()) deinit")
    }
}
