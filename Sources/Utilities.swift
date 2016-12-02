import Foundation

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
