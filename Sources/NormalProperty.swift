extension Property {
    public enum NormalProperty {
        case required(Any)
        case optional(Any?)
        
        init(_ property: Any) {
            if property is OptionalType {
                self = .optional(unwrap(property))
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
}
