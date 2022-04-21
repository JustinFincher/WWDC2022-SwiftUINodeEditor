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
        hasher.combine(inPorts)
        hasher.combine(outPorts)
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
