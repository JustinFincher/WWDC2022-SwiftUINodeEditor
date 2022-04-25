//
//  SettingsNavigationView.swift
//  ScriptNode
//
//  Created by fincher on 4/20/22.
//

import SwiftUI

struct MoreNavigationView: View {
    
    @EnvironmentObject var environment : Environment
    
    var body: some View {
        NavigationView {
            List {
                Section(content: {
                    Toggle("Use Context Menu On Nodes", isOn: $environment.useContextMenuOnNodes)
                    Toggle("Provide Hint On Node Connections", isOn: $environment.provideConnectionHint)
                    Toggle("Blurry Node Background", isOn: $environment.enableBlurEffectOnNodes)
                    Toggle("Debug Mode", isOn: $environment.debugMode)
                }, header: {
                    Text("Settings")
                })
                
                Section {
                    Link("Haotian Zheng's Website", destination: URL(string: "https://haotianzheng.com")!)
                    Text("Haotian Zheng is currently a student in Carnegie Mellon University. He likes coding, photography, video-gaming, and driving.")
                } header: {
                    Text("About")
                }
                
                Section {
                    
                } header: {
                    Text("Submission")
                }

            }
            .font(.body.monospaced())
            .navigationTitle("More")
        }
        .frame(minWidth: 200, idealWidth: 300, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
    }
}

struct SettingsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MoreNavigationView()
    }
}
