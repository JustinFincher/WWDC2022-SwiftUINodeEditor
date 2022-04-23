//
//  IntNode.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import Foundation
import SwiftUI

class IntNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Variable"
    }
    
    class override func getDefaultTitle() -> String {
        "Int"
    }
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            IntNodeDataPort(portID: 0, name: "Result", direction: .output)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            HStack {
                if let port = node.outDataPorts[safe: 0],
                   let portValue = port.value as? Int {
                    Button {
                        port.value = portValue - 1
                    } label: {
                        Image(systemName: "minus")
                    }

                    Text("\(portValue)")
                        .font(.body.monospaced())
                        .frame(maxWidth: .infinity)
                    
                    Button {
                        port.value = portValue + 1
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }.frame(minWidth: 50, maxWidth: 100, alignment: .center)
        )
    }
}
