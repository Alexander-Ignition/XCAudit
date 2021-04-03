/// Compile time issue parsing.
///
/// - `#error()` compile time error.
/// - `#warning()` compile time warning.
/// - `XCTAssert()` unit test asserts.
public struct DiagnosticParser: Parser {
    /// A new diagnostic parser.
    public init() {}
    
    /// Parse line to issue.
    ///
    ///     {file}:{line}:{column?}: {name}: {message}
    public func parse(_ string: String) -> XcodeIssue? {
        var buffer = StringScanner(string)

        guard let file = buffer.read(to: ":") else {
            return nil
        }
        guard let line = buffer.read(Int.self, to: ":") else {
            return nil
        }
        let column = buffer.read(Int.self, to: ":") // missing in XCTest logs

        guard buffer.substring.removeFirst() == " " else {
            return nil
        }
        guard let name = buffer.read(to: ": ") else {
            return nil
        }
        let message = buffer.description
        let location = SourceLocation(file: file, line: line, column: column)
        return XcodeIssue(type: name, location: location, message: message)
    }
}
