//
//  NodeCanvasToolbarView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodeCanvasToolbarView: View {
    
    
    @State private var showSettings = false
//    @State private var showNodeList = false
    @EnvironmentObject var environment : Environment
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            HStack(alignment: .center, spacing: 18) {
                
                ToggleButtonView(icon: .init(systemName: "square.stack.3d.up.fill"), state: $environment.toggleNodeListPanel)
                
//                Button {
//                    showNodeList = true
//                } label: {
//                    Image(systemName: "square.3.stack.3d.top.filled")
//                        .padding(.all, 8)
//                }.popover(isPresented: $showNodeList) {
//                    NodeCanvasInspectionView()
//                }

                Button {

                } label: {
                    Image(systemName: "play.fill")
                        .padding(.all, 8)
                }

                ToggleButtonView(icon: .init(systemName:"rectangle.righthalf.inset.filled"), state: $environment.toggleNodeInspectionPanel)

                Divider()

                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "ellipsis")
                        .padding(.all, 8)
                }
                .popover(isPresented: $showSettings) {
                    SettingsNavigationView()
                }
            }
            .padding()
            .frame(height: 64)
            .background(
                Material.regular
            )
            .mask({
                RoundedRectangle(cornerRadius: 32)
            })
            .padding()
            .shadow(color: .black.opacity(0.1), radius: 16, x: 0, y: 0)
            Color.clear
        }
    }
}

struct NodeCanvasToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasToolbarView()
    }
}
