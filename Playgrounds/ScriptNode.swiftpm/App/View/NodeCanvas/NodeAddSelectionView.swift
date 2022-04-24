//
//  NodeAddView.swift
//  ScriptNode
//
//  Created by fincher on 4/21/22.
//

import SwiftUI

struct NodeCanvasAddNodePointView : View {
    @Binding var popoverPosition : CGPoint
    @Binding var showPopover : Bool
    
    var body: some View {
        Color.clear.frame(width: 1, height: 1, alignment: .center)
            .popover(isPresented: $showPopover, attachmentAnchor: .point(.zero)) {
                NodeAddSelectionView(showPopover: $showPopover, nodePosition: $popoverPosition)
            }
    }
}

struct NodeAddSelectionView: View {
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    @Binding var showPopover : Bool
    @Binding var nodePosition : CGPoint
    @State private var nodeCategory : String = ""
    
    var nodeCategoryToTypeDict : [String: [NodeData]] {
        let categoryToType = Dictionary(grouping: subclasses(of: NodeData.self)
            .filter { nodeType in
                nodeType.self.getDefaultExposedToUser()
            }, by: { $0.getDefaultCategory() })
        
        let categoryToInstance = Dictionary(uniqueKeysWithValues:
                                                categoryToType.map { key, value in (key, value.enumerated().map({ (index, nodeType) in
            nodeType.init(nodeID: index)
        })) })
        
        return categoryToInstance
    }
    
    var nodeCategoryList : [String] {
        nodeCategoryToTypeDict.keys.sorted()
    }
    
    func nodeListFor(category: String) -> [NodeData] {
        return nodeCategoryToTypeDict[category] ?? []
    }
    
    var body: some View {
        NavigationView {
            List{
                ForEach(nodeListFor(category: nodeCategory)) { nodeData in
                    Button {
                        showPopover = false
                        _ = nodeCanvasData.addNode(newNodeType: type(of: nodeData), position: nodePosition)
                    } label: {
                        HStack {
                            Text("\(nodeData.title)")
                                .font(.body.monospaced())
                            Spacer()
                            NodeView(demoMode: true, nodeData: nodeData)
                                .padding()
                        }
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())

                }
            }
            .listStyle(PlainListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Category", selection: $nodeCategory) {
                        ForEach(nodeCategoryList) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("\(nodeCategory)")
        }
        .frame(minWidth: 300, idealWidth: 380, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
    }
}
