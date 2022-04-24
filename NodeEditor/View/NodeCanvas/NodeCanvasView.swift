//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    
    @EnvironmentObject var environment : Environment
    @EnvironmentObject var pageManager : PageManager
    @State var showAddNodePopover : Bool = false
    @State var popoverPosition : CGPoint = .zero
    
    
    var body: some View {
        ZStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView([.horizontal, .vertical]) {
                    ZStack {
                        
                        NodeCanvasAddNodePointView(popoverPosition: $popoverPosition, showPopover: $showAddNodePopover)
                            .position(popoverPosition)
                        
                        Color.clear.frame(width: pageManager.nodePageData.nodeCanvasData.canvasSize.width, height: pageManager.nodePageData.nodeCanvasData.canvasSize.height, alignment: .center)
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
                        
                        ForEach(pageManager.nodePageData.nodeCanvasData.nodes) { nodeData in
                            NodeView(nodeData: nodeData)
                        }
                        
                        Canvas(opaque: false, colorMode: .extendedLinear, rendersAsynchronously: true) { context, size in
                            
                            // stable lines
                            let stablePathForDataFlow = UIBezierPath()
                            pageManager.nodePageData.nodeCanvasData.nodes.flatMap({ nodeData in
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
                            pageManager.nodePageData.nodeCanvasData.nodes.flatMap({ nodeData in
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
                            pageManager.nodePageData.nodeCanvasData.pendingConnections
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
                                
                                
                                if environment.provideConnectionHint {
                                    let pendingDirection = nodePortConnectionData.getPendingPortDirection
                                    let existingPort = pendingDirection == .input ? nodePortConnectionData.startPort : nodePortConnectionData.endPort
                                    let pendingPos = pendingDirection == .input ? endPos : startPos
                                    var portBeneath : NodePortData?
                                    pageManager.nodePageData.nodeCanvasData.nodes.forEach { nodeData in
                                        nodeData.inPorts.forEach { portData in
                                            if portData.canvasRect.contains(pendingPos) {
                                                portBeneath = portData
                                            }
                                        }
                                        nodeData.outPorts.forEach { portData in
                                            if portData.canvasRect.contains(pendingPos) {
                                                portBeneath = portData
                                            }
                                        }
                                    }
                                    if let portBeneath = portBeneath, let existingPort = existingPort {
                                        let bubblePath = Path { path in
                                            path.move(to: pendingPos)
                                            path.addLine(to: pendingPos + .init(x: 30, y: -30))
                                            path.addLine(to: pendingPos + .init(x: 100, y: -30))
                                            path.addLine(to: pendingPos + .init(x: 100, y: -100))
                                            path.addLine(to: pendingPos + .init(x: -100, y: -100))
                                            path.addLine(to: pendingPos + .init(x: -100, y: -30))
                                            path.addLine(to: pendingPos + .init(x: -30, y: -30))
                                        }
                                        switch portBeneath.canConnectTo(anotherPort: existingPort) {
                                        case .can:
                                            context.fill(bubblePath, with: .color(existingPort.color()))
                                            let textPadding = 8.0
                                            context.draw(Text("Release To Connect").font(.footnote.monospaced()), in: .init(origin: .init(x: pendingPos.x - 100 + textPadding, y: pendingPos.y - 100 + textPadding), size: .init(width: 200 - textPadding * 2, height: 70 - textPadding * 2)))
                                            context.stroke(.init(unstablePath.cgPath), with: .color(nodePortConnectionData.color), lineWidth: 4)
                                            break
                                        case .cannot(let reason):
                                            context.fill(bubblePath, with: .color(.red))
                                            let textPadding = 8.0
                                            context.draw(Text("\(reason)").font(.footnote.monospaced()), in: .init(origin: .init(x: pendingPos.x - 100 + textPadding, y: pendingPos.y - 100 + textPadding), size: .init(width: 200 - textPadding * 2, height: 70 - textPadding * 2)))
                                            context.stroke(.init(unstablePath.cgPath), with: .color(.red), lineWidth: 4)
                                            break
                                        }
                                    } else {
                                        context.stroke(.init(unstablePath.cgPath), with: .color(nodePortConnectionData.color), lineWidth: 4)
                                    }
                                } else {
                                    context.stroke(.init(unstablePath.cgPath), with: .color(nodePortConnectionData.color), lineWidth: 4)
                                }
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
                                Text("Node Count \(pageManager.nodePageData.nodeCanvasData.nodes.count)")
                                    .font(.subheadline.monospaced())
                                    .foregroundColor(.init(uiColor: UIColor.secondaryLabel))
                                Text("Pending Connection Count \(pageManager.nodePageData.nodeCanvasData.pendingConnections.count)")
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
