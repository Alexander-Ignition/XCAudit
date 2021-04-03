public struct XcodeIssue: Hashable {
    public let name: String
    public let message: String
    public let location: SourceLocation

    public init(type: String, location: SourceLocation, message: String) {
        self.name = type
        self.location = location
        self.message = message
    }
}
