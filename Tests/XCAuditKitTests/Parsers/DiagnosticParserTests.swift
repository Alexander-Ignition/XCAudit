import XCTest
import XCAuditKit

final class DiagnosticParserTests: XCTestCase {
    private var parser: DiagnosticParser!

    override func setUp() {
        super.setUp()
        parser = DiagnosticParser()
    }

    func testWarning() throws {
        let line = "/Users/any/xc-gh/Sources/Example/Task.swift:4:28: warning: use 'compactMap(_:)' instead"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.location.file, "/Users/any/xc-gh/Sources/Example/Task.swift")
        XCTAssertEqual(issue.location.line, 4)
        XCTAssertEqual(issue.location.column, 28)
        XCTAssertEqual(issue.name, "warning")
        XCTAssertEqual(issue.message, "use 'compactMap(_:)' instead")
    }

    func testError() throws {
        let line = "/Users/any/xc-gh/Sources/Example/main.swift:7:8: error: any fatal error"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.location.file, "/Users/any/xc-gh/Sources/Example/main.swift")
        XCTAssertEqual(issue.location.line, 7)
        XCTAssertEqual(issue.location.column, 8)
        XCTAssertEqual(issue.name, "error")
        XCTAssertEqual(issue.message, "any fatal error")
    }

    func testUnitTestFailure() throws {
        let line = "/Library/Tests/Example/LibraryTests.swift:12: error: -[LibraryTests.LibraryTests testFail] : failed - fail example"
        let issue = try XCTUnwrap(parser.parse(line))

        XCTAssertEqual(issue.location.file, "/Library/Tests/Example/LibraryTests.swift")
        XCTAssertEqual(issue.location.line, 12)
        XCTAssertNil(issue.location.column)
        XCTAssertEqual(issue.name, "error")
        XCTAssertEqual(issue.message, "-[LibraryTests.LibraryTests testFail] : failed - fail example")
    }
}

