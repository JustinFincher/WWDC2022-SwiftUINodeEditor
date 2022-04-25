//
//  NodePageDataChapterOne.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI
import SpriteKit

class NodePageDataProviderChapterOne : NodePageDataProvider
{
    func modifyCanvas(nodePageData : NodePageData) {
        nodePageData.nodeCanvasData.nodes = [
            GetTouchNode(nodeID: 0).withCanvasPosition(canvasPosition: .init(x: 120, y: 180)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            BirdNode(nodeID: 1).withCanvasPosition(canvasPosition: .init(x: 80, y: 360)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            ApplyImpulseNode(nodeID: 2).withCanvasPosition(canvasPosition: .init(x: 400, y: 200)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            VectorNode(nodeID: 3).withCanvasPosition(canvasPosition: .init(x: 250, y: 480)).withCanvas(canvasData: nodePageData.nodeCanvasData)
        ]
    }
    
    func modifyDocView(nodePageData : NodePageData) {
        nodePageData.docView = AnyView(
            List {
                Section {
                    Text("👾 How to make games with Pegboard")
                        .font(.title2.monospaced())
                    Text("🐦 Chapter 1 - Bird Logic")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section {
                    Text("🤗 Let's use Pegboard to build a game, shall we?")
                        .font(.footnote.monospaced())
                    Text("💡 I have provided you with 4 nodes, they are:\n\t-☝️ Get Touch, an event node that will fire upon tapping on the live game view\n\t-☄️ Apply Force, an operator node that will push the given object with a force\n\t-🏹 Vector, a variable node that provides the value of force in direction and strength\n\t-🐦 Bird, an actor node representing our bird showing on the live game view")
                        .font(.footnote.monospaced())
                    Text("🧐 There is no need to add new nodes, as these four nodes are sufficient enough to make the little bird jump when the player taps the game view. The only question is how do you actually do it?")
                        .font(.footnote.monospaced())
                } header: {
                    Text("MAKE THE BIRD FLY")
                }

                
                Section {
                    Text("🎯 If you got stuck or just want to see how Pegboard works, feel free to click the button below and tap on the bird to see the result!")
                        .font(.footnote.monospaced())
                    Button {
                        self.cheat(nodePageData: nodePageData)
                    } label: {
                        Label("See final results 🥳", systemImage: "checkmark")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("TAP TAP TAP")
                }

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 0)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
                            .font(.body.monospaced())
                    }
                    
                    Button {
                        nodePageData.switchTo(index: 2)
                    } label: {
                        Label("Next Chapter", systemImage: "arrow.right")
                            .font(.body.bold().monospaced())
                    }
                } header: {
                    Text("CONTEXT")
                }


            }
        )
    }
    
    func modifyLiveScene(nodePageData : NodePageData) {
        let newScene = SKScene(fileNamed: "FlappyBird") ?? SKScene(size: .init(width: 375, height: 667))
        
        let birdAtlas = SKTextureAtlas(dictionary: ["downflap": UIImage(named: "yellowbird-downflap.png") as Any,
                                                    "midflap": UIImage(named: "yellowbird-midflap.png") as Any,
                                                    "upflap": UIImage(named: "yellowbird-upflap.png") as Any])
        
        let birdFlyFrames: [SKTexture] = [
            birdAtlas.textureNamed("downflap"),
            birdAtlas.textureNamed("midflap"),
            birdAtlas.textureNamed("upflap")
        ]
        birdFlyFrames.forEach { texture in
            texture.filteringMode = .nearest
        }
        nodePageData.bird = SKSpriteNode(texture: birdFlyFrames[0])
        nodePageData.bird.position = .zero
        nodePageData.bird.run(SKAction.repeatForever(
            SKAction.animate(with: birdFlyFrames,
                             timePerFrame: 0.4,
                             resize: false,
                             restore: true)),
                 withKey:"birdFlyAtlas")
        nodePageData.bird.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 20))
        nodePageData.bird.physicsBody?.allowsRotation = false
        nodePageData.bird.physicsBody?.mass = 0.2
        
        
        let cityTexture = SKTexture(imageNamed: "background-day")
        cityTexture.filteringMode = .nearest
        let cityNode = SKSpriteNode(texture: cityTexture)
        cityNode.position = .init(x: 0, y: 50.5)
        
        
        let groundTexture = SKTexture(imageNamed: "base")
        groundTexture.filteringMode = .nearest
        let groundNode = SKSpriteNode(texture: groundTexture)
        groundNode.position = .init(x: 0, y: -240)
        groundNode.physicsBody = SKPhysicsBody(rectangleOf: groundNode.size)
        groundNode.physicsBody?.pinned = true
        groundNode.physicsBody?.affectedByGravity = false
        groundNode.physicsBody?.isDynamic = false
        groundNode.physicsBody?.allowsRotation = false
        
        
        newScene.addChild(cityNode)
        newScene.addChild(groundNode)
        newScene.addChild(nodePageData.bird)
        newScene.scaleMode = .aspectFill
        
        nodePageData.liveScene = newScene
        EnvironmentManager.shared.environment.toggleLivePanel = true
    }
    
    func cheat(nodePageData : NodePageData) {
        destroy(nodePageData: nodePageData)
        modifyCanvas(nodePageData: nodePageData)
        modifyDocView(nodePageData: nodePageData)
        modifyLiveScene(nodePageData: nodePageData)
                
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 0]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 2]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 1]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 2]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 3]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 2]?.inDataPorts[safe: 1] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 3]?.outDataPorts[safe: 0] as? CGVectorNodeDataPort {
            port1.value = CGVector(dx: 0, dy: 80)
        }

    }
    
    func destroy(nodePageData : NodePageData) {
        nodePageData.pipe.removeFromParent()
        nodePageData.bird.removeFromParent()
        nodePageData.liveScene.removeAllChildren()
        nodePageData.nodeCanvasData.destroy()
    }
}
