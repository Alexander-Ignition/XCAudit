import XCTest
import XCAuditKit

final class WorkflowParserTests: XCTestCase {
    private var parser: WorkflowParser!

    override func setUp() {
        super.setUp()
        parser = WorkflowParser()
    }

    func testAssert() throws {
        let line = "Assertion failed: Error: file not found: file Sources/Settings.swift, line 32"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.name, "error")
        XCTAssertEqual(issue.value, "Error: file not found")
    }

    func testFatalError() throws {
        let line = "Fatal error: Unexpectedly found nil while unwrapping an Optional value: file BuildError/BuildError.swift, line 6"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.name, "error")
        XCTAssertEqual(issue.value, "Unexpectedly found nil while unwrapping an Optional value")
    }

    func testNote() throws {
        let line = "Fatal error: Unexpectedly found nil while unwrapping an Optional value: file BuildError/BuildError.swift, line 6"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.name, "error")
        XCTAssertEqual(issue.value, "Unexpectedly found nil while unwrapping an Optional value")
    }
}

