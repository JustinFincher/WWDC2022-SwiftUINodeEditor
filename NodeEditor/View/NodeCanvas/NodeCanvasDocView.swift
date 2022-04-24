//
//  NodeCanvasDocView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI

struct NodeCanvasDocView: View {
    @EnvironmentObject var pageManager : PageManager
    
    var body: some View {
        pageManager.nodePageData.docView()
               .frame(minWidth: 250,
                      idealWidth: 350,
                      maxWidth: .infinity,
               alignment: .top)
        
    }
}

struct NodeCanvasDocView_Previews: PreviewProvider {
    static var previews: some View {
        NodeCanvasDocView()
    }
}
