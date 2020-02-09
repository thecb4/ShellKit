//
//  swift-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

// swift commands
@available(macOS 10.13, *)
extension Shell {
  public static func swift(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "swift", arguments: arguments, environment: environment, at: path)
  }

  public static func swiftBuild(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], at path: String = Shell.Path.cwd) throws -> Shell.Result {
    let _arguments = ["build"] + arguments
    return try Shell.execute(using: name, command: "swift", arguments: _arguments, environment: environment, at: path)
  }

  public static func swiftTest(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], at path: String = Shell.Path.cwd) throws -> Shell.Result {
    let _arguments = ["test"] + arguments
    print(_arguments)
    return try Shell.execute(using: name, command: "swift", arguments: _arguments, environment: environment, at: path)
  }
}
