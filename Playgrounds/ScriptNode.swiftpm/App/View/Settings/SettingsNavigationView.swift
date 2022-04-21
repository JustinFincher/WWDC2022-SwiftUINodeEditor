//
//  SettingsNavigationView.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct SettingsNavigationView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Test")
            }
            .navigationTitle("Settings")
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
    }
}

struct SettingsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsNavigationView()
    }
}
