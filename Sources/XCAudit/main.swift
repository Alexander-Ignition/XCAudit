import ArgumentParser
import XCAuditKit

struct XCAudit: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "xcaudit",
        abstract: "Audit Xcode build logs for GitHub Actions",
        version: "0.1.3")

    mutating func run() throws {
        let parser = WorkflowParser()

        while let line = readLine() {
            if let command = parser.parse(line) {
                print(command)
            }
            print(line)
        }
    }
}

XCAudit.main()
