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
                    Text("👾 How to make games with Pegboard")
                        .font(.title2.monospaced())
                    Text("🐦 Chapter 2 - Infinte Pipes")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }

                Section {
                    Text("🤗 Think that was fun? Now we are talking!")
                        .font(.footnote.monospaced())
                    Text("🔂 Seems we got pipes incoming in our way! However, there is currently only one pair of pipes, so you need to 'resue' pipes after they passed behind the bird by looping them back to the right side.")
                        .font(.footnote.monospaced())
                    Text("💡 I have provided a special node called 🎞 Rendered Frame, it will fire each time the game view is refreshed, so that is 30 times per second (just like what you get with Update() on Unity engine). Think how you can use it to examine the current position of the pipe, offset the position to the left, and loop the position back to right when needed!")
                        .font(.footnote.monospaced())
                } header: {
                    Text("ONE OR INFINITE?")
                }
                
                Section {
                    Text("💯 Again, you can always click on the button to reveal the answer!")
                        .font(.footnote.monospaced())
                    Button {
                        self.cheat(nodePageData: nodePageData)
                    } label: {
                        Label("See final results 🥳", systemImage: "checkmark")
                            .font(.body.monospaced())
                    }
                } header: {
                    Text("SCROLLING PIPES")
                }

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 1)
                    } label: {
                        Label("Previous Chapter", systemImage: "arrow.left")
                            .font(.body.monospaced())
                    }
                    
                    Button {
                        nodePageData.switchTo(index: 3)
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
            node.canvasPosition = node.canvasPosition + CGPoint(x: 1000, y: 0)
        }
        
        nodePageData.nodeCanvasData.nodes.append(contentsOf: [
            PipeNode(nodeID: 4).withCanvasPosition(canvasPosition: .init(x: 166, y: 717)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            NewFrameNode(nodeID: 5).withCanvasPosition(canvasPosition: .init(x: 160, y: 221)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            GetPositionNode(nodeID: 6).withCanvasPosition(canvasPosition: .init(x: 190, y: 479)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            SetPositionNode(nodeID: 7).withCanvasPosition(canvasPosition: .init(x: 705, y: 752)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            AddFloatNode(nodeID: 8).withCanvasPosition(canvasPosition: .init(x: 512, y: 190)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            LoopFloatNode(nodeID: 9).withCanvasPosition(canvasPosition: .init(x: 619, y: 460)).withCanvas(canvasData: nodePageData.nodeCanvasData),
        ])
    }
    
    func cheat(nodePageData: NodePageData) {
        destroy(nodePageData: nodePageData)
        modifyCanvas(nodePageData: nodePageData)
        modifyDocView(nodePageData: nodePageData)
        modifyLiveScene(nodePageData: nodePageData)
                
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
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 9]?.outDataPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inDataPorts[safe: 1] {
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
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 9]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 7]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        
        if let node1 = nodePageData.nodeCanvasData.nodes[safe: 8] as? AddFloatNode {
            node1.addition = -1.5
        }
        if let node2 = nodePageData.nodeCanvasData.nodes[safe: 9] as? LoopFloatNode {
            node2.min = -120
            node2.max = 120
        }
    }
    
    func destroy(nodePageData : NodePageData) {
        nodePageData.pipe.removeFromParent()
        nodePageData.bird.removeFromParent()
        nodePageData.liveScene.removeAllChildren()
        nodePageData.nodeCanvasData.destroy()
    }
}
