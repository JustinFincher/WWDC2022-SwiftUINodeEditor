//
//  NodePageDataChapterZero.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI
import SpriteKit

class NodePageDataChapterZero : NodePageData {
    override func reset() {
        super.reset()
        nodeCanvasData = NodeCanvasData()
        nodeCanvasData.nodes = [
            
        ]
        
        docView = AnyView(
            List {
                Section {
                    Text("👾 How to make games with script node editor")
                        .font(.headline.monospaced())
                    Text("🐦 Chapter 1 - Flappy Bird")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 40)
                        Text("TITLE")
                    }
                }

                
                Section {
                    Button {
                        self.cheat()
                    } label: {
                        Label("See final results 🥳", systemImage: "checkmark")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("")
                }

                
                Section {
                    Button {
                    } label: {
                        Label("Next Chapter", systemImage: "checkmark")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("CONTEXT")
                }


            }
        )
        
        let newScene = SKScene(fileNamed: "FlappyBird") ?? SKScene(size: .init(width: 375, height: 667))
        
        let cityTexture = SKTexture(imageNamed: "background-day")
        cityTexture.filteringMode = .nearest
        let cityNode = SKSpriteNode(texture: cityTexture)
        cityNode.position = .init(x: 0, y: 50.5)
        cityNode.setScale(1.5)
        
        
        let groundTexture = SKTexture(imageNamed: "base")
        groundTexture.filteringMode = .nearest
        let groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.setScale(1.5)
        groundNode.position = .init(x: 0, y: -280)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.size)
        groundNode.physicsBody?.pinned = true
        groundNode.physicsBody?.affectedByGravity = false
        groundNode.physicsBody?.isDynamic = false
        groundNode.physicsBody?.allowsRotation = false
        
        
        
        newScene.addChild(cityNode)
        newScene.addChild(groundNode)
        newScene.scaleMode = .aspectFill
        
        liveScene = newScene
    }
}
