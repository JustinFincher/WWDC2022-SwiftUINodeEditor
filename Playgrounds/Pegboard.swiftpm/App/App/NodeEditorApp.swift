//
//  ShaderNodeEditorApp.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/16/22.
//

import SwiftUI

// Welcome to the Pegboard app.
// Pegboard is like the Shortcuts App, but empowered by node-based visual scripting capabilities, so that it can even support real-time logic execution in game development.
// TODO: Please execute the app using the run button rather sideview, as this app is designed to run best on full-screen mode.

@main
struct NodeEditorApp: App {
    var body: some Scene {
        WindowGroup {
            NodeCanvasNavigationView()
                .environmentObject(EnvironmentManager.shared.environment)
        }
    }
}
