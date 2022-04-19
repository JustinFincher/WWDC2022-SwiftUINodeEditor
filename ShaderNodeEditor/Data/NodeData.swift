//
//  NodeData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import UIKit

enum NodePortDirection {
    case input
    case output
}

class NodePortData : ObservableObject, Identifiable {
    @Published var portID : Int
    @Published var name = ""
    @Published var canvasOffset = CGPoint.zero
    @Published var connections : [NodePortData] = []
    
    init(portID: Int) {
        self.portID = portID
    }
    
    init(portID: Int, name: String) {
        self.portID = portID
        self.name = name
    }
}

protocol NodeProtocol : ObservableObject {
    func getDefaultTitle() -> String
    func getDefaultInPorts() -> [NodePortData]
    func getDefaultOutPorts() -> [NodePortData]
}

class NodeData : NodeProtocol {
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
    @Published var inPorts : [NodePortData] = []
    @Published var outPorts : [NodePortData] = []
    
    init(nodeID: Int) {
        self.nodeID = nodeID
        self.title = getDefaultTitle()
        self.inPorts = getDefaultInPorts()
        self.outPorts = getDefaultOutPorts()
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
