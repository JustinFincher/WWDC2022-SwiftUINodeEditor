//
//  ToggleButton.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct ToggleButtonView: View {
    
    @State var icon : Image
    @Binding var state : Bool
    
    var body: some View {
        Button {
            self.state.toggle()
        } label: {
            icon
                .foregroundColor(state ? .init(UIColor.systemBackground) : .accentColor)
                .padding(.all, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(state ? .accentColor : .clear)
                )
                .animation(.easeInOut, value: state)
        }

    }
}

struct ToggleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButtonView(icon: .init(systemName: "rectangle.stack.fill"), state: .constant(true))
    }
}
