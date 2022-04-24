//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    @State var showAddNodePopover : Bool = false
    @State var popoverPosition : CGPoint = .zero
    
    
    var body: some View {
        ZStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView([.horizontal, .vertical]) {
                    ZStack {
                        
                        NodeCanvasAddNodePointView(popoverPosition: $popoverPosition, showPopover: $showAddNodePopover)
                            .position(popoverPosition)
                        
                        Color.clear.frame(width: nodeCanvasData.canvasSize.width, height: nodeCanvasData.canvasSize.height, alignment: .center)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                // https://stackoverflow.com/questions/57700396/adding-a-drag-gesture-in-swiftui-to-a-view-inside-a-scrollview-blocks-the-scroll
                            }
                            .gesture(
                                DragGesture(minimumDistance: 0, coordinateSpace: .named("canvas"))
                                    .onChanged({ value in
                                        if !showAddNodePopover {
                                            showAddNodePopover = true
                                            popoverPosition = value.location
                                        }
                                    })
                                    .onEnded({ value in
                                    })
                            )
                        
                        ForEach(nodeCanvasData.nodes) { nodeData in
                            NodeView(nodeData: nodeData)
                        }
                        
                        Canvas(opaque: false, colorMode: .extendedLinear, rendersAsynchronously: true) { context, size in
                            
                            // stable lines
                            let stablePathForDataFlow = UIBezierPath()
                            nodeCanvasData.nodes.flatMap({ nodeData in
                                nodeData.outDataPorts.flatMap { nodePortData in
                                    nodePortData.connections
                                }
                            })
                            .forEach { nodePortConnectionData in
                                let startPos = nodePortConnectionData.startPos
                                let endPos = nodePortConnectionData.endPos
                                let distance = abs(startPos.x - endPos.x)
                                let controlPoint1 = startPos + CGPoint.init(x: distance, y: 0)
                                let controlPoint2 = endPos - CGPoint.init(x: distance, y: 0)
                                stablePathForDataFlow.move(to: startPos)
                                stablePathForDataFlow.addCurve(to: endPos,
                                              controlPoint1: controlPoint1,
                                              controlPoint2: controlPoint2)
                            }
                            context.stroke(.init(stablePathForDataFlow.cgPath), with: .color(.green), lineWidth: 4)
                            
                            let stablePathForControlFlow = UIBezierPath()
                            nodeCanvasData.nodes.flatMap({ nodeData in
                                nodeData.outControlPorts.flatMap { nodePortData in
                                    nodePortData.connections
                                }
                            })
                            .forEach { nodePortConnectionData in
                                let startPos = nodePortConnectionData.startPos
                                let endPos = nodePortConnectionData.endPos
                                let distance = abs(startPos.x - endPos.x)
                                let controlPoint1 = startPos + CGPoint.init(x: distance, y: 0)
                                let controlPoint2 = endPos - CGPoint.init(x: distance, y: 0)
                                stablePathForControlFlow.move(to: startPos)
                                stablePathForControlFlow.addCurve(to: endPos,
                                              controlPoint1: controlPoint1,
                                              controlPoint2: controlPoint2)
                            }
                            context.stroke(.init(stablePathForControlFlow.cgPath), with: .color(.blue), lineWidth: 4)
                            
                            
                            // pending lines
                            nodeCanvasData.pendingConnections
                            .forEach { nodePortConnectionData in
                                let unstablePath = UIBezierPath()
                                let startPos = nodePortConnectionData.startPos
                                let endPos = nodePortConnectionData.endPos
                                let distance = abs(startPos.x - endPos.x)
                                let controlPoint1 = startPos + CGPoint.init(x: distance, y: 0)
                                let controlPoint2 = endPos - CGPoint.init(x: distance, y: 0)
                                unstablePath.move(to: startPos)
                                unstablePath.addCurve(to: endPos,
                                              controlPoint1: controlPoint1,
                                              controlPoint2: controlPoint2)
                                context.stroke(.init(unstablePath.cgPath), with: .color(nodePortConnectionData.color), lineWidth: 4)
                            }
                            
                        }
                        .allowsHitTesting(false)
                        
                    }
                    .coordinateSpace(name: "canvas")
                    .clipped()
                    .background(GeometryReader(content: { proxy in

                            VStack(alignment: .leading) {
                                Text("Canvas Size \(proxy.size.width) × \(proxy.size.height)")
                                    .font(.subheadline.monospaced())
                                    .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                                Text("Node Count \(nodeCanvasData.nodes.count)")
                                    .font(.subheadline.monospaced())
                                    .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                                Text("Pending Connection Count \(nodeCanvasData.pendingConnections.count)")
                                    .font(.subheadline.monospaced())
                                    .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                            }
                            .padding()
                    }))
                }
            }
            
//            NodeCanvasMinimapView()
        }
        
        .background(Color(UIColor.systemGroupedBackground))
        .frame(minWidth: 300,
               idealWidth: 500,
               maxWidth: .infinity,
           alignment: .top)
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
