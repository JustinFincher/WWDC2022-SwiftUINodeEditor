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
        guard let port1 = self.inDataPorts[safe: 0],
           let port2 = self.inDataPorts[safe: 1] else {
            return
        }
        
        if let additionInt = port1.value as? Int, let oldValueInt = port2.value as? Int {
            port1.value = oldValueInt + additionInt
        }
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

