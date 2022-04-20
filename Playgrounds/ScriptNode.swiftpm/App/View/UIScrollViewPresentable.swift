//
//  UIScrollViewPresentable.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import UIKit

import SwiftUI

struct UIScrollViewPresentable<SubView : View> : UIViewRepresentable {
    
    var child : UIView
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleRightMargin, .flexibleTopMargin, .flexibleLeftMargin, .flexibleBottomMargin]
        scrollView.isScrollEnabled = true
        scrollView.maximumZoomScale = 1
        scrollView.minimumZoomScale = 0.2
        
        scrollView.addSubview(child)
        print("child frame \(child.frame)")
        print("scrollView content Size \(scrollView.contentSize)")
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    typealias UIViewType = UIScrollView
    
    
    init(@ViewBuilder content: () -> SubView) {
        self.child = UIHostingController(rootView: content()).view
    }
    
}
