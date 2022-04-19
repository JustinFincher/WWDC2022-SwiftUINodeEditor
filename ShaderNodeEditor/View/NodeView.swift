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
    @State var holdingPosition = CGPoint.zero
    @ObservedObject var nodeData = NodeData()
    
    var body: some View {
        VStack {
            Text("Node")
                .foregroundColor(Color(UIColor.label))
            Text("Node")
                    .foregroundColor(Color(UIColor.label))
        }
        .padding()
        .frame(width: 120)
        .background(
            GeometryReader(content: { proxy in
                Color(UIColor.secondarySystemBackground)
            })
        )
        .mask {
            RoundedRectangle(cornerRadius: 8)
        }
//        .overlay(
//            RoundedRectangle(cornerRadius: 8)
//                .stroke(lineWidth: 4)
//        )
        .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 0)
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    if (holding == false) {
                        holdingPosition = nodeData.canvasPos
                    }
                    holding = true
                    nodeData.canvasPos = holdingPosition + (value.location - value.startLocation)
                    print("\(nodeData.canvasPos)")
                }).onEnded({ value in
                    holding = false
                    
                })
        )
        .scaleEffect(1 + (holding ? 0.2 : 0.0))
        .contextMenu(menuItems: {
            Button {
                print("Delete Clicked")
            } label: {
                Label("Delete", systemImage: "xmark")
            }
            Divider()
            Text("Coordinates")
                .contextMenu {
//                    Text("Size \(parentProxy.size.width), \(parentProxy.size.height)")
//                    Text("Local +X \(parentProxy.frame(in: .local).maxX)")
//                    Text("Local +Y \(parentProxy.frame(in: .local).maxY)")
//                    Text("Global +/X \(parentProxy.frame(in: .global).maxX)")
//                    Text("Global +Y \(parentProxy.frame(in: .global).maxY)")
                }
        })
        .position(nodeData.canvasPos)
        .animation(.easeInOut, value: holding)
        .animation(.easeInOut, value: nodeData.canvasPos)
    }
    
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
