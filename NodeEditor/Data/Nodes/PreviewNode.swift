//
//  PreviewNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI
import Foundation

class PreviewNode : NodeData {
    
    class override func getDefaultTitle() -> String {
        "Preview"
    }
    
    class override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Object", direction: .input)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            ZStack {
              Text("Empty")
                .font(.body.monospaced())
            }.frame(minWidth: 200, minHeight: 200, alignment: .center)
        )
    }
}
