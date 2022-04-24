//
//  ChapterSelectionView.swift
//  ScriptNode
//
//  Created by fincher on 4/24/22.
//

import SwiftUI

struct ChapterSelectionView: View {
    @EnvironmentObject var environment : Environment
    @EnvironmentObject var pageManager : PageManager
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(pageManager.pages) { pageProxy in
                Button {
                    pageManager.switchTo(type: pageProxy.type)
                    pageManager.objectWillChange.send()
                } label: {
                    Label {
                        Text("\(pageProxy.type.getTitle())")
                    } icon: {
                        if type(of: PageManager.shared.nodePageData) == pageProxy.type {
                            Image(systemName: "checkmark")
                                .frame(width: 32)
                        } else {
                            ZStack {}
                                .frame(width: 32)
                        }
                    }

                }
                .font(.body.monospaced())

            }
        }
        .background(Color.clear)
        .padding()
    }
}

struct ChapterSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ChapterSelectionView()
    }
}
