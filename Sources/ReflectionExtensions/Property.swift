@testable import Reflection

public struct Property {
    public let key: String
    public let value: Any?
    public let type: Any.Type
    public let realKey: String
    
    public let isLazy        : Bool
    public let isEnum        : Bool
    public let isTuple       : Bool
    public let isClass       : Bool
    public let isStruct      : Bool
    public let isFunction    : Bool
    public let isOptional    : Bool
    public let isInitialized : Bool
    
    init(key: String, value: Any, type: Any.Type) {
        let propertyType = PropertyType(key: key, type: type)
        self.init(value: value, propertyType: propertyType)
    }
    
    init(value: Any, propertyType: PropertyType) {
        key        = propertyType.key
        type       = propertyType.type
        isLazy     = propertyType.isLazy
        isEnum     = propertyType.isEnum
        isTuple    = propertyType.isTuple
        realKey    = propertyType.realKey
        isClass    = propertyType.isClass
        isStruct   = propertyType.isStruct
        isFunction = propertyType.isFunction
        isOptional = propertyType.isOptional
        
        if isLazy {
            if let value = unwrap(value) {
                isInitialized = true
                self.value = unwrap(value)
            } else {
                self.value = nil
                isInitialized = false
            }
        } else {
            isInitialized = true
            self.value = unwrap(value)
        }
    }
}
