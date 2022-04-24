//
//  VectorNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SwiftUI

class VectorNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Variable"
    }
    
    class override func getDefaultTitle() -> String {
        "Vector"
    }
    
    class override func getDefaultDataOutPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, direction: .output, name: "Result", defaultValue: CGVector.zero)
        ]
    }
    
    override class func getDefaultCustomRendering(node: NodeData) -> AnyView? {
        AnyView(
            HStack {
                if let port = node.outDataPorts[safe: 0],
                   let portValue = port.value as? CGVector {
                    VStack {
                        Slider(value: .init(get: {
                            portValue.dx
                        }, set: { newX in
                            port.value = CGVector(dx: newX, dy: portValue.dy)
                        }), in: -100...100) {
                            Text("X")
                        } onEditingChanged: { editing in
                            print("\(String(describing: port.value))")
                        }

                        Slider(value: .init(get: {
                            portValue.dy
                        }, set: { newY in
                            port.value = CGVector(dx: portValue.dx, dy: newY)
                        }), in: -100...100) {
                            Text("Y")
                        } onEditingChanged: { editing in
                            print("\(String(describing: port.value))")
                        }
                    }
                    .font(.body.monospaced())
                }
            }.frame(minWidth: 100, maxWidth: 140, alignment: .center)
        )
    }
}


