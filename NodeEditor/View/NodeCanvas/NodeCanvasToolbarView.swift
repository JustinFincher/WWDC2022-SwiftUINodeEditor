//
//  NodeCanvasToolbarView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodeCanvasToolbarView: View {
    
    
    @State private var showSettings = false
    @EnvironmentObject var nodePageData : NodePageData
    @EnvironmentObject var environment : Environment
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            HStack(alignment: .center, spacing: 18) {
                
                ToggleButtonView(icon: .init(systemName: "square.stack.3d.up.fill"), state: $environment.toggleNodeListPanel)

                Button {
                    nodePageData.playing.toggle()
                } label: {
                    Image(systemName: nodePageData.playing ? "pause.fill" : "play.fill")
                        .padding(.all, 8)
                }
                
                Button {

                } label: {
                    Image(systemName: "stop.fill")
                        .padding(.all, 8)
                }
                .disabled(!nodePageData.playing)
                
                ToggleButtonView(icon: .init(systemName:"rectangle.lefthalf.inset.filled"), state: $environment.toggleDocPanel)
                ToggleButtonView(icon: .init(systemName:"rectangle.righthalf.inset.filled"), state: $environment.toggleLivePanel)

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
