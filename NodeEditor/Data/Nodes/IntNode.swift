//
//  IntNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation
import CoreGraphics

struct IntNode : NodeData {
    var id: UUID = UUID()
    
    static func == (lhs: IntNode, rhs: IntNode) -> Bool {
        return lhs.title == rhs.title
        && lhs.nodeID == rhs.nodeID
        && lhs.canvasOffsetX == rhs.canvasOffsetX
        && lhs.canvasOffsetY == rhs.canvasOffsetY
        && lhs.inPorts == rhs.inPorts
        && lhs.outPorts == rhs.outPorts
    }
    
    
    
    var canvasOffsetX: Float = 0
    var canvasOffsetY: Float = 0
    
    var nodeID: Int
    
    var title: String = getDefaultTitle()
    
    var inPorts: [NodePortData] = getDefaultInPorts()
    
    var outPorts: [NodePortData] = getDefaultOutPorts()
    
    
    static func getDefaultTitle() -> String {
        "Int"
    }
    
    static func getDefaultInPorts() -> [NodePortData] {
        return []
    }
    
    static func getDefaultOutPorts() -> [NodePortData] {
        return [
            NodePortData(portID: 0, name: "Result")
        ]
    }
    
}
