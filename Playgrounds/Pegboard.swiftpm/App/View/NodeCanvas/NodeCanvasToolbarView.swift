//
//  NodeCanvasToolbarView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodeCanvasToolbarView: View {
    
    
    @State private var showSettings = false
    @State private var showResetAlert = false
    @State private var showReadingProgress = false
    @EnvironmentObject var nodePageData : NodePageData
    @EnvironmentObject var environment : Environment
    
    var body: some View {
        ZStack (alignment: .bottom) {
            
            HStack(alignment: .center, spacing: 18) {
                
//                Button {
//                    showReadingProgress = true
//                } label: {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text("Currently Reading \(Image(systemName: "chevron.up"))")
//                                .font(.subheadline.monospaced())
//                        }
//                        Text("Chapter 1")
//                            .font(.caption.monospaced())
//                    }.padding(.horizontal, 8)
//                }
//                .popover(isPresented: $showReadingProgress) {
//                    Text("")
//                }
                
//                Divider()
                
                Button {
                    showResetAlert = true
                } label: {
                    Image(systemName: "memories")
                        .padding(.all, 8)
                }
                .alert("Reset?", isPresented: $showResetAlert, actions: {
                    Button(role: .destructive) {
                        nodePageData.reset()
                    } label: {
                        Text("Confirm")
                    }
                    Button(role: .cancel) {
                        showResetAlert = false
                    } label: {
                        Text("Cancel")
                    }
                    
                }, message: {
                    Text("The live scene and the editor node graph will be reset to its initial state")
                })
//                Button {
//                    if nodePageData.playing {
//                        nodePageData.playing = false
//                        nodePageData.reset()
//                    } else {
//                        nodePageData.playing = true
//                    }
//                } label: {
//                    Image(systemName: nodePageData.playing ? "stop.fill" : "play.fill")
//                        .padding(.all, 8)
//                }
//
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
                    MoreNavigationView()
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
