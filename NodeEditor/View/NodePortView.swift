//
//  NodePortView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodePortView: View {
    
    @State var direction : NodePortDirection = .input
    @State var nodePortData : NodePortData
    
    var body: some View {
        HStack {
            if direction == .input {
                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .background(GeometryReader(content: { proxy in
                        Color.clear
                            .onChange(of: proxy.frame(in: .named("canvas"))) { portKnotPos in
//                                nodePortData.canvasOffset = portKnotPos.origin
                            }
                    }))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                
                            })
                    )
                Spacer()
                Text("\(nodePortData.name)")
                    .font(.footnote.monospaced())
            } else {
                Text("\(nodePortData.name)")
                    .font(.footnote.monospaced())
                Spacer()
                Circle()
                    .frame(width: 8, height: 8, alignment: .center)
                    .background(GeometryReader(content: { proxy in
                        Color.clear
                            .onChange(of: proxy.frame(in: .named("canvas"))) { portKnotPos in
//                                nodePortData.canvasOffset = portKnotPos.origin
                            }
                    }))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged({ value in
                                
                            })
                    )
            }
        }
    }
}

struct NodePortView_Previews: PreviewProvider {
    static var previews: some View {
        NodePortView(nodePortData: NodePortData(portID: 0))
    }
}
