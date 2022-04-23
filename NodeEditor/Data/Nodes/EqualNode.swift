//
//  ComparsionNode.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import Foundation
class ComparsionNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Comparsion"
    }
    
    override func perform() {
        if let inDataPort1Value = self.inDataPorts[safe: 0]?.value as? Int,
           let inDataPort2Value = self.inDataPorts[safe: 1]?.value as? Int,
           let outControlPort1 = self.outControlPorts[safe: 0],
           let outControlPort2 = self.outControlPorts[safe: 1],
           let outControlPort3 = self.outControlPorts[safe: 2] {
            if inDataPort1Value == inDataPort2Value {
                outControlPort2.connections[safe: 0]?.endPort?.nodeData?.perform()
            }
            if inDataPort1Value > inDataPort2Value {
                outControlPort1.connections[safe: 0]?.endPort?.nodeData?.perform()
            }
            if inDataPort1Value < inDataPort2Value {
                outControlPort3.connections[safe: 0]?.endPort?.nodeData?.perform()
            }
        }
    }
    
    class override func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "First", direction: .input),
            NodeDataPortData(portID: 1, name: "Second", direction: .input)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: ">", direction: .output),
            NodeControlPortData(portID: 1, name: "=", direction: .output),
            NodeControlPortData(portID: 2, name: "<", direction: .output)
        ]
    }
}
