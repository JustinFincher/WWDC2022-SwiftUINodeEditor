//
//  NodePortView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodePortView: View {
    
    @EnvironmentObject var pageManager : PageManager
    @ObservedObject var nodePortData : NodePortData
    @State var holdingKnot : Bool = false
    @State var holdingConnection : NodePortConnectionData? = nil
    
    var textView : some View {
        Text("\(nodePortData.name)")
            .lineLimit(1)
            .font(.footnote.monospaced())
    }
    
    var circleView : some View {
        nodePortData.icon()
            .foregroundColor(nodePortData.color())
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
                            
                            if case .can = nodePortData.canConnect() {
                                // can connect
                                let newConnection : NodePortConnectionData
                                
                                // new connection with basic setup
                                if self.nodePortData.direction == .output {
                                    newConnection = NodePortConnectionData(startPort: self.nodePortData, endPort: nil)
                                } else {
                                    newConnection = NodePortConnectionData(startPort: nil, endPort: self.nodePortData)
                                }
                                pageManager.nodePageData.nodeCanvasData.pendingConnections.append(newConnection)
                                holdingConnection = newConnection
                            } else if let existingConnection = nodePortData.connections.first {
                                // cannot connect, but if there is an existing line, disconnect that line
                                existingConnection.isolate()
                                existingConnection.disconnect(portDirection: nodePortData.direction)
                                pageManager.nodePageData.nodeCanvasData.pendingConnections.append(existingConnection)
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
                        
                        if let pendingDirection = holdingConnection?.getPendingPortDirection,
                           let portToConnectTo = pageManager.nodePageData.nodeCanvasData.nodes.flatMap({ nodeData in
                               pendingDirection == .input ? nodeData.inPorts : nodeData.outPorts
                           }).filter({ nodePortData in
                               if case .can = nodePortData.canConnectTo(anotherPort: self.nodePortData) {
                                   return true
                               }
                               return false
                           }).filter({ nodePortData in
                               nodePortData.canvasRect.contains(value.location)
                           }).first {
                            // if knot can be connected
                            portToConnectTo.connectTo(anotherPort: self.nodePortData)
                            
                        } else {
                            
                            // if no knot to connect to
                            holdingConnection?.disconnect()
                        }
                        
                        // remove pending connection
                        pageManager.nodePageData.nodeCanvasData.pendingConnections.removeAll { connection in
                            connection == holdingConnection
                        }
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
        NodePortView(nodePortData: NodeDataPortData(portID: 0, direction: .input))
    }
}
