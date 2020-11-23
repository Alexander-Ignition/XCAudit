import XCAuditKit

while let line = readLine() {
    let command = XcodeIssue.parse(line).flatMap { issue -> WorkflowCommand? in
        switch issue.type {
        case "warning":
            return .warning(location: issue.location, message: issue.message)
        case "error":
            return .error(location: issue.location, message: issue.message)
        default:
            return nil
        }
    }

    if let command = command {
        print(command)
    }
    print(line)
}

