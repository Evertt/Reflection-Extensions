import Reflection
@_exported import func Reflection.set
@_exported import func Reflection.construct

public func properties(_ instance: Any) -> [String:Property] {
    let mirror = Mirror(reflecting: instance)
    
    return Dictionary(mirror.children.flatMap { key, value in
        guard var key = key else { return nil }
        let property = Property(key: key, value: value)

        key = key.replacing(pattern: "^(.+?)(\\.storage)?$", with: "$1")
        
        return (key, property)
    })
}

public func properties(_ type: Any.Type) -> [String:PropertyType] {
    return try! Dictionary(
        Reflection
            .properties(type)
            .map { property in
                let propertyType = PropertyType(key: property.key, type: property.type)
                let label = property.key.replacing(pattern: "^(.+?)(\\.storage)?$", with: "$1")
                
                return (label, propertyType)
        }
    )
}

public func get(_ key: String, from instance: Any) -> Property? {
    return properties(instance)[key]
}

public func get(_ key: String, from type: Any.Type) -> PropertyType? {
    return properties(type)[key]
}
