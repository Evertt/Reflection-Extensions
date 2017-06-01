import XCTest
@testable import ReflectionExtensions

struct A {
    let required: Int
    let optional: Int?
    
    lazy var lazyRequired: Int = 0
    lazy var lazyOptional: Int? = 0
}

public class PropertyTests : XCTestCase {
    func testSomething() {
        let a = A(required: 0, optional: 0, lazyRequired: 0, lazyOptional: 0)
        
        let props = properties(a)
        
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
}

extension PropertyTests {
    public static var allTests: [(String, (PropertyTests) -> () throws -> Void)] {
        return [
            ("testSomething", testSomething),
        ]
    }
}
