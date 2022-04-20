//
//  NodeCanvasToolbarView.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/19/22.
//

import SwiftUI

struct NodeCanvasToolbarView: View {
    var body: some View {
        ZStack (alignment: .bottom) {
            
            HStack(alignment: .center, spacing: 18) {

                Button {

                } label: {
                    Image(systemName: "square.3.stack.3d.top.filled")
                }

                Button {

                } label: {
                    Image(systemName: "stop.fill")
                }

                Button {

                } label: {
                    Image(systemName: "play.fill")
                }

                Button {

                } label: {
                    Image(systemName: "rectangle.righthalf.inset.filled")
                }

                Divider()

                Button {

                } label: {
                    Image(systemName: "ellipsis")
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
