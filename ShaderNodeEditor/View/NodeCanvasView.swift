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
        ScrollView([.horizontal, .vertical]) {
            Color(UIColor.systemBackground)
                .frame(width: 500, height: 500)
                .overlay(ZStack {
                    Text("Test")
                        .position(x: 100, y: 100)
                    NodeView()
                })
        }
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
