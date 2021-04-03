public struct WorkflowParser: Parser {
    private let parser = diagnostic.or(assertion)

    public init() {}

    public func parse(_ string: String) -> WorkflowCommand? {
        parser.parse(string)
    }

    private static let assertion = AssertionParser().compactMap { issue in
        WorkflowCommand.error(location: issue.location, message: issue.message)
    }

    private static let diagnostic = DiagnosticParser().compactMap { issue -> WorkflowCommand? in
        switch issue.name {
        case "warning":
            return .warning(location: issue.location, message: issue.message)
        case "error":
            return .error(location: issue.location, message: issue.message)
        default:
            return nil // skip 'note', 'remark' and other
        }
    }
}
