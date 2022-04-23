//
//  AddNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI
import Foundation

class AddNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "Add"
    }
    
    override func perform() {
        guard let inDataPort1 = self.inDataPorts[safe: 0],
           let inDataPort2 = self.inDataPorts[safe: 1],
        let outControlPort1 = self.outControlPorts[safe: 0] else {
            return
        }
        
        if let additionInt = inDataPort1.value as? Int, let oldValueInt = inDataPort2.value as? Int {
            inDataPort1.value = oldValueInt + additionInt
        }
        
        outControlPort1.connections[safe: 0]?.endPort?.nodeData?.perform()
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Value", direction: .input),
            NodeDataPortData(portID: 1, name: "Addition", direction: .input)
        ]
    }
    
    class override func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
}

