@testable import SomeCollection
import XCTest

final class SomeCollectionTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SomeCollection().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
