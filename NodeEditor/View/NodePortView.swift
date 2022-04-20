//
//  NodePortView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodePortView: View {
    
    @State var direction : NodePortDirection = .input
    @ObservedObject var nodePortData : NodePortData
    
    var textView : some View {
        Text("\(nodePortData.name)")
            .lineLimit(1)
            .font(.footnote.monospaced())
    }
    var circleView : some View {
        Circle()
            .padding(.all, 8)
            .frame(width: 24, height: 24, alignment: .center)
            .background(GeometryReader(content: { proxy in
                Color.clear
                    .onAppear {
                        nodePortData.canvasOffset = proxy.frame(in: .named("canvas")).toCenter()
                    }
                    .onChange(of: proxy.frame(in: .named("canvas"))) { portKnotPos in
                        nodePortData.canvasOffset = portKnotPos.toCenter()
                    }
            }))
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named("canvas"))
                    .onChanged({ value in
                        
                    })
                    .onEnded({ value in
                        
                    })
            )
    }
    
    var body: some View {
        HStack {
            if direction == .input {
                circleView
                textView
            } else {
                textView
                circleView
            }
        }.padding(direction == .output ? .leading : .trailing, 8)
    }
}

struct NodePortView_Previews: PreviewProvider {
    static var previews: some View {
        NodePortView(nodePortData: NodePortData(portID: 0))
    }
}
