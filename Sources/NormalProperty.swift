extension Property {
    public enum NormalProperty {
        case required(Any)
        case optional(Any?)
        
        init(_ property: Any) {
            if let property = property as? OptionalType {
                self = .optional(property.asOptional)
            } else {
                self = .required(property)
            }
        }
    }
}

extension Property.NormalProperty {
    public var isOptional: Bool {
        switch self {
        case .optional:
            return true
        case .required:
            return false
        }
    }
    
    public var value: Any? {
        switch self {
        case let .optional(value):
            return value
        case let .required(value):
            return value
        }
    }
    
    public var type: Any.Type {
        switch self {
        case let .optional(value):
            return value.wrappedType
        case let .required(value):
            return type(of: value)
        }
    }
}
