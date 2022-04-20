//
//  NodePortView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodePortView: View {
    
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    @ObservedObject var nodePortData : NodePortData
    @State var holdingKnot : Bool = false
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
                            
                            if self.nodePortData.canConnect() {
                                // can connect
                                let newConnection = NodePortConnection()
                                
                                // new connection with basic setup
                                if self.nodePortData.direction == .output {
                                    newConnection.startPort = self.nodePortData
                                } else {
                                    newConnection.endPort = self.nodePortData
                                }
                                nodeCanvasData.pendingConnections.append(newConnection)
                                holdingConnection = newConnection
                            } else if let existingConnection = nodePortData.connections.first {
                                // cannot connect, but if there is an existing line, disconnect that line
                                existingConnection.isolate()
                                existingConnection.disconnect(portDirection: nodePortData.direction)
                                nodeCanvasData.pendingConnections.append(existingConnection)
                                holdingConnection = existingConnection
                            }
                        }
                        
                        if let holdingConnection = holdingConnection,
                           let pendingDirection = holdingConnection.getPendingPortDirection
                        {
                            if pendingDirection == .input {
                                holdingConnection.endPosIfPortNull = value.location
                            } else {
                                holdingConnection.startPosIfPortNull = value.location
                            }
                        }
                    })
                    .onEnded({ value in
                        holdingKnot = false
                        nodeCanvasData.pendingConnections.removeAll { connection in
                            connection == holdingConnection
                        }
                        holdingConnection?.disconnect()
                        holdingConnection = nil
                    })
            )
    }
    
    var body: some View {
        HStack {
            if self.nodePortData.direction == .input {
                circleView
                textView
            } else {
                textView
                circleView
            }
        }
        .padding(self.nodePortData.direction == .output ? .leading : .trailing, 8)
        .animation(.easeInOut, value: holdingKnot)
    }
}

struct NodePortView_Previews: PreviewProvider {
    static var previews: some View {
        NodePortView(nodePortData: NodePortData(portID: 0, direction: .input))
    }
}
