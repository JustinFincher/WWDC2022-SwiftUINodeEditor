//
//  NodeView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import SwiftUI
import UIKit

struct NodeView: View {
    
    @State var holding = false
    @State var nodeData = NodeData()
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
        }.mask {
            RoundedRectangle(cornerRadius: 8)
                .frame(width: 120, height: 180, alignment: .center)
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({ value in
                    holding = true
                    
                }).onEnded({ value in
                    holding = false
                    
                })
        )
        .scaleEffect(1 + (holding ? 0.2 : 0.0))
        .animation(.easeInOut, value: holding)
    }
    
}

struct NodeView_Previews: PreviewProvider {
    static var previews: some View {
        NodeView()
    }
}
