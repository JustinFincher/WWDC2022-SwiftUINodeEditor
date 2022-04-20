//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    
    @ObservedObject var nodeCanvasData : NodeCanvasData = NodeCanvasData().withTestConfig()
    
    var body: some View {
        ZStack {
            ScrollView([.horizontal, .vertical]) {
                ZStack {
                    
                    Color.clear.frame(width: nodeCanvasData.canvasSize.width, height: nodeCanvasData.canvasSize.height, alignment: .center)
                    
                    ForEach(nodeCanvasData.nodes) { nodeData in
                        NodeView(nodeData: nodeData)
                    }
                    
                    Canvas(opaque: false, colorMode: .extendedLinear, rendersAsynchronously: true) { context, size in
                        
                        
                        Set(nodeCanvasData.nodes.flatMap { nodeData in
                            [nodeData.inPorts, nodeData.outPorts].flatMap { ports in
                                ports.flatMap { ports in
                                    ports.connections
                                }
                            }
                        }).forEach { nodePortConnectionData in
                            let path = UIBezierPath()
                            let startPos = nodePortConnectionData.startPos
                            let endPos = nodePortConnectionData.endPos
                            let distance = abs(startPos.x - endPos.x)
                            let controlPoint1 = startPos + CGPoint.init(x: distance, y: 0)
                            let controlPoint2 = endPos - CGPoint.init(x: distance, y: 0)

                            path.move(to: startPos)
                            path.addCurve(to: endPos,
                                          controlPoint1: controlPoint1,
                                          controlPoint2: controlPoint2)
                            
                            var colors : [Color] = []
                            if nodePortConnectionData.getPendingPortDirection == .output {
                                colors.append(Color.yellow)
                                colors.append(Color.green)
                            } else if nodePortConnectionData.getPendingPortDirection == .input {
                                colors.append(Color.green)
                                colors.append(Color.yellow)
                            } else {
                                colors.append(Color.green)
                            }
                            context.stroke(.init(path.cgPath), with: .linearGradient(.init(colors: colors), startPoint: startPos, endPoint: endPos), lineWidth: 4)
                        }
                        
                        
                    }
                    .allowsHitTesting(false)
                    
                }
                .coordinateSpace(name: "canvas")
                .clipped()
                .background(GeometryReader(content: { proxy in
                    ZStack {
                        Text("Canvas Size \(proxy.size.width) × \(proxy.size.height)")
                            .font(.subheadline.monospaced())
                            .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                    }
                    .padding()
                }))
            }
            NodeCanvasToolbarView()
            
        }
        .background(Color(UIColor.systemGroupedBackground))
        .environmentObject(nodeCanvasData)
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
