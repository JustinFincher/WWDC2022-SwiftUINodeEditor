//
//  PlayAudioNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation

class PlayAudioNode : NodeData {
    
    override class func getDefaultCategory() -> String {
        "Operator"
    }
    
    class override func getDefaultTitle() -> String {
        "PlayAudio"
    }
    
    override class func getDefaultControlInPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .input)
        ]
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
    
    override class func getDefaultDataInPorts() -> [NodeDataPortData] {
        return [
            NodeDataPortData(portID: 0, name: "Audio", direction: .input)
        ]
    }
}
