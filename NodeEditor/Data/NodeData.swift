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

struct NodePortData : Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    
    var portID : Int
    var name = ""
    var canvasOffsetX = 0.0
    var canvasOffsetY = 0.0
    var connections : [NodePortData] = []
    
    init(portID: Int) {
        self.portID = portID
    }
    
    init(portID: Int, name: String) {
        self.portID = portID
        self.name = name
    }
}

protocol NodeData : Identifiable, Hashable, Equatable {
    
    var canvasOffsetX : Float { get set }
    var canvasOffsetY : Float { get set }
    var nodeID : Int { get }
    var title: String { get }
    var inPorts : [NodePortData] { get }
    var outPorts : [NodePortData] { get }
}
