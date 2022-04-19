//
//  NodeCanvasData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation

class NodeCanvasData : ObservableObject {
    @Published var nodes : [NodeData] = []
    
    init(nodes : [NodeData]) {
        self.nodes = nodes
    }
}
