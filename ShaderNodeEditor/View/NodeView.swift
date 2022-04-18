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
    @ObservedObject var nodeData = NodeData()
    
    var body: some View {
        VStack {
            Text("Test")
                .foregroundColor(Color(UIColor.label))
            Text("Test")
                .foregroundColor(Color(UIColor.label))
            Text("Test")
                .foregroundColor(Color(UIColor.label))
            Text("Test")
                .foregroundColor(Color(UIColor.label))
            Text("Test")
                .foregroundColor(Color(UIColor.label))
        }
        .padding()
        .frame(width: 120)
        .background(
            Color(UIColor.secondarySystemBackground)
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
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged({ value in
                    holding = true
                    nodeData.canvasPosX = value.location.x
                    nodeData.canvasPosY = value.location.y
                    print("\(nodeData.canvasPosX) \(nodeData.canvasPosY)")
                }).onEnded({ value in
                    holding = false
                    
                })
        )
        .scaleEffect(1 + (holding ? 0.2 : 0.0))
        .position(x: nodeData.canvasPosX, y: nodeData.canvasPosY)
        .animation(.easeInOut, value: holding)
        .animation(.easeInOut, value: nodeData.canvasPosX)
        .animation(.easeInOut, value: nodeData.canvasPosY)
    }
    
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
