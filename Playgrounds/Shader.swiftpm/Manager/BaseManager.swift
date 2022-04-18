//
//  BaseManager.swift
//  ShaderNodeEditor
//
//  Created by fincher on 4/17/22.
//

import Foundation

public class BaseManager : NSObject {
    class var shared : BaseManager {
        return BaseManager()
    }
    
    func setup() -> Void {
        
    }
    
    func destroy() -> Void {
        
    }
}

public func setupAllBaseManagers() -> Void {
    let list = subclasses(of: BaseManager.self)
    list.forEach { (manager) in
        manager.shared.setup()
    }
}


public func destroyAllBaseManagers() -> Void {
    let list = subclasses(of: BaseManager.self)
    list.forEach { (manager) in
        manager.shared.destroy()
    }
}
