//
//  NodeCanvasLiveView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI
import SpriteKit

struct NodeCanvasLiveView: View {
    @EnvironmentObject var pageManager : PageManager
    
    var body: some View {
        SpriteViewWrapper(scene: $pageManager.nodePageData.liveScene, paused: .init(get: {
            !pageManager.nodePageData.playing
        }, set: { newValue in
            pageManager.nodePageData.playing = !newValue
        }))
        .onTapGesture {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "liveViewTapped"), object: nil)
        }
            .frame(minWidth: 350,
                   idealWidth: 400,
                   maxWidth: .infinity,
               alignment: .top)
        
    }
}

struct NodeCanvasLiveView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasLiveView()
    }
}
