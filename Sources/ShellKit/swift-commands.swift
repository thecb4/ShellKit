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
  public static func swiftFormat(version: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "swiftformat", arguments: ["--swiftversion", version, workingDirectory], environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
  }

  @discardableResult
  public static func sourceKittenSPM(destination: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {

    let command = Command(
      name: "sourcekitten",
      arguments: ["doc", "--spm"],
      environment: environment,
      workingDirectory: workingDirectory,
      logLevel: logLevel
    )
    
    print(command)
    
    let result = try Shell.execute(command)
    
    print(result.out)
    print(result.err)
    print(result.status)
    
    let path = destination.isAbsolute ? destination : workingDirectory + "/\(destination)"
    
    print(path)
    
    let url = URL(fileURLWithPath: path)
    
    try result.out.write(to: url, atomically: false, encoding: .utf8)

    return result

  }
}
