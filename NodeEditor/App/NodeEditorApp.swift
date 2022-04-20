//
//  ShaderNodeEditorApp.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/16/22.
//

import SwiftUI

@main
struct NodeEditorApp: App {
    var body: some Scene {
        WindowGroup {
            NodeCanvasNavigationView()
                .environmentObject(EnvironmentManager.shared.environment)
        }
    }
}
