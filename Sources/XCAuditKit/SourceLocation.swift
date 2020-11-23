public struct SourceLocation: Hashable {
    public let file: String
    public let line: Int?
    public let column: Int?

    public init(file: String, line: Int? = nil, column: Int? = nil) {
        self.file = file
        self.line = line
        self.column = column
    }
}
