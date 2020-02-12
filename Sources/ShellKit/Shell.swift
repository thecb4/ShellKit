//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

@available(macOS 10.13, *)
public class Shell {
  public static var outLog: Bool = false
  public static var errLog: Bool = false
  public static var name: Shell.Name = .bash
  public static var logLevel: LogLevel = .info

  // var name: Shell.Name
  var outReport: Shell.Reporter
  var errReport: Shell.Reporter
  var debug: Bool
  // swiftlint:disable implicitly_unwrapped_optional
  var process: Process!
  // swiftlint:enable implicitly_unwrapped_optional

  public init(
    outReport: Shell.Reporter = Shell.Reporter(),
    errReport: Shell.Reporter = Shell.Reporter(),
    debug: Bool = false
  ) {
    self.outReport = outReport
    self.errReport = errReport
    self.debug = debug
  }

  func prepare(commandLogLevel: LogLevel) {
    process = Process()

    outReport.prepare(log: Shell.outLog, shellLogLevel: Shell.logLevel, commandLogLevel: commandLogLevel)
    errReport.prepare(log: Shell.errLog, shellLogLevel: Shell.logLevel, commandLogLevel: commandLogLevel)

    process.standardOutput = outReport.pipe
    process.standardError = errReport.pipe
  }

  func halt() {
    process = nil
    outReport.halt()
    errReport.halt()
  }

  public func execute(_ command: Command) throws -> Shell.Result {
    // new process
    process = Process.process(for: command, using: Shell.name)

    // reporting
    outReport.prepare(log: Shell.outLog, shellLogLevel: Shell.logLevel, commandLogLevel: command.logLevel)
    errReport.prepare(log: Shell.errLog, shellLogLevel: Shell.logLevel, commandLogLevel: command.logLevel)

    process.standardOutput = outReport.pipe
    process.standardError = errReport.pipe

    if Shell.logLevel == .debug {
      print("executableURL = \(String(describing: process.executableURL))")
      print("arguments = \(String(describing: process.arguments))")
      print("env = \(String(describing: process.environment))")
      print("currentDirectoryURL = \(String(describing: process.currentDirectoryURL))")
    }

    try process.run()

    process.waitUntilExit()

    let result = Shell.Result(
      out: outReport.data?.string ?? "",
      err: errReport.data?.string ?? "",
      status: process.terminationStatus
    )

    if result.status != 0 {
      throw Shell.Error.nonZeroExit(result.out + "/n" + result.err)
    }

    halt()

    return result
  }

  public static func execute(_ command: Command) throws -> Shell.Result {
    try Shell().execute(command)
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
}
