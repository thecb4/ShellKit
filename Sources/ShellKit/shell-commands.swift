//
//  shell-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
extension Shell {
  public static func echo(using name: Shell.Name = .sh, _ words: @autoclosure () -> String) throws -> Shell.Result {
    try Shell.execute(using: name, command: "echo", arguments: [words()])
  }

  public static func rm(using name: Shell.Name = .sh, resource: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "rm", arguments: [resource], at: path)
  }

  public static func copy(using name: Shell.Name = .sh, source: String, destination: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "cp", arguments: [source, destination], at: path)
  }

  public static var USER_PATH: String {
    guard let result = try? Shell.echo("\"$PATH\"") else {
      return ""
    }

    return result.status == 0 ? result.out : ""
  }
}
