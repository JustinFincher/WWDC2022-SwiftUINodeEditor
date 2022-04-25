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
                    Text("My app, Pegboard, is an interactive canvas with dynamic execution. You can see it as the Shortcuts app or the Workflow app from Apple but packs a whole new node-based user interface that is more flexible and intuitive to use.")
                        .lineLimit(nil)
                    Text("You will see the power of Pegboard as in the app I created several node graphs to drive a simple Flappy Bird game. However, it is worth mentioning that, It is not strictly an editor for developers, rather, the underlying node-based UI framework I wrote with pure SwiftUI can support nearly any type of creative work, like music production, interactive story-telling, automation, educational programming learning experience, etc.")
                        .lineLimit(nil)
                    Text("As mentioned, Pegboard is a pure SwiftUI app, and heavily uses Combine for state management. Pegboard is designed with openness in mind, as you can extend one of the base classes to create a new node with your own desired logic and custom drawing. I fully believe an app like Pegboard will make users feel like at home with their iPads, as pro users can use it to do creative work, while daily users can use it to automate workflows, and students can use it to learn the basis of software / games development.")
                        .lineLimit(nil)
                } header: {
                    Text("Submission")
                }

            }
            .font(.body.monospaced())
            .navigationTitle("More")
        }
        .frame(minWidth: 360, idealWidth: 500, maxWidth: nil,
               minHeight: 360, idealHeight: 540, maxHeight: nil,
               alignment: .top)
    }
}

struct SettingsNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        MoreNavigationView()
    }
}
