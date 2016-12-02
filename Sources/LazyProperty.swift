extension Property {
    public enum LazyProperty {
        case uninitialized(PropertyType.AnyPropertyType)
        case initialized(NormalProperty)
        
        init(_ property: Any) {
            if let property = unwrap(property) {
                self = .initialized(.init(property))
            } else {
                let optional = property as! OptionalType
                self = .uninitialized(.init(optional.wrappedType))
            }
        }
    }
}

extension Property.LazyProperty {
    public var isInitialized: Bool {
        if case .initialized = self {
            return true
        } else {
            return false
        }
    }
    
    public var isOptional: Bool {
        switch self {
        case let .initialized(normal):
            return normal.isOptional
        case let .uninitialized(type):
            return type.isOptional
        }
    }
    
    public var value: Any? {
        switch self {
        case let .initialized(normal):
            return normal.value
        case .uninitialized:
            return nil
        }
    }
}
