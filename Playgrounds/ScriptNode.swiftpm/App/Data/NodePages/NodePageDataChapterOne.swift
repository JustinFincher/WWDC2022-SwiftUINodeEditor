//
//  NodePageDataChapterOne.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI
import SpriteKit
 
class NodePageDataChapterOne : NodePageData {
    
    override func reset() {
        super.reset()
        nodeCanvasData = NodeCanvasData()
        nodeCanvasData.nodes = [
            GetTouchNode(nodeID: 0).withCanvasPosition(canvasPosition: .init(x: 180, y: 180)),
            BirdNode(nodeID: 1).withCanvasPosition(canvasPosition: .init(x: 180, y: 360)),
            ApplyImpulseNode(nodeID: 2).withCanvasPosition(canvasPosition: .init(x: 600, y: 200)),
            VectorNode(nodeID: 3).withCanvasPosition(canvasPosition: .init(x: 400, y: 400))
        ]
        
        docView = AnyView(
            List {
                Text("Doc")
            }
        )
        
        let newScene = SKScene(fileNamed: "FlappyBird") ?? SKScene()
        let birdAtlas = SKTextureAtlas(named: "YelloBird.atlas")
        let birdFlyFrames: [SKTexture] = [
          birdAtlas.textureNamed("yellowbird-downflap"),
          birdAtlas.textureNamed("yellowbird-midflap"),
          birdAtlas.textureNamed("yellowbird-upflap")
        ]
        bird = SKSpriteNode(texture: birdFlyFrames[0])
        bird.position = .zero
        bird.run(SKAction.repeatForever(
            SKAction.animate(with: birdFlyFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: true)),
            withKey:"birdFlyAtlas")
        bird.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 20))
        bird.physicsBody?.mass = 0.2
        newScene.addChild(bird)
        newScene.scaleMode = .aspectFill
        
        liveScene = newScene
        
    }
}
