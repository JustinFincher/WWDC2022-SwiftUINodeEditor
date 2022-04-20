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
        NodeCanvasView()
            .navigationViewStyle(.stack)
    }
}

struct NodeCanvasNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasNavigationView()
    }
}
