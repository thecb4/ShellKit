//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

public struct Command {
  public typealias Arguments = [String]
  public typealias Environment = [String: String]

  // public let name: String
  // public var arguments: Command.Arguments
  // public var environment: Command.Environment
  // public var echoString: String?
  // public let directory: String
}

@available(macOS 10.13, *)
extension Shell {
  static func echo(using name: Shell.Name = .sh, _ words: @autoclosure () -> String) throws -> Shell.Result {
    try Shell.execute(using: name, command: "echo", arguments: [words()])
  }

  static func rm(using name: Shell.Name = .sh, resource: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "rm", arguments: [resource], at: path)
  }

  static func copy(using name: Shell.Name = .sh, source: String, destination: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "cp", arguments: [source, destination], at: path)
  }

  static func git(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "git", arguments: arguments, environment: environment, at: path)
  }

  static func gitStatusPorcelain(using name: Shell.Name = .sh) throws -> Shell.Result {
    let arguments = ["status", "--porcelain"]
    return try Shell.execute(using: name, command: "git", arguments: arguments)
  }

  static func gitUntrackedFiles(using name: Shell.Name = .sh) throws -> [String] {
    let result = try Shell.gitStatusPorcelain()
    if result.status == 0 {
      let files = result.out.components(separatedBy: .newlines)
      return files.filter { $0.prefix(2) == "??" }.map { String($0.dropFirst(3)) }
    } else {
      return []
    }
  }
}
