//
//  shell-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
extension Shell {
  public static func echo(_ words: @autoclosure () -> String, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "echo", arguments: [words()], logLevel: logLevel))
  }

  public static func rm(_ resource: String, from workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "rm", arguments: [resource], workingDirectory: workingDirectory))
  }

  public static func copy(source: String, destination: String, at workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "cp", arguments: [source, destination], workingDirectory: workingDirectory, logLevel: logLevel))
  }
}
