//
//  NodePortView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodePortView: View {
    
    @State var direction : NodePortDirection = .input
    @State var holdingKnot : Bool = false
    @ObservedObject var nodePortData : NodePortData
    @State var holdingConnection : NodePortConnection? = nil
    
    var textView : some View {
        Text("\(nodePortData.name)")
            .lineLimit(1)
            .font(.footnote.monospaced().weight(holdingKnot ? .heavy : .regular))
    }
    
    var circleView : some View {
        Circle()
            .scaleEffect(holdingKnot ? 1.5 : 1)
            .frame(width: 8, height: 8, alignment: .center)
            .padding(.all, 8)
            .background(GeometryReader(content: { proxy in
                Color.clear
                    .onAppear {
                        nodePortData.canvasRect = proxy.frame(in: .named("canvas"))
                    }
                    .onChange(of: proxy.frame(in: .named("canvas"))) { portKnotFrame in
                        nodePortData.canvasRect = portKnotFrame
                    }
            }))
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .named("canvas"))
                    .onChanged({ value in
                        if !holdingKnot {
                            holdingKnot = true
                            
                            let newConnection = NodePortConnection()
                            if direction == .input {
                                newConnection.startPort = self.nodePortData
                            } else {
                                newConnection.endPort = self.nodePortData
                            }
                            holdingConnection = newConnection
                            self.nodePortData.connections.append(newConnection)
                        }
                        
                        if let holdingConnection = holdingConnection {
                            if direction == .input {
                                holdingConnection.endPosIfPortNull = value.location
                            } else {
                                holdingConnection.startPosIfPortNull = value.location
                            }
                        }
                    })
                    .onEnded({ value in
                        holdingKnot = false
                        self.nodePortData.connections.removeAll { connection in
                            connection == holdingConnection
                        }
                        holdingConnection = nil
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
        }
        .padding(direction == .output ? .leading : .trailing, 8)
        .animation(.easeInOut, value: holdingKnot)
    }
}

struct NodePortView_Previews: PreviewProvider {
    static var previews: some View {
        NodePortView(nodePortData: NodePortData(portID: 0))
    }
}
