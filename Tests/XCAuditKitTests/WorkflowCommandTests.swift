import XCTest
import XCAuditKit

final class WorkflowCommandTests: XCTestCase {

    func testSetOutput() {
        let command = WorkflowCommand.setOutput(name: "action_fruit", value: "strawberry")
        XCTAssertEqual("\(command)", "::set-output name=action_fruit::strawberry")
    }

    func testDebug() {
        let command = WorkflowCommand.debug("Set the Octocat variable")
        XCTAssertEqual("\(command)", "::debug::Set the Octocat variable")
    }

    func testWarning() {
        do {
            let location = SourceLocation(file: "app.js", line: 1, column: 5)
            let command = WorkflowCommand.warning(location: location, message: "Missing semicolon")
            XCTAssertEqual("\(command)", "::warning file=app.js,line=1,col=5::Missing semicolon")
        }
        do {
            let command = WorkflowCommand.warning(message: "Missing semicolon")
            XCTAssertEqual("\(command)", "::warning::Missing semicolon")
        }
    }

    func testError() {
        do {
            let location = SourceLocation(file: "app.js", line: 10, column: 15)
            let command = WorkflowCommand.error(location: location, message: "Something went wrong")
            XCTAssertEqual("\(command)", "::error file=app.js,line=10,col=15::Something went wrong")
        }
        do {
            let command = WorkflowCommand.error(message: "Something went wrong")
            XCTAssertEqual("\(command)", "::error::Something went wrong")
        }
    }
}
