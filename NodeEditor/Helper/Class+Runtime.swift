import Foundation

public func subclasses<T>(of theClass: T) -> [T] {
    let classPtr = address(of: theClass)
    
    var result: [T] = []
    let classCount = objc_getClassList(nil, 0)
    let classes = UnsafeMutablePointer<AnyClass?>.allocate(capacity: Int(classCount))

    let releasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classes)
    let numClasses: Int32 = objc_getClassList(releasingClasses, classCount)
    for n : Int in 0 ..< Int(numClasses) {
        if let someClass: AnyClass = classes[n]
        {
            guard let someSuperClass = class_getSuperclass(someClass), address(of: someSuperClass) == classPtr else { continue }
            result.append(someClass as! T)
        }
    }

    return result
}

public func address(of object: Any?) -> UnsafeMutableRawPointer{
    return Unmanaged.passUnretained(object as AnyObject).toOpaque()
}


//String+Identifiable

extension String: Identifiable {
    public typealias ID = Int
    public var id: Int {
        return hash
    }
}
