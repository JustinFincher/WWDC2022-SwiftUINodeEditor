//
//  NodePortConnection.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class NodePortConnectionData : ObservableObject, Identifiable, Equatable, Hashable {
    static func == (lhs: NodePortConnectionData, rhs: NodePortConnectionData) -> Bool {
        return lhs.startPort == rhs.startPort
        && lhs.endPort == rhs.endPort
        && lhs.startPosIfPortNull == rhs.startPosIfPortNull
        && lhs.endPosIfPortNull == rhs.endPosIfPortNull
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(startPos)
        hasher.combine(endPos)
    }
    
    weak var startPort : NodePortData? {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var startPosIfPortNull : CGPoint = .zero
    var startPos : CGPoint {
        return startPort?.canvasRect.toCenter() ?? startPosIfPortNull
    }
    weak var endPort : NodePortData?{
        willSet {
            objectWillChange.send()
        }
    }
    @Published var endPosIfPortNull : CGPoint = .zero
    var endPos : CGPoint {
        return endPort?.canvasRect.toCenter() ?? endPosIfPortNull
    }
    
    
    init(startPort: NodePortData?, endPort: NodePortData?) {
        self.startPort = startPort
        self.endPort = endPort
    }
    
    func connect() {
        startPort?.connections.append(self)
        endPort?.connections.append(self)
    }
    
    // get the port that is not connected
    var getPendingPortDirection : NodePortDirection? {
        if startPort == nil {
            return .output
        }
        if endPort == nil {
            return .input
        }
        return nil
    }
    
    func isolate(portDirection : NodePortDirection) {
        if portDirection == .output {
            startPort?.connections.removeAll { connection in
                connection == self
            }
        } else {
            endPort?.connections.removeAll { connection in
                connection == self
            }
        }
    }
    
    func disconnect(portDirection : NodePortDirection) {
        if portDirection == .output {
            startPort = nil
        } else {
            endPort = nil
        }
    }
    
    func disconnect() {
        disconnect(portDirection: .input)
        disconnect(portDirection: .output)
    }
    
    func isolate() {
        isolate(portDirection: .input)
        isolate(portDirection: .output)
    }
    
    var color : Color {
        let port = [startPort, endPort].compactMap { nodePortData in
            nodePortData
        }.first
        return port?.color() ?? .black
    }
}
