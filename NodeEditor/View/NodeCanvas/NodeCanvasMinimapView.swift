//
//  NodeCanvasMinimapView.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct NodeCanvasMinimapView: View {
    
    @EnvironmentObject var pageManager : PageManager
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            VStack {
                Color.clear
                    .aspectRatio(pageManager.nodePageData.nodeCanvasData.canvasSize, contentMode: .fit)
                Divider()
                Text("MINIMAP")
                    .font(.caption2.monospaced())
            }
            .background(
                Material.thin
            )
            .mask(RoundedRectangle(cornerRadius: 12))
            .frame(width: 100)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 0)
            .padding()
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

struct NodeCanvasMinimapView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasMinimapView()
    }
}
