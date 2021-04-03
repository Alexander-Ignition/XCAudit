import Foundation

struct StringScanner: LosslessStringConvertible {
    typealias CompareOptions = String.CompareOptions

    var substring: Substring

    var description: String { String(substring) }

    init(_ string: String) {
        self.substring = string[...]
    }

    @inlinable
    mutating func read(to separator: String, options: CompareOptions = []) -> String? {
        read(to: separator, options: options) { String($0) }
    }

    @inlinable
    mutating func read<T>(_ type: T.Type, to separator: String, options: CompareOptions = []) -> T? where T: LosslessStringConvertible {
        read(to: separator, options: options) { type.init(String($0)) }
    }

    @inlinable
    mutating func read<T>(to separator: String, options: CompareOptions = [], transform: (Substring) -> T?) -> T? {
        guard let range = substring.range(of: separator, options: options) else {
            return nil
        }

        let forward = !options.contains(.backwards)
        let slice = forward ? substring[..<range.lowerBound] : substring[range.upperBound...]

        guard let value = transform(slice) else {
            return nil
        }

        if forward {
            substring.removeSubrange(..<range.upperBound)
        } else {
            substring.removeSubrange(range.lowerBound...)
        }

        return value
    }
}
