//
//  swift-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

// swift commands
@available(macOS 10.13, *)
extension Shell {
  @discardableResult
  public static func swiftBuild(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["build"] + arguments, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func swiftTest(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["test"] + arguments, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func swiftTestGenerateLinuxMain(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["test", "--generate-linuxmain"], environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func swiftlint(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "swiftlint", arguments: ["lint"], environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func swiftFormat(version: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "swiftformat", arguments: ["--swiftversion", version, workingDirectory], environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func sourceKittenSPM(destination: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    let path = destination.isAbsolute ? destination : workingDirectory + "/\(destination)"

    let command = Command(
      name: "sourcekitten",
      arguments: ["doc", "--spm", ">", path],
      environment: environment,
      workingDirectory: workingDirectory,
      logLevel: logLevel
    )

    let result = try Shell.execute(command)

//    let url = URL(fileURLWithPath: path)

//    try result.out.write(to: url, atomically: false, encoding: .utf8)

    return result
  }

  @discardableResult
  public static func jazzy(arguments: [String] = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "jazzy", arguments: arguments, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func swiftDoc(
    _ input: String = "./Sources",
    name: String,
    output: String,
    author: String,
    authorUrl: String,
    twitterHandle: String,
    gitRepository: String,
    environment: Command.Environment = [:],
    workingDirectory: String = Shell.Path.cwd,
    logLevel: LogLevel = .off
  ) throws -> Shell.Result {
    // swift doc ./Sources --output docs/ --type html --module-name blanket --author "Cavelle Benjamin" --author-url https://thecb4.io --twitter-handle _thecb4 --git-repository https://github.com/thecb4/blanket
    let args = [
      "doc", input,
      "--output", output,
      "--type", "html",
      "--module-name", name,
      "--author", author,
      "--author-url", authorUrl,
      "--twitter-handle", twitterHandle,
      "--git-repository", gitRepository
    ]
    return try Shell.execute(
      Command(name: "swift", arguments: args, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel)
    )
  }
}
