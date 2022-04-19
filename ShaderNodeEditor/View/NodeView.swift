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
    
    
    @State private var currentOffset: CGSize = .zero
    @State private var savedOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Node Name")
                    .font(.title3.monospaced())
                HStack(alignment: .top) {
                    VStack {
                        HStack {
                            Circle()
                                .frame(width: 8, height: 8, alignment: .center)
                            Text("Input 1")
                                .font(.footnote.monospaced())
                        }
                    }
                    .layoutPriority(1)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.mint.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 6))
                    

                    VStack {
                        HStack {
                            Text("Output 1")
                                .font(.footnote.monospaced())
                            Circle()
                                .frame(width: 8, height: 8, alignment: .center)
                        }
                    }
                    .layoutPriority(1)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color.indigo.opacity(0.6))
                    .mask(RoundedRectangle(cornerRadius: 6))
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
        .offset(x: self.currentOffset.width, y: self.currentOffset.height)
        .gesture(DragGesture(minimumDistance: 0)
            .onChanged { value in
                if !holding {
                    holding = true
                }
                self.currentOffset = value.translation + self.savedOffset
            }
            .onEnded { value in
                self.currentOffset = value.translation + self.savedOffset
                self.savedOffset = self.currentOffset
                holding = false
            }
        )
        .animation(.easeInOut, value: holding)
        .animation(.easeInOut, value: currentOffset)
        .animation(.easeInOut, value: nodeData.canvasPos)
    }
    
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
