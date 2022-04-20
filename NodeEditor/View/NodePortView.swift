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
            .font(.footnote.monospaced())
    }
    var circleView : some View {
        Circle()
            .frame(width: 8, height: 8, alignment: .center)
            .background(GeometryReader(content: { proxy in
                Color.clear
                    .onChange(of: proxy.frame(in: .named("canvas"))) { portKnotPos in
                        nodePortData.canvasOffset = portKnotPos.toCenter()
                    }
            }))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ value in
                        
                    })
            )
    }
    
    var body: some View {
        HStack {
            if direction == .input {
                circleView
                Spacer()
                textView
            } else {
                textView
                Spacer()
                circleView
            }
        }
    }
}

struct NodePortView_Previews: PreviewProvider {
    static var previews: some View {
        NodePortView(nodePortData: NodePortData(portID: 0))
    }
}
