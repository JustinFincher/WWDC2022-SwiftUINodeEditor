//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    
    @ObservedObject var nodeCanvasData : NodeCanvasData = NodeCanvasData(nodes: [
        IntNode(nodeID: 0, canvasOffset: .init(x: 500, y: 500)),
        DummyNode(nodeID: 0, canvasOffset: .init(x: 150, y: 200)),
        DummyNode(nodeID: 0, canvasOffset: .init(x: 400, y: 200))
    ])
    
    var body: some View {
        ZStack {
            
            ScrollView([.horizontal, .vertical]) {
                ZStack {
                    Canvas(opaque: false, colorMode: .extendedLinear, rendersAsynchronously: true) { context, size in
                        
                        let path = UIBezierPath()
                        path.move(to: .init(x: 0, y: 0))
                        path.addCurve(to: .init(x: 100, y: 100), controlPoint1: .init(x: 100, y: 0), controlPoint2: .init(x: 0, y: 100))
                        context.stroke(.init(path.cgPath), with: .color(.green), lineWidth: 4)
                    }
                    ForEach(nodeCanvasData.nodes) { nodeData in
                        NodeView(nodeData: nodeData)
                    }
                    Color.clear.frame(width: 1200, height: 1200, alignment: .center)
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
