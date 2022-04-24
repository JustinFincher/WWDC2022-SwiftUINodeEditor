//
//  Environment.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/18/22.
//

import Foundation
import Combine
import SwiftUI

class Environment : ObservableObject {
    
    
    @UserDefault(key: "useContextMenuOnNodes", defaultValue: true)
    var useContextMenuOnNodes: Bool
    @UserDefault(key: "enableBlurEffectOnNodes", defaultValue: true)
    var enableBlurEffectOnNodes: Bool
    @UserDefault(key: "debugMode", defaultValue: false)
    var debugMode: Bool
    @UserDefault(key: "toggleLivePanel", defaultValue: true)
    var toggleLivePanel: Bool
    @UserDefault(key: "toggleDocPanel", defaultValue: true)
    var toggleDocPanel: Bool
    @UserDefault(key: "provideConnectionHint", defaultValue: true)
    var provideConnectionHint: Bool
    
    private var notificationSubscription: AnyCancellable?
    init() {
        notificationSubscription = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification).sink { notif in
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
}
