//
//  NodePageDataChapterThree.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//


import Foundation
import SwiftUI
import SpriteKit

class NodePageDataProviderChapterThree : NodePageDataProvider
{
    func modifyDocView(nodePageData: NodePageData) {
        nodePageData.docView = AnyView(
            List {
                Section {
                    Text("👾 How to make games with Pegboard")
                        .font(.title2.monospaced())
                    Text("🏵 Chapter 3 - Full-on Flappy Bird")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }

                Section {
                    Text("🙃 OK I know this will be too much, so I am doing it myself this time! All the nodes are already working, just enjoy playing it!")
                        .font(.footnote.monospaced())
                    Text("👀 What you are seeing is the full potential of Pegboard for game dev on an iPad, it is fully interactive, not a single line of code to the user side, and fun to use (just drag and drop).")
                        .font(.footnote.monospaced())
                } header: {
                    Text("NODES RULE IT ALL")
                }
                
                Section {
                    Text("🎉 Thank you for using Pegboard! Hope this one will get you interested into the game development and the world of ode-editor based programming!")
                        .font(.footnote.monospaced())
                    
                    Text("🎉 And remember, Pegboard is more than just a game development framework as demostrated here. It can be used in music production, Shortcuts-like automation, visual story-telling, and much much more. The framework is capable of doing all that, and the only limitation is the user.")
                        .font(.footnote.monospaced())
                } header: {
                    Text("BYE!")
                }

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 2)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
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
                             timePerFrame: 0.4,
                             resize: false,
                             restore: true)),
                 withKey:"birdFlyAtlas")
        nodePageData.bird.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 30, height: 20))
        nodePageData.bird.physicsBody?.allowsRotation = false
        nodePageData.bird.physicsBody?.mass = 0.2
//        nodePageData.bird.constraints = [SKConstraint.positionX(SKRange(constantValue: 0))]
        
        
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
        
        
        let pipeTexture = SKTexture(imageNamed: "pipe-green")
        pipeTexture.filteringMode = .nearest
        let pipeNodeTop = SKSpriteNode(texture: pipeTexture)
        pipeNodeTop.position = .init(x: 0, y: -200)
        pipeNodeTop.physicsBody = SKPhysicsBody(rectangleOf: pipeNodeTop.size)
        pipeNodeTop.physicsBody?.pinned = true
        pipeNodeTop.physicsBody?.affectedByGravity = false
        pipeNodeTop.physicsBody?.isDynamic = false
        pipeNodeTop.physicsBody?.allowsRotation = false
        let pipeNodeBottom = SKSpriteNode(texture: pipeTexture)
        pipeNodeBottom.zRotation = .pi
        pipeNodeBottom.position = .init(x: 0, y: 300)
        pipeNodeBottom.physicsBody = SKPhysicsBody(rectangleOf: pipeNodeBottom.size)
        pipeNodeBottom.physicsBody?.pinned = true
        pipeNodeBottom.physicsBody?.affectedByGravity = false
        pipeNodeBottom.physicsBody?.isDynamic = false
        pipeNodeBottom.physicsBody?.allowsRotation = false
        nodePageData.pipe = SKNode()
        nodePageData.pipe.addChild(pipeNodeTop)
        nodePageData.pipe.addChild(pipeNodeBottom)
        nodePageData.pipe.position = .init(x: 0, y: 0)
        nodePageData.pipe.physicsBody = nil
        
        
        newScene.addChild(cityNode)
        newScene.addChild(nodePageData.pipe)
        newScene.addChild(groundNode)
        newScene.addChild(nodePageData.bird)
        newScene.scaleMode = .aspectFill
        
        nodePageData.liveScene = newScene
        EnvironmentManager.shared.environment.toggleLivePanel = true
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
            node.canvasPosition = node.canvasPosition + CGPoint(x: 1020, y: 900)
        }
        
        nodePageData.nodeCanvasData.nodes.append(contentsOf: [
            PipeNode(nodeID: 4).withCanvasPosition(canvasPosition: .init(x: 166, y: 717)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            NewFrameNode(nodeID: 5).withCanvasPosition(canvasPosition: .init(x: 160, y: 221)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            GetPositionNode(nodeID: 6).withCanvasPosition(canvasPosition: .init(x: 190, y: 479)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            SetPositionNode(nodeID: 7).withCanvasPosition(canvasPosition: .init(x: 1440, y: 752)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            AddFloatNode(nodeID: 8).withCanvasPosition(canvasPosition: .init(x: 512, y: 190)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            ComparsionNode(nodeID: 9).withCanvasPosition(canvasPosition: .init(x: 767, y: 240)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            AddFloatNode(nodeID: 10).withCanvasPosition(canvasPosition: .init(x: 1030, y: 200)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            SetFloatNode(nodeID: 11).withCanvasPosition(canvasPosition: .init(x: 1453, y: 410)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            RandomNode(nodeID: 12).withCanvasPosition(canvasPosition: .init(x: 1290, y: 190)).withCanvas(canvasData: nodePageData.nodeCanvasData),
        ])
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 4]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 6]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 4]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 8]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 9]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 1], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inDataPorts[safe: 2] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 5]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 6]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 8]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 8]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 9]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let node1 = nodePageData.nodeCanvasData.nodes[safe: 8] as? AddFloatNode {
            node1.addition = -1.5
        }
        if let node1 = nodePageData.nodeCanvasData.nodes[safe: 9] as? ComparsionNode {
            node1.comparsionTo = -100
        }
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 9]?.outControlPorts[safe: 2], let port2 = nodePageData.nodeCanvasData.nodes[safe: 10]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 9]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 9]?.outControlPorts[safe: 1], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 10]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let node1 = nodePageData.nodeCanvasData.nodes[safe: 10] as? AddFloatNode {
            node1.addition = 200
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inDataPorts[safe: 1] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 10]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 12]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 12]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 11]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 12]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 11]?.inDataPorts[safe: 1] {
            port1.connectTo(anotherPort: port2)
        }
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 6]?.outDataPorts[safe: 1], let port2 = nodePageData.nodeCanvasData.nodes[safe: 11]?.inDataPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 11]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        
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
