//
//  shell-commands.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

@available(macOS 10.13, *)
extension Shell {
  public struct Path {
    public static var cwd = FileManager.default.currentDirectoryPath
    
    public static let shellKitSourcePath = {
      String(
        URL(fileURLWithPath: #file)
          .deletingLastPathComponent() // remove file
          .deletingLastPathComponent() // remove Source
          .deletingLastPathComponent() //
          .withoutScheme()
      )
    }()
  }
}

public extension URL {
    func withoutScheme() -> String {
        let urlWithoutScheme = String(
            pathComponents
                .joined(separator: "/")
                .dropFirst()
        )

        return urlWithoutScheme
    }
}

@available(macOS 10.13, *)
extension Shell {
  
  @discardableResult
  public static func echo(_ words: @autoclosure () -> String, logLevel: LogLevel = .info) throws -> Shell.Result {
    try Shell.execute(Command(name: "echo", arguments: [words()], logLevel: logLevel))
  }
  
  @discardableResult
  public static func exists(at path: String, with workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) -> Bool {
    let fullPath = path.isAbsolute ? path : workingDirectory + "/\(path)"
    print(fullPath)
    return FileManager.default.fileExists(atPath: fullPath)
  }

  @discardableResult
  public static func rm(_ resource: String, from workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "rm", arguments: [resource], workingDirectory: workingDirectory))
  }

  @discardableResult
  public static func copy(source: String, destination: String, at workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
    try Shell.execute(Command(name: "cp", arguments: [source, destination], workingDirectory: workingDirectory, logLevel: logLevel))
  }
}
