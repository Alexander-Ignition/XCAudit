/// Runtime issue parsing.
///
/// - `assert`
/// - `assertionFailure`
/// - `precondition`
/// - `preconditionFailure`
/// - `fatalError`
public struct AssertionParser: Parser {
    /// A new assertion parser.
    public init() {}

    /// Parse line to issue.
    ///
    ///     {name}: {message}: file {path}, line {line}
    public func parse(_ string: String) -> XcodeIssue? {
        var buffer = StringScanner(string)

        guard let name = buffer.read(to: ": ") else {
            return nil
        }
        guard let line = buffer.read(Int.self, to: ", line ", options: .backwards) else {
            return nil
        }
        guard let file = buffer.read(to: ": file ", options: .backwards) else {
            return nil
        }
        let message = buffer.description
        let location = SourceLocation(file: file, line: line, column: nil)
        return XcodeIssue(type: name, location: location, message: message)
    }
}
