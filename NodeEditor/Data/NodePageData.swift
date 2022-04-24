//
//  NodePageData.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import Foundation
import SwiftUI
import Combine
import SpriteKit

class NodePageData : ObservableObject
{
    @ObservedObject var nodeCanvasData : NodeCanvasData
    @Published var docView : AnyView
    @Published var liveScene : SKScene
    @Published var playing : Bool = false {
        didSet {
            liveScene.isPaused = !playing
        }
    }
    var bird : SKSpriteNode
    
    required init() {
        nodeCanvasData = NodeCanvasData().withTestConfig3()
        docView = AnyView(List{})
        liveScene = SKScene(fileNamed: "FlappyBird") ?? SKScene()
        
        let birdAtlas = SKTextureAtlas(named: "YelloBird.atlas")
        let birdFlyFrames: [SKTexture] = [
          birdAtlas.textureNamed("yellowbird-downflap"),
          birdAtlas.textureNamed("yellowbird-midflap"),
          birdAtlas.textureNamed("yellowbird-upflap")
        ]
        bird = SKSpriteNode(texture: birdFlyFrames[0])
        bird.run(SKAction.repeatForever(
            SKAction.animate(with: birdFlyFrames,
                             timePerFrame: 0.2,
                             resize: false,
                             restore: true)),
            withKey:"birdFlyAtlas")
        bird.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 20))
        bird.physicsBody?.mass = 0.2
        liveScene.addChild(bird)
        
        liveScene.scaleMode = .aspectFill
        liveScene.isPaused = !playing
        
//        bird.physicsBody?.applyForce(T##force: CGVector##CGVector)
    }
}
