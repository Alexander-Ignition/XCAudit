import XCTest
import XCAuditKit

final class XcodeIssueTests: XCTestCase {

    func testWarning() throws {
        let line = "/Users/any/xc-gh/Sources/Example/Task.swift:4:28: warning: use 'compactMap(_:)' instead"
        let issue = try XCTUnwrap(XcodeIssue.parse(line))

        XCTAssertEqual(issue.type, "warning")
        XCTAssertEqual(issue.location?.file, "/Users/any/xc-gh/Sources/Example/Task.swift")
        XCTAssertEqual(issue.location?.line, 4)
        XCTAssertEqual(issue.location?.column, 28)
        XCTAssertEqual(issue.message, "use 'compactMap(_:)' instead")
    }

    func testError() throws {
        let line = "/Users/any/xc-gh/Sources/Example/main.swift:7:8: error: any fatal error"
        let issue = try XCTUnwrap(XcodeIssue.parse(line))

        XCTAssertEqual(issue.type, "error")
        XCTAssertEqual(issue.location?.file, "/Users/any/xc-gh/Sources/Example/main.swift")
        XCTAssertEqual(issue.location?.line, 7)
        XCTAssertEqual(issue.location?.column, 8)
        XCTAssertEqual(issue.message, "any fatal error")
    }

    func testUnitFailure() throws {
        let line = "/Users/any/xc-gh/Tests/Example/LibraryTests.swift:12: error: -[LibraryTests.LibraryTests testFail] : failed - fail example"
        let issue = try XCTUnwrap(XcodeIssue.parse(line))

        XCTAssertEqual(issue.type, "error")
        XCTAssertEqual(issue.location?.file, "/Users/any/xc-gh/Tests/Example/LibraryTests.swift")
        XCTAssertEqual(issue.location?.line, 12)
        XCTAssertNil(issue.location?.column)
        XCTAssertEqual(issue.message, "-[LibraryTests.LibraryTests testFail] : failed - fail example")
    }
}
