import Foundation

public struct XcodeIssue: Hashable {
    public let type: String // error, warning, note ...
    public let location: SourceLocation?
    public let message: String

    public init(type: String, location: SourceLocation, message: String) {
        self.type = type
        self.location = location
        self.message = message
    }

    private static let separator = ":"
    private static let charactersToBeSkipped = CharacterSet(
        charactersIn: separator
    ).union(.whitespacesAndNewlines)

    /// Parse line to issue.
    ///
    ///     {path}:{line}:{column?}: {type}: {message}
    public static func parse(_ line: String) -> XcodeIssue? {
        let scanner = Scanner(string: line)
        scanner.charactersToBeSkipped = charactersToBeSkipped

        guard let file = scanner.scanUpToString(separator) else {
            return nil
        }
        guard let line = scanner.scanInt() else {
            return nil
        }
        let column = scanner.scanInt() // missing in test logs

        guard let type = scanner.scanUpToString(separator) else {
            return nil
        }
        guard let message = scanner.scanUpToString("\n") else {
            return nil
        }
        let location = SourceLocation(file: file, line: line, column: column)
        return XcodeIssue(type: type, location: location, message: message)
    }
}
