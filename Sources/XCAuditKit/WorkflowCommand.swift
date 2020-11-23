/// [Workflow commands for GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-commands-for-github-actions)
public struct WorkflowCommand {
    public typealias Parameters = [(key: String, value: String)]

    public let name: String
    public let parameters: Parameters
    public let value: String

    public init(name: String, parameters: Parameters = [], value: String) {
        self.name = name
        self.parameters = parameters
        self.value = value
    }
}

// MARK: - CustomStringConvertible

extension WorkflowCommand: CustomStringConvertible {
    /// A textual representation of this command.
    ///
    ///     ::workflow-command parameter1={data},parameter2={data}::{command value}
    public var description: String {
        var text = "::\(name)"
        if !parameters.isEmpty {
            let params = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: ",")
            text += " \(params)"
        }
        text += "::\(value)"
        return text
    }
}

// MARK: - Commands

extension WorkflowCommand {
    /// Setting an output parameter.
    ///
    ///     ::set-output name={name}::{value}
    public static func setOutput(name: String, value: String) -> WorkflowCommand {
        WorkflowCommand(name: "set-output", parameters: [("name", name)], value: value)
    }

    /// Setting a debug message.
    ///
    ///     ::debug::{message}
    public static func debug(_ message: String) -> WorkflowCommand {
        WorkflowCommand(name: "debug", value: message)
    }

    /// Setting a warning message.
    ///
    ///     ::warning file={name},line={line},col={col}::{message}
    public static func warning(location: SourceLocation? = nil, message: String) -> WorkflowCommand {
        WorkflowCommand(name: "warning", parameters: parameters(location), value: message)
    }

    /// Setting an error message.
    ///
    ///     ::error file={name},line={line},col={col}::{message}
    public static func error(location: SourceLocation? = nil, message: String) -> WorkflowCommand {
        WorkflowCommand(name: "error", parameters: parameters(location), value: message)
    }

    // MARK: - Private

    private static func parameters(_ sourceLocation: SourceLocation?) -> Parameters {
        var parameters = Parameters()
        if let file = sourceLocation?.file {
            parameters.append(("file", file))
        }
        if let line = sourceLocation?.line {
            parameters.append(("line", "\(line)"))
        }
        if let column = sourceLocation?.column {
            parameters.append(("col", "\(column)"))
        }
        return parameters
    }
}
