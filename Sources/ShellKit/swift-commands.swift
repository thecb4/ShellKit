//
//  swift-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

// swift commands
@available(macOS 10.13, *)
extension Shell {
  public static func swiftBuild(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["build"] + arguments, environment: environment, workingDirectory: workingDirectory))
  }

  public static func swiftTest(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["test"] + arguments, environment: environment, workingDirectory: workingDirectory))
  }

  public static func swiftTestGenerateLinuxMain(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(Command(name: "swift", arguments: ["test", "--generate-linuxmain"], environment: environment, workingDirectory: workingDirectory))
  }

  public static func swiftFormat(version: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(Command(name: "swiftformat", arguments: ["--swiftversion", version, workingDirectory], environment: environment, workingDirectory: workingDirectory))
  }
}
