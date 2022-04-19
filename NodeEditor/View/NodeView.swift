//
//  NodeView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import SwiftUI
import UIKit

struct NodeView: View {
    
    @State var holding = false
    @State var nodeData : NodeData
    
    
    @State private var savedOffset: CGPoint = .zero
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(nodeData.title)")
                    .font(.title3.monospaced())
                HStack(alignment: .top) {
                    if !nodeData.inPorts.isEmpty {
                        VStack(alignment: .leading) {
                            ForEach(nodeData.inPorts) { nodePortData in
                                NodePortView(direction: .input, nodePortData: nodePortData)
                            }
                        }
                        .padding(.all, 4)
                        .layoutPriority(1)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.mint.opacity(0.6))
                        .mask(RoundedRectangle(cornerRadius: 6))
                    }
                    
                    
                    if !nodeData.outPorts.isEmpty {
                        VStack(alignment: .trailing) {
                            ForEach(nodeData.outPorts) { nodePortData in
                                NodePortView(direction: .output, nodePortData: nodePortData)
                            }
                        }
                        .padding(.all, 4)
                        .layoutPriority(1)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color.indigo.opacity(0.6))
                        .mask(RoundedRectangle(cornerRadius: 6))
                    }
                }
            }
        }
        .padding(.all, 8)
        .frame(width: 200)
        .background(
            Color.clear.background(Material.thin)
        )
        .mask {
            RoundedRectangle(cornerRadius: 8)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.orange, lineWidth: holding ? 4 : 0)
        )
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 0)
        .scaleEffect(1 + (holding ? 0.1 : 0.0))
//        .contextMenu {
//            Text("Test")
//        }
        .position(x: CGFloat(nodeData.canvasOffsetX), y: CGFloat(nodeData.canvasOffsetY))
//        .gesture(DragGesture(minimumDistance: 0)
//            .onChanged { value in
//                if !holding {
//                    savedOffset = nodeData.canvasOffset
//                    holding = true
//                }
//                nodeData.canvasOffset = savedOffset + value.translation.toPoint()
//            }
//            .onEnded { value in
//                nodeData.canvasOffset = savedOffset + value.translation.toPoint()
//                savedOffset = nodeData.canvasOffset
//                holding = false
//            }
//        )
        .animation(.easeInOut, value: holding)
        .animation(.easeInOut, value: nodeData.canvasOffsetX)
        .animation(.easeInOut, value: nodeData.canvasOffsetY)
    }
    
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{}
    }
}
