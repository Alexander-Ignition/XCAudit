public protocol Parser {
    associatedtype Output

    func parse(_ string: String) -> Output?
}

extension Parser {
    @inlinable
    func compactMap<T>(_ transform: @escaping (Output) -> T?) -> Parsers.CompactMap<Self, T> {
        Parsers.CompactMap(parser: self, transform: transform)
    }

    @inlinable
    func or<T>(_ parser: T) -> Parsers.Or<Self, T> where T: Parser {
        Parsers.Or(left: self, right: parser)
    }
}

public enum Parsers {

    public struct CompactMap<P, T>: Parser where P: Parser {
        @usableFromInline
        let parser: P

        @usableFromInline
        let transform: (P.Output) -> T?

        public init(parser: P, transform: @escaping (P.Output) -> T?) {
            self.parser = parser
            self.transform = transform
        }

        @inlinable
        public func parse(_ string: String) -> T? {
            parser.parse(string).flatMap(transform)
        }
    }

    public struct Or<P0, P1>: Parser where P0: Parser, P1: Parser, P0.Output == P1.Output  {
        @usableFromInline
        let left: P0

        @usableFromInline
        let right: P1

        public init(left: P0, right: P1) {
            self.left = left
            self.right = right
        }

        @inlinable
        public func parse(_ string: String) -> P0.Output? {
            left.parse(string) ?? right.parse(string)
        }
    }
}
