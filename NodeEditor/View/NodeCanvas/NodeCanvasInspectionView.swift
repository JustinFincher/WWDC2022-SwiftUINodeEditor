//
//  NodeCanvasInspectionView.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct NodeCanvasInspectionView: View {
    
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    
    var body: some View {
        NavigationView {
            List {
                Section("Property") {
                    
                }
                Section("Preview") {
                    
                }
            }
            .navigationTitle("Inspector")
        }
        .frame(minWidth: 260, idealWidth: 380, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
        
    }
}

struct NodeCanvasInspectionView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasInspectionView()
    }
}
