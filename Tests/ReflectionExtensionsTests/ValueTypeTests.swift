import XCTest
@testable import ReflectionExtensions

struct Foo {
    let name = "foo"
}

class Bar {
    let name = "bar"
    
    init() {}
}

struct Baz {
    let foo = Foo()
    let bar = Bar()
    let string = "string"
    let array = ["string"]
    let set = Set(["string"])
    let dict = ["a":"b"]
    let tuple = (4, "string")
    
    let optionalFoo: Foo? = nil
    let optionalBar: Bar? = nil
    let optionalString: String? = nil
    let optionalArray: [String]? = nil
    let optionalSet: Set<String>? = nil
    let optionalDict: [String:String]? = nil
    let optionalTuple: (Int, String)? = nil
}

enum Kind {
    case `struct`, `class`, function, `enum`, tuple
}

public class ValueTypeTests : XCTestCase {
    func testSomething() {
        let baz = Baz()
        
        assert(baz, "foo", is: .struct)
        assert(baz, "bar", is: .class)
        assert(baz, "string", is: .struct)
        assert(baz, "array", is: .struct)
        assert(baz, "set", is: .struct)
        assert(baz, "dict", is: .struct)
        assert(baz, "tuple", is: .tuple)

        assert(baz, "optionalFoo", is: .struct)
        assert(baz, "optionalBar", is: .class)
        assert(baz, "optionalString", is: .struct)
        assert(baz, "optionalArray", is: .struct)
        assert(baz, "optionalSet", is: .struct)
        assert(baz, "optionalDict", is: .struct)
        assert(baz, "optionalTuple", is: .tuple)
    }
    
    private func assert(_ instance: Any, _ key: String, is kind: Kind) {
        switch kind {
        case .class:
            XCTAssertTrue(isClass(instance, key)!, "\(key) should be recognized as a class.")
            XCTAssertFalse(isStruct(instance, key)!, "\(key) should not be recognized as a struct.")
            XCTAssertFalse(isFunction(instance, key)!, "\(key) should not be recognized as a function.")
            XCTAssertFalse(isEnum(instance, key)!, "\(key) should not be recognized as a enum.")
            XCTAssertFalse(isTuple(instance, key)!, "\(key) should not be recognized as a tuple.")
            
        case .struct:
            XCTAssertTrue(isStruct(instance, key)!, "\(key) should be recognized as a struct.")
            XCTAssertFalse(isClass(instance, key)!, "\(key) should not be recognized as a class.")
            XCTAssertFalse(isFunction(instance, key)!, "\(key) should not be recognized as a function.")
            XCTAssertFalse(isEnum(instance, key)!, "\(key) should not be recognized as a enum.")
            XCTAssertFalse(isTuple(instance, key)!, "\(key) should not be recognized as a tuple.")
            
        case .enum:
            XCTAssertTrue(isEnum(instance, key)!, "\(key) should be recognized as a enum.")
            XCTAssertFalse(isStruct(instance, key)!, "\(key) should not be recognized as a struct.")
            XCTAssertFalse(isFunction(instance, key)!, "\(key) should not be recognized as a function.")
            XCTAssertFalse(isClass(instance, key)!, "\(key) should not be recognized as a class.")
            XCTAssertFalse(isTuple(instance, key)!, "\(key) should not be recognized as a tuple.")
            
        case .function:
            XCTAssertTrue(isFunction(instance, key)!, "\(key) should be recognized as a function.")
            XCTAssertFalse(isStruct(instance, key)!, "\(key) should not be recognized as a struct.")
            XCTAssertFalse(isEnum(instance, key)!, "\(key) should not be recognized as a enum.")
            XCTAssertFalse(isClass(instance, key)!, "\(key) should not be recognized as a class.")
            XCTAssertFalse(isTuple(instance, key)!, "\(key) should not be recognized as a tuple.")
            
        case .tuple:
            XCTAssertTrue(isTuple(instance, key)!, "\(key) should be recognized as a tuple.")
            XCTAssertFalse(isFunction(instance, key)!, "\(key) should not be recognized as a function.")
            XCTAssertFalse(isStruct(instance, key)!, "\(key) should not be recognized as a struct.")
            XCTAssertFalse(isEnum(instance, key)!, "\(key) should not be recognized as a enum.")
            XCTAssertFalse(isClass(instance, key)!, "\(key) should not be recognized as a class.")
        }
    }
    
    private func isClass(_ instance: Any, _ key: String) -> Bool? {
        guard let type: PropertyType = get(key, from: type(of: instance)) else {
            return nil
        }
        
        return type.isClass
    }
    
    private func isStruct(_ instance: Any, _ key: String) -> Bool? {
        guard let type: PropertyType = get(key, from: type(of: instance)) else {
            return nil
        }
        
        return type.isStruct
    }
    
    private func isFunction(_ instance: Any, _ key: String) -> Bool? {
        guard let type: PropertyType = get(key, from: type(of: instance)) else {
            return nil
        }
        
        return type.isFunction
    }
    
    private func isEnum(_ instance: Any, _ key: String) -> Bool? {
        guard let type: PropertyType = get(key, from: type(of: instance)) else {
            return nil
        }
        
        return type.isEnum
    }
    
    private func isTuple(_ instance: Any, _ key: String) -> Bool? {
        guard let type: PropertyType = get(key, from: type(of: instance)) else {
            return nil
        }
        
        return type.isTuple
    }
}

extension ValueTypeTests {
    public static var allTests: [(String, (ValueTypeTests) -> () throws -> Void)] {
        return [
            ("testSomething", testSomething),
        ]
    }
}
