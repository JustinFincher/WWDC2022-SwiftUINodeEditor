//
//  TriggerNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI
import Foundation

class TriggerNode : NodeData {
    
    
    class override func getDefaultTitle() -> String {
        "Trigger"
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultCustomRendering() -> AnyView? {
        AnyView(
            ZStack {
                Button {
                    
                } label: {
                    Text("Click To Trigger")
                        .font(.body.monospaced())
                }

            }.frame(minWidth: 100, minHeight: 100, alignment: .center)
        )
    }
}
