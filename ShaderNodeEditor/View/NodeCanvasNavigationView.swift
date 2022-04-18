//
//  NodeCanvasNavigationView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI

struct NodeCanvasNavigationView: View {
    @State var isShowingPopover = false
    var body: some View {
        NavigationView {
            NodeCanvasView()
                .navigationTitle("Editor")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingPopover = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .popover(isPresented: $isShowingPopover) {
                                    Text("Popover Content")
                                        .padding()
                                }
                    }
                }
        }.navigationViewStyle(.stack)
    }
}

struct NodeCanvasNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasNavigationView()
    }
}
