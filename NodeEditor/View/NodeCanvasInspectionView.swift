//
//  NodeListView.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct NodePortInspectionView: View {

    @StateObject var nodePort : NodePortData
    
    var body: some View {
        List {
            Section("Can Connect") {
                Text("\(nodePort.canConnect() ? "YES" : "NO")")
                    .font(.body.monospaced())
            }
            Section("Direction") {
                Text("\(nodePort.direction.rawValue)")
                    .font(.body.monospaced())
            }
            Section("Connection") {
                ForEach(nodePort.connections, id: \.self) {connection in
                    Text("\(connection.startPort?.portID ?? -1) - \(connection.endPort?.portID ?? -1)")
                        .font(.body.monospaced())
                }
            }
        }
        .navigationTitle("\(nodePort.portID) \(nodePort.name)")

    }
}


struct NodeInspectionView: View {

    @StateObject var node : NodeData
    
    var body: some View {
        List {
            Section("In Ports") {
                ForEach(node.inPorts, id: \.self) {port in
                    NavigationLink {
                        NodePortInspectionView(nodePort: port)
                    } label: {
                        Text("\(port.portID) \(port.name)")
                            .font(.body.monospaced())
                    }

                }
            }
            
            Section("Out Ports") {
                ForEach(node.outPorts, id: \.self) {port in
                    NavigationLink {
                        NodePortInspectionView(nodePort: port)
                    } label: {
                        Text("\(port.portID) \(port.name)")
                            .font(.body.monospaced())
                    }
                }
            }
        }
        .navigationTitle("\(node.nodeID) \(node.title)")

    }
}

struct NodeCanvasInspectionView: View {
    
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(nodeCanvasData.nodes, id: \.self) { node in
                    NavigationLink {
                        NodeInspectionView(node: node)
                    } label: {
                        Text("\(node.nodeID) \(node.title)")
                            .font(.body.monospaced())
                    }

                }
                .onMove(perform: move)
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle("Nodes In Canvas")
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        nodeCanvasData.nodes.move(fromOffsets: source, toOffset: destination)
    }
}

struct NodeListView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasInspectionView()
    }
}
