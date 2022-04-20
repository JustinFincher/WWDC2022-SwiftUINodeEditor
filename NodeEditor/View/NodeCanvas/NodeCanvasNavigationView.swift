//
//  NodeCanvasNavigationView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI

struct NodeCanvasNavigationView: View {
    @ObservedObject var nodeCanvasData : NodeCanvasData = NodeCanvasData().withTestConfig()
    @EnvironmentObject var environment : Environment
    
    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            if environment.toggleNodeListPanel {
                NodeCanvasHierarchyView()
                    .mask(RoundedRectangle(cornerRadius: 16).ignoresSafeArea())
                    .layoutPriority(0.4)
            }
            NodeCanvasView()
                .mask(RoundedRectangle(cornerRadius: 16).ignoresSafeArea())
                .layoutPriority(1.0)
            if environment.toggleNodeInspectionPanel {
                NodeCanvasInspectionView()
                    .mask(RoundedRectangle(cornerRadius: 16).ignoresSafeArea())
                    .layoutPriority(0.5)
            }
        }
        .padding(.all, environment.toggleNodeListPanel || environment.toggleNodeInspectionPanel ? 8 : 0)
        .animation(.easeInOut, value: environment.toggleNodeListPanel)
        .animation(.easeInOut, value: environment.toggleNodeInspectionPanel)
        .environmentObject(nodeCanvasData)
        .navigationViewStyle(.stack)
    }
}

struct NodeCanvasNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasNavigationView()
    }
}
