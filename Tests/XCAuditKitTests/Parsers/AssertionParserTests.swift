import XCTest
import XCAuditKit

final class AssertionParserTests: XCTestCase {
    private var parser: AssertionParser!

    override func setUp() {
        super.setUp()
        parser = AssertionParser()
    }

    func testAssert() throws {
        let line = "Assertion failed: Error: file not found: file Sources/Settings.swift, line 32"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.name, "Assertion failed")
        XCTAssertEqual(issue.message, "Error: file not found")
        XCTAssertEqual(issue.location.file, "Sources/Settings.swift")
        XCTAssertEqual(issue.location.line, 32)
        XCTAssertNil(issue.location.column)
    }

    func testFatalError() throws {
        let line = "Fatal error: Unexpectedly found nil while unwrapping an Optional value: file BuildError/BuildError.swift, line 6"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.name, "Fatal error")
        XCTAssertEqual(issue.message, "Unexpectedly found nil while unwrapping an Optional value")
        XCTAssertEqual(issue.location.file, "BuildError/BuildError.swift")
        XCTAssertEqual(issue.location.line, 6)
        XCTAssertNil(issue.location.column)
    }
}
