#warning("custom message")

struct Warnings: CustomStringConvertible {
    var id: Int?
    var text = "Hello world"

    var description: String {
        "Warnings(id: \(id) text: \(text)"
    }
}
