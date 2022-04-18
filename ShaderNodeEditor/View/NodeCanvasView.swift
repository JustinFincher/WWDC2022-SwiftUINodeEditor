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
            ZStack {
                Text("Test")
                NodeView()
            }
            .frame(width: 1000, height: 1000, alignment: .center)
            .background(Color.red)
        }
    }
}

struct NodeCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasView()
    }
}
