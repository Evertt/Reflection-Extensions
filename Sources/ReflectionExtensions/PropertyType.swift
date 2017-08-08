@testable import Reflection

public struct PropertyType {
    public let key: String
    public let type: Any.Type
    public let realKey: String
    
    public let isLazy     : Bool
    public let isEnum     : Bool
    public let isTuple    : Bool
    public let isClass    : Bool
    public let isStruct   : Bool
    public let isFunction : Bool
    public let isOptional : Bool
    
    init(key: String, type: Any.Type) {
        realKey = key
        
        if key.matches(regex: "^.+\\.storage$"),
        let type = type as? OptionalType.Type {
            isLazy = true
            self.key = key.replacing(pattern: "^(.+?)(\\.storage)?$", with: "$1")
            (isOptional, self.type) = unwrapOptional(type.wrappedType)
        } else {
            isLazy = false
            self.key = realKey
            (isOptional, self.type) = unwrapOptional(type)
        }
        
        isEnum     = kind(self.type, is: .enum)
        isTuple    = kind(self.type, is: .tuple)
        isClass    = kind(self.type, is: .class)
        isStruct   = kind(self.type, is: .struct)
        isFunction = kind(self.type, is: .function)
    }
}
