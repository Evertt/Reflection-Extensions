public enum PropertyType {
    case normal(AnyPropertyType)
    case lazy(AnyPropertyType)
    
    init(key: String, type: Any.Type) {
        if key.matches(regex: "^.+\\.storage$"),
        let type = type as? OptionalType.Type {
            self = .lazy(.init(type.wrappedType))
        } else {
            self = .normal(.init(type))
        }
    }
}

extension PropertyType {
    public var type: Any.Type {
        switch self {
        case let .lazy(type):
            return type.type
        case let .normal(type):
            return type.type
        }
    }
    
    public var isLazy: Bool {
        switch self {
        case .lazy:
            return true
        case .normal:
            return false
        }
    }
    
    public var isOptional: Bool {
        switch self {
        case let .lazy(type):
            return type.isOptional
        case let .normal(type):
            return type.isOptional
        }
    }
}
