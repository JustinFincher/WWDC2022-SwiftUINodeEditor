//
//  NodeCanvasTitleIndicatorView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI

struct NodeCanvasTitleIndicatorView<ChildView: View>: View {
    
    @State var title : String = ""
    @Binding var indicating : Bool
    
    var childView: ChildView
    var body: some View {
        ZStack(alignment: .top) {
            childView
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(indicating ? Color.init(UIColor.quaternaryLabel) : Color.clear, lineWidth: indicating ? 8 : 0))
                .mask(RoundedRectangle(cornerRadius: 16))

            ZStack{
                Text("\(title)")
                    .font(.body.monospaced())
                    .padding()
            }
            .background(Material.thin)
            .frame(height: 32)
            .mask(RoundedRectangle(cornerRadius: 16))
            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 0)
            .opacity(indicating ? 1 : 0)
            .padding(.top, indicating ? 32 : -32)
        }
        .animation(.easeInOut, value: indicating)
    }
}
