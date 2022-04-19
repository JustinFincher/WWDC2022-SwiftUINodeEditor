//
//  NodeData.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import UIKit

class NodeData : ObservableObject {
    
    @Published var canvasPos = CGPoint.zero
    @Published var title = ""
    @Published var inPorts : [Int] = [0]
    @Published var outPorts : [Int] = [0, 1]
}
