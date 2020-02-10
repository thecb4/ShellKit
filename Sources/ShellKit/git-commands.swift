//
//  git-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
extension Shell {
  public static func git(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: Shell.LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "git", arguments: arguments, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))

    // try Shell.execute(using: name, command: "git", arguments: arguments, environment: environment, at: path)
  }

  public static var git_ls: [String] {
    let arguments = ["ls-files"]

    guard let result = try? Shell.git(arguments: arguments, logLevel: .off) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }

  public static var git_ls_modified: [String] {
    let arguments = ["ls-files", "--modified"]

    guard let result = try? Shell.git(arguments: arguments, logLevel: .off) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }

  public static var git_ls_untracked: [String] {
    let arguments = ["ls-files", "--others", "--exclude-standard"]

    guard let result = try? Shell.git(arguments: arguments, logLevel: .off) else {
      return []
    }

    if result.status == 0 {
      return result.out.components(separatedBy: .newlines)
    } else {
      return []
    }
  }
}
