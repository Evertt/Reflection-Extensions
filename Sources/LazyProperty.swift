extension Property {
    public enum LazyProperty {
        case uninitialized(PropertyType.AnyPropertyType)
        case initialized(NormalProperty)
        
        init(_ property: OptionalType) {
            if let property = property.asOptional {
                self = .initialized(.init(property))
            } else {
                self = .uninitialized(.init(property.wrappedType))
            }
        }
    }
}

extension Property.LazyProperty {
    public var isInitialized: Bool {
        switch self {
        case .initialized:
            return true
        case .uninitialized:
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
    
    public var type: Any.Type {
        switch self {
        case let .initialized(normal):
            return normal.type
        case let .uninitialized(type):
            return type.type
        }
    }
}
