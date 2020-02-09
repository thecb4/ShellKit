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
  static func echo(using name: Shell.Name = .bash, _ words: @autoclosure () -> String) throws -> Shell.Result {
    try Shell.execute(using: name, command: "echo", arguments: [words()])
  }

  static func rm(using name: Shell.Name = .bash, resource: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "rm", arguments: [resource], at: path)
  }

  static func copy(using name: Shell.Name = .bash, source: String, destination: String, at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "cp", arguments: [source, destination], at: path)
  }

  static func git(using name: Shell.Name = .bash, arguments: Command.Arguments = [], environment: Command.Environment = [:], at path: String = Shell.Path.cwd) throws -> Shell.Result {
    try Shell.execute(using: name, command: "git", arguments: arguments, environment: environment, at: path)
  }

  static var git_ls: [String] {
    let arguments = ["ls-files"]

    guard let result = try? Shell.git(arguments: arguments) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }

  static var git_ls_modified: [String] {
    let arguments = ["ls-files", "--modified"]

    guard let result = try? Shell.git(arguments: arguments) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }

  static var git_ls_untracked: [String] {
    let arguments = ["ls-files", "--others", "--exclude-standard"]

    guard let result = try? Shell.git(arguments: arguments) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }

  //
  // static func gitStatusPorcelain(using name: Shell.Name = .bash) throws -> Shell.Result {
  //   let arguments = ["status", "--porcelain"]
  //   return try Shell.execute(using: name, command: "git", arguments: arguments)
  // }
  //
  // static func gitUntrackedFiles(using name: Shell.Name = .bash) throws -> [String] {
  //   let result = try Shell.gitStatusPorcelain()
  //   if result.status == 0 {
  //     let files = result.out.components(separatedBy: .newlines)
  //     return files.filter { $0.prefix(2) == "??" }.map { String($0.dropFirst(3)) }
  //   } else {
  //     return []
  //   }
  // }
  //
  // static func gitCurrentBranch(using name: Shell.Name = .bash) throws -> String {
  //   let arguments = ["rev-parse", "--abbrev-ref", "HEAD"]
  //   if result.status == 0 {
  //     return results.out
  //   } else {
  //     return ""
  //   }
  // }
  //
  // static func gitModifiedFiles(versus otherBranch: String) throws -> [String] {
  //   let arguments = ["diff", "--name-only", otherBranch + "..."]
  //   let results = try Shell.execute(using: name, command: "git", arguments: arguments)
  //   if results.status == 0 {
  //     return result.out.components(separatedBy: .newlines)
  //   } else {
  //     return []
  //   }
  // }
}
