import Foundation
@testable import Reflection

protocol Collection {}

extension Set        : Collection {}
extension Array      : Collection {}
extension Dictionary : Collection {}

extension Dictionary {
    init(_ array: [Element]) {
        var d: [Key:Value] = [:]
        for (key, value) in array {
            d[key] = value
        }
        self = d
    }
}

protocol OptionalType {
    var asOptional: Any? { get }
    var wrappedType: Any.Type { get }
    static var wrappedType: Any.Type { get }
}

extension Optional: OptionalType {
    var asOptional: Any? {
        return self
    }
    
    var wrappedType: Any.Type {
        return Wrapped.self
    }
    
    static var wrappedType: Any.Type {
        return Wrapped.self
    }
}

func unwrap(_ value: Any) -> Any? {
    if let optional = value as? OptionalType {
        return optional.asOptional
    }
    
    return value
}

func unwrapOptional(_ type: Any.Type) -> (Bool, Any.Type) {
    if let optionalType = type as? OptionalType.Type {
        return (true, optionalType.wrappedType)
    }
    
    return (false, type)
}

func kind(_ type: Any.Type, is kind: Metadata.Kind) -> Bool {
    guard let actualKind = Metadata(type: type)?.kind else {
        return false
    }
    
    return kind == actualKind
}

extension String {
    func matches(regex: String, options: NSRegularExpression.Options = []) -> Bool {
        guard let exp = try? NSRegularExpression(pattern: regex, options: options) else {
            return false
        }
        
        let matchCount = exp.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count))
        
        return matchCount > 0
    }
    
    func replacing(pattern: String, with replacement: String, options: NSRegularExpression.Options = []) -> String {
        guard let exp = try? NSRegularExpression(pattern: pattern, options: options) else {
            return ""
        }
        
        return exp.stringByReplacingMatches(in: self, options: [], range: NSMakeRange(0, self.characters.count), withTemplate: replacement)
    }
}
