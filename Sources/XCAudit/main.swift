import ArgumentParser
import XCAuditKit

struct XCAudit: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xcaudit",
        abstract: "Audit Xcode build logs for GitHub Actions",
        version: "0.1.2")

    mutating func run() throws {
        while let line = readLine() {
            if let command = workflowCommand(from: line) {
                print(command)
            }
            print(line)
        }
    }

    private func workflowCommand(from line: String) -> WorkflowCommand? {
        XcodeIssue.parse(line).flatMap { issue -> WorkflowCommand? in
            switch issue.type {
            case "warning":
                return .warning(location: issue.location, message: issue.message)
            case "error":
                return .error(location: issue.location, message: issue.message)
            default:
                return nil
            }
        }
    }
}

XCAudit.main()
