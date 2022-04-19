//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    
    var nodeCanvasData : NodeCanvasData = NodeCanvasData(nodes: [
        IntNode(canvasOffsetX: 500, canvasOffsetY: 200, nodeID: 0)
        
    ])
    
    var body: some View {
        ZStack {
            
            ScrollView([.horizontal, .vertical]) {
                ZStack {
                    
                    Color.clear.frame(width: 1200, height: 1200, alignment: .center)
                    
                    ForEach(nodeCanvasData.nodes) { nodeData in
                        NodeView(nodeData: nodeData)
                    }
                    
                    Canvas(opaque: false, colorMode: .extendedLinear, rendersAsynchronously: true) { context, size in
                        
                        let path = UIBezierPath()
                        path.move(to: .init(x: 0, y: 0))
                        path.addCurve(to: .init(x: 100, y: 100), controlPoint1: .init(x: 100, y: 0), controlPoint2: .init(x: 0, y: 100))
                        
//                        path.move(to: nodeCanvasData.nodes[0].outPorts[0].canvasOffset)
//                        path.addCurve(to: nodeCanvasData.nodes[1].inPorts[0].canvasOffset,
//                                      controlPoint1: .init(x: nodeCanvasData.nodes[1].inPorts[0].canvasOffset.x, y: nodeCanvasData.nodes[0].outPorts[0].canvasOffset.y),
//                                      controlPoint2: .init(x: nodeCanvasData.nodes[0].outPorts[0].canvasOffset.x, y: nodeCanvasData.nodes[1].inPorts[0].canvasOffset.y))
                        context.stroke(.init(path.cgPath), with: .color(.green), lineWidth: 4)
                    }
                    .allowsHitTesting(false)
                    
                }
                .coordinateSpace(name: "canvas")
                .clipped()
                .background(GeometryReader(content: { proxy in
                    ZStack {
                        Text("Canvas Size \(proxy.size.width) \(proxy.size.height)")
                            .font(.subheadline.monospaced())
                            .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                    }
                    .padding()
                }))
            }
            NodeCanvasToolbarView()
            
        }.background(Color(UIColor.secondarySystemBackground))
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
