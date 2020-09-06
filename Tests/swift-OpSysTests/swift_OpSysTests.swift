import XCTest
@testable import swift_OpSys

final class swift_OpSysTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_OpSys().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
