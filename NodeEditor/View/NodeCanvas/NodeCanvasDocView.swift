//
//  NodeCanvasDocView.swift
//  ScriptNode
//
//  Created by fincher on 4/23/22.
//

import SwiftUI

struct NodeCanvasDocView: View {
    @EnvironmentObject var nodeCanvasData : NodeCanvasData
    
    var body: some View {
        List {
            Text("Doc")
        }
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
