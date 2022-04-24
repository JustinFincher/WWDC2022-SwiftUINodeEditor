//
//  GetTouchNode.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import Combine

class GetTouchNode : NodeData {
    
    var anyCancellable : AnyCancellable?
    
    override func postInit() {
        super.postInit()
        anyCancellable = NotificationCenter.default.publisher(for: Notification.Name(rawValue: "liveViewTapped"))
            .sink { notification in
                self.perform()
            }
    }
    
    override class func getDefaultCategory() -> String {
        "Event"
    }
    
    class override func getDefaultTitle() -> String {
        "Get Touch"
    }
    
    override class func getDefaultPerformImplementation() -> ((NodeData) -> ()) {
        return { nodeData in
            nodeData.outControlPorts[safe: 0]?.connections[safe: 0]?.endPort?.nodeData?.perform()
        }
    }
    
    override class func getDefaultControlOutPorts() -> [NodeControlPortData] {
        return [
            NodeControlPortData(portID: 0, name: "", direction: .output)
        ]
    }
}
