//
//  NodePageDataChapterTwo.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//


import Foundation
import SwiftUI
import SpriteKit

class NodePageDataProviderChapterTwo : NodePageDataProvider
{
    func modifyDocView(nodePageData: NodePageData) {
        nodePageData.docView = AnyView(
            List {
                Section {
                    Text("👾 How to make games with script node editor")
                        .font(.headline.monospaced())
                    Text("🐦 Chapter 2 - Infinte Pipes")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 40)
                        Text("TITLE")
                    }
                }

                
                Section {
                    Button {
                        self.cheat(nodePageData: nodePageData)
                    } label: {
                        Label("See final results 🥳", systemImage: "checkmark")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("")
                }

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 1)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
                            .font(.body.monospaced())
                    }
                    
                    Button {
                    } label: {
                        Label("Next Chapter", systemImage: "arrow.right")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("CONTEXT")
                }

            }
        )
    }
    
    func modifyLiveScene(nodePageData: NodePageData) {
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
                             timePerFrame: 0.2,
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
        
        
        let pipeTexture = SKTexture(imageNamed: "pipe-green")
        pipeTexture.filteringMode = .nearest
        let pipeNodeTop = SKSpriteNode(texture: pipeTexture)
        pipeNodeTop.setScale(1.5)
        pipeNodeTop.position = .init(x: 0, y: -280)
        pipeNodeTop.physicsBody = SKPhysicsBody(rectangleOf: pipeNodeTop.size)
        pipeNodeTop.physicsBody?.pinned = true
        pipeNodeTop.physicsBody?.affectedByGravity = false
        pipeNodeTop.physicsBody?.isDynamic = false
        pipeNodeTop.physicsBody?.allowsRotation = false
        let pipeNodeBottom = SKSpriteNode(texture: pipeTexture)
        pipeNodeBottom.zRotation = .pi
        pipeNodeBottom.setScale(1.5)
        pipeNodeBottom.position = .init(x: 0, y: 400)
        pipeNodeBottom.physicsBody = SKPhysicsBody(rectangleOf: pipeNodeBottom.size)
        pipeNodeBottom.physicsBody?.pinned = true
        pipeNodeBottom.physicsBody?.affectedByGravity = false
        pipeNodeBottom.physicsBody?.isDynamic = false
        pipeNodeBottom.physicsBody?.allowsRotation = false
        let pipeNode = SKNode()
        pipeNode.addChild(pipeNodeTop)
        pipeNode.addChild(pipeNodeBottom)
        
        
        newScene.addChild(cityNode)
        newScene.addChild(pipeNode)
        newScene.addChild(groundNode)
        newScene.addChild(nodePageData.bird)
        newScene.scaleMode = .aspectFill
        
        nodePageData.liveScene = newScene
    }
    
    
    func modifyCanvas(nodePageData : NodePageData) {
        nodePageData.nodeCanvasData.nodes = [
            GetTouchNode(nodeID: 0).withCanvasPosition(canvasPosition: .init(x: 120, y: 180)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            BirdNode(nodeID: 1).withCanvasPosition(canvasPosition: .init(x: 80, y: 360)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            ApplyImpulseNode(nodeID: 2).withCanvasPosition(canvasPosition: .init(x: 400, y: 200)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            VectorNode(nodeID: 3).withCanvasPosition(canvasPosition: .init(x: 250, y: 480)).withCanvas(canvasData: nodePageData.nodeCanvasData)
        ]
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
        nodePageData.nodeCanvasData.nodes.forEach { node in
            node.canvasPosition = node.canvasPosition + CGPoint(x: 500, y: 0)
        }
        
        nodePageData.nodeCanvasData.nodes.append(contentsOf: [
            NewFrameNode(nodeID: 4).withCanvasPosition(canvasPosition: .init(x: 160, y: 150)).withCanvas(canvasData: nodePageData.nodeCanvasData)
        ])
    }
    
    func cheat(nodePageData: NodePageData) {
        
    }
    
    func destroy(nodePageData : NodePageData) {
        nodePageData.pipe.removeFromParent()
        nodePageData.bird.removeFromParent()
        nodePageData.liveScene.removeAllChildren()
        nodePageData.nodeCanvasData.destroy()
    }
}
