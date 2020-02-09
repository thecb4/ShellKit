//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

@available(macOS 10.13, *)
public class Shell {
  var name: Shell.Name
  var outReport: Shell.Reporter
  var errReport: Shell.Reporter
  var debug: Bool
  // swiftlint:disable implicitly_unwrapped_optional
  var process: Process!
  // swiftlint:enable implicitly_unwrapped_optional

  public init(
    _ name: Shell.Name,
    outReport: Shell.Reporter = Shell.Reporter(),
    errReport: Shell.Reporter = Shell.Reporter(),
    debug: Bool = false
  ) {
    self.name = name
    self.outReport = outReport
    self.errReport = errReport
    self.debug = debug
  }

  func prepare() {
    process = Process()

    outReport.prepare()
    errReport.prepare()

    process.standardOutput = outReport.pipe
    process.standardError = errReport.pipe

    // outPipe.fileHandleForReading.readabilityHandler = handleOutput
    // errPipe.fileHandleForReading.readabilityHandler = handleError
  }

  func halt() {
    process = nil
    outReport.halt()
    errReport.halt()
  }

  public func execute(_ executable: String, arguments: Command.Arguments, environment: Command.Environment? = nil, at pwd: String = Shell.Path.cwd) throws -> Shell.Result {
    prepare()

    process.executableURL = URL(fileURLWithPath: executable)
    process.arguments = arguments

    if let env = environment {
      process.environment = env
    }

    process.currentDirectoryURL = URL(fileURLWithPath: pwd)

    print("executableURL = \(String(describing: process.executableURL))")
    print("arguments = \(String(describing: process.arguments))")
    print("env = \(String(describing: process.environment))")
    print("currentDirectoryURL = \(String(describing: process.currentDirectoryURL))")

    try process.run()

    process.waitUntilExit()

    let result = Shell.Result(
      out: outReport.data.string,
      err: errReport.data.string,
      status: process.terminationStatus
    )

    if result.status != 0 {
      throw Shell.Error.nonZeroExit(result.err)
    }

    halt()

    return result
  }

  public func execute(with arguments: Command.Arguments, environment: Command.Environment? = nil, at pwd: String = Shell.Path.cwd) throws -> Shell.Result {
    try execute(name.path, arguments: arguments, environment: environment, at: pwd)
  }

  static func lookup(_ command: String, using name: Shell.Name = .sh) throws -> Shell.Result {
    let arguments = ["-c", "which \(command)"]

    let shell = Shell(name)

    return try shell.execute(with: arguments)
  }

  public static func execute(using name: Shell.Name = .sh, command: String, arguments: Command.Arguments, environment: Command.Environment? = nil, at pwd: String = Shell.Path.cwd) throws -> Shell.Result {
    let whichCommand = (try Shell.lookup(command)).out
    //let _command = whichCommand.out
    let shell = Shell(name)
    //let _arguments = ["-c"] + [([command] + arguments).joined(separator: " ")]
    //print(_arguments)
    return try shell.execute(whichCommand, arguments: arguments, environment: environment, at: pwd)
  }
}

@available(macOS 10.13, *)
extension Shell {
  public enum Name: String {
    case sh
    case bash
    case zsh
    case fish

    var name: String {
      rawValue
    }

    var path: String {
      "/bin/" + rawValue
    }
  }

  public struct Path {
    public static let cwd = FileManager.default.currentDirectoryPath
  }
}
