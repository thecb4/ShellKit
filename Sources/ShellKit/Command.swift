//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
public struct Command {
  public typealias Arguments = [String]
  public typealias Environment = [String: String]

  public let name: String
  public let arguments: Command.Arguments
  public let environment: Command.Environment
  public let workingDirectory: String
  public let outLog: Bool
  public let errLog: Bool
  public let logLevel: Shell.LogLevel

  init(
    name: String,
    arguments: Command.Arguments = [],
    environment: Command.Environment = [:],
    workingDirectory: String = Shell.Path.cwd,
    outLog: Bool = true,
    errLog: Bool = true,
    logLevel: Shell.LogLevel = .off
  ) {
    self.name = name
    self.arguments = arguments
    self.environment = environment
    self.workingDirectory = workingDirectory
    self.outLog = outLog
    self.errLog = errLog
    self.logLevel = logLevel
  }

  var nameAndArguments: String {
    ([name] + arguments).joined(separator: " ")
  }
}
