//
//  NodeCanvasLiveView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI
import SpriteKit

struct NodeCanvasLiveView: View {
    @EnvironmentObject var nodePageData : NodePageData
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    
    var body: some View {
        SpriteViewWrapper(scene: $nodePageData.liveScene, paused: .init(get: {
            !nodePageData.playing
        }, set: { newValue in
            nodePageData.playing = !newValue
        }))
        .onTapGesture {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "liveViewTapped"), object: nil)
        }
            .frame(minWidth: 280,
                   idealWidth: 360,
                   maxWidth: .infinity,
               alignment: .top)
        
    }
}

struct NodeCanvasLiveView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasLiveView()
    }
}
