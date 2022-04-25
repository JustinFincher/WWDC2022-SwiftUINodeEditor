//
//  NodePageDataChapterZero.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import Foundation
import SwiftUI
import SpriteKit

class NodePageDataProviderChapterZero : NodePageDataProvider
{
    func modifyCanvas(nodePageData : NodePageData) {
        nodePageData.nodeCanvasData.nodes = [
            TriggerNode(nodeID: 0).withCanvasPosition(canvasPosition: .init(x: 188, y: 228)).withCanvas(canvasData: nodePageData.nodeCanvasData),
            PrintNode(nodeID: 1).withCanvasPosition(canvasPosition: .init(x: 286, y: 530)).withCanvas(canvasData: nodePageData.nodeCanvasData),
        ]
        if let port1 = nodePageData.nodeCanvasData.nodes[safe: 0]?.outControlPorts[safe: 0], let port2 = nodePageData.nodeCanvasData.nodes[safe: 1]?.inControlPorts[safe: 0] {
            port1.connectTo(anotherPort: port2)
        }
        if let node1 = nodePageData.nodeCanvasData.nodes[safe: 1] as? PrintNode {
            node1.content = "Hello World!"
        }
    }
    
    func modifyDocView(nodePageData : NodePageData) {
        nodePageData.docView = AnyView(
            List {
                Section {
                    Text("👾 How to make games with script node editor")
                        .font(.title2.monospaced())
                    Text("🖇 Chapter 0 - Node Editor?")
                        .font(.subheadline.monospaced())
                } header: {
                    VStack(alignment: .leading) {
                        Color.clear.frame(height: 20)
                        Text("TITLE")
                    }
                }
                
                Section {
                    Text("🤯 Node Editor is a common UI pattern used in visual programming, game dev, and low-code programming environments.")
                        .font(.footnote.monospaced())
                    
                    Text("💡 A node represents a piece of logic block that can be chained together with other nodes via connection lines. The whole node graph, if composed in a well-orgainzed fashion, can greatly visualize the underlying logic. If feels right at home when you combine it with an iPad Pro.")
                        .font(.footnote.monospaced())
                } header: {
                    Text("A CRASH COURSE")
                }
                
                Section {
                    Text("📱 I have implemented a simple node editor as your can see at the right hand side. Try drag the two nodes around, connect and disconnect the in/out ports on nodes, and click buttons to see if the console prints the value defined by the print node! (Remember to turn on console logs if you are using Swift Playground)")
                        .font(.footnote.monospaced())
                    
                } header: {
                    Text("DO IT YOURSELF")
                }

                
                Section {
                    Text("🔍 You can long press on the blank area of canvas to add new nodes to the graph, some of these new nodes will be very important in the next chapter!")
                        .font(.footnote.monospaced())
                    Text("🎮 For now, just play around with the node editor I built and get familiar with it, then, click the 'Next Chapter' button below to learn how to build a little game.")
                        .font(.footnote.monospaced())
                    
                } header: {
                    Text("LOOK AROUND")
                }

                
                Section {
                    Button {
                        nodePageData.switchTo(index: 1)
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
        newScene.scaleMode = .aspectFill
        
        nodePageData.liveScene = newScene
        EnvironmentManager.shared.environment.toggleLivePanel = false
    }
    
    func cheat(nodePageData : NodePageData) {
        
    }
    
    func destroy(nodePageData : NodePageData) {
        nodePageData.liveScene.removeAllChildren()
        nodePageData.nodeCanvasData.destroy()
    }
}
