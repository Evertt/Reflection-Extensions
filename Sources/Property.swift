public enum Property {
    case normal(NormalProperty)
    case lazy(LazyProperty)
    
    init(key: String, value: Any) {
        if key.matches(regex: "^.+\\.storage$")
        && value is OptionalType {
            self = .lazy(.init(value))
        } else {
            self = .normal(.init(value))
        }
    }
}

extension Property {
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
        case let .lazy(property):
            return property.isOptional
        case let .normal(property):
            return property.isOptional
        }
    }
    
    public var isInitialized: Bool {
        switch self {
        case let .lazy(property):
            return property.isInitialized
        case .normal:
            return true
        }
    }
    
    public var value: Any? {
        switch self {
        case let .normal(normal):
            return normal.value
        case let .lazy(lazy):
            return lazy.value
        }
    }
}
