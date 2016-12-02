extension PropertyType {
    public enum AnyPropertyType {
        case required(Any.Type)
        case optional(Any.Type)
        
        init(_ type: Any.Type) {
            if let optionalType = type as? OptionalType.Type {
                self = .optional(optionalType.wrappedType)
            } else {
                self = .required(type)
            }
        }
        
        init(_ property: Any) {
            self = AnyPropertyType(type(of: property))
        }
    }
}

extension PropertyType.AnyPropertyType {
    public var type: Any.Type {
        switch self {
        case let .optional(type):
            return type
        case let .required(type):
            return type
        }
    }
    
    public var isOptional: Bool {
        switch self {
        case .optional:
            return true
        case .required:
            return false
        }
    }
}
