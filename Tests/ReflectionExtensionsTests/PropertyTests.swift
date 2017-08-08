import XCTest
@testable import Reflection
@testable import ReflectionExtensions

class A {
    let required: Int
    let optional: Int?
    
    lazy var lazyRequired: Int = 0
    lazy var lazyOptional: Int? = 0
    
    init(required: Int, optional: Int?, lazyRequired: Int?, lazyOptional: Int??) {
        self.required = required
        self.optional = optional
        
        if let lazyRequired = lazyRequired {
            self.lazyRequired = lazyRequired
        }
        
        if let lazyOptional = lazyOptional {
            self.lazyOptional = lazyOptional
        }
    }
}

enum E {
    case one, two, three
}

public class PropertyTests : XCTestCase {
    func testSomething() {
        let a = A(required: 0, optional: 0, lazyRequired: 0, lazyOptional: 0)
        
        let props = ReflectionExtensions.properties(a)
        
        XCTAssertNotNil(props["required"])
        XCTAssertNotNil(props["optional"])
        XCTAssertNotNil(props["lazyRequired"])
        XCTAssertNotNil(props["lazyOptional"])
        
        XCTAssertFalse(props["required"]!.isOptional)
        XCTAssertFalse(props["required"]!.isLazy)
        
        XCTAssertTrue(props["optional"]!.isOptional)
        XCTAssertFalse(props["optional"]!.isLazy)
        
        XCTAssertTrue(props["lazyRequired"]!.isLazy)
        XCTAssertFalse(props["lazyRequired"]!.isOptional)

        XCTAssertTrue(props["lazyOptional"]!.isLazy)
        XCTAssertTrue(props["lazyOptional"]!.isOptional)
    }
    
    func testSomethingElse() {
        let cases = listAllCases(of: E.self)
        
        XCTAssert(cases == ["one", "two", "three"])
    }
    
    func testAnotherThing() {
        let a = Metadata.Class(type: A.self)!
        
        print(a.valueWitnessTable.pointer.pointee.assignWithCopy)
    }
}

extension PropertyTests {
    public static var allTests: [(String, (PropertyTests) -> () throws -> Void)] {
        return [
            ("testSomething", testSomething),
        ]
    }
}
