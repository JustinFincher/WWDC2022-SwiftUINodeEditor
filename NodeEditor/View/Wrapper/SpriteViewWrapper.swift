//
//  SpriteViewWrapper.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SpriteKit
import SwiftUI

struct SpriteViewWrapper : UIViewRepresentable {
    
    @Binding var scene: SKScene
    @Binding var paused: Bool
    
    func updateUIView(_ uiView: SKView, context: Context) {
        uiView.presentScene(nil)
        uiView.setNeedsDisplay()
        uiView.setNeedsLayout()
        uiView.presentScene(scene)
        uiView.setNeedsDisplay()
        uiView.setNeedsLayout()
        uiView.isPaused = paused
    }
    
    func makeUIView(context: Context) -> SKView{
        let view = SKView()
        view.isAsynchronous = true
        view.showsFPS = true
        view.showsDrawCount = true
        view.showsPhysics = true
        
        return view
    }
}
