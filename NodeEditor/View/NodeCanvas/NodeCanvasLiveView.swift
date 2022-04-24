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
        SpriteView(scene: nodePageData.liveScene)
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
