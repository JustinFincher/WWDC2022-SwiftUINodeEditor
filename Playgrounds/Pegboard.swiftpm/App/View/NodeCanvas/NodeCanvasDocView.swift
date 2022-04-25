//
//  NodeCanvasDocView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI

struct NodeCanvasDocView: View {
    @EnvironmentObject var nodePageData : NodePageData
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    
    var body: some View {
        nodePageData.docView
               .frame(minWidth: 220,
                      idealWidth: 320,
                      maxWidth: .infinity,
               alignment: .top)
        
    }
}

struct NodeCanvasDocView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasDocView()
    }
}
