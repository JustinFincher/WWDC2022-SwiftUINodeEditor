//
//  NodeCanvasView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import SwiftUI
import UIKit

struct NodeCanvasView: View {
    var body: some View {
        ZStack {
            ScrollView([.horizontal, .vertical]) {
                ZStack {
                    NodeView()
                    NodeView()
                    Color.clear.frame(width: 1200, height: 1200, alignment: .center)
                }
                .clipped()
                .background(GeometryReader(content: { proxy in
                    Text("Proxy \(proxy.size.width) \(proxy.size.height)")
                }))
            }
            
        }
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
