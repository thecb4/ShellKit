//
//  Reporter.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

@available(macOS 10.13, *)
public typealias LogLevel = Shell.Reporter.Level

@available(macOS 10.13, *)
extension Shell {
  public class Reporter {
    public var log: Bool
    public var shellLogLevel: LogLevel = .off
    public var commandLogLevel: LogLevel = .off
    // swiftlint:disable implicitly_unwrapped_optional
    public var data: Data?
    public var pipe: Pipe?
    // swiftlint:enable implicitly_unwrapped_optional
    public var glyph: Reporter.Glyph?

    public init(glyph: Reporter.Glyph? = nil, log: Bool = false) {
      self.log = log
      self.glyph = glyph
    }

    public func prepare(log: Bool = false, shellLogLevel: LogLevel, commandLogLevel: LogLevel) {
      self.log = log
      self.shellLogLevel = shellLogLevel
      self.commandLogLevel = commandLogLevel
      data = Data()
      pipe = Pipe()

      pipe?.fileHandleForReading.readabilityHandler = report
    }

    public func halt() {
      pipe?.fileHandleForReading.closeFile()
      data = nil
      pipe?.fileHandleForReading.readabilityHandler = nil
      pipe = nil
    }

    public func report(file: FileHandle) {
      let fileData = file.availableData

      guard let line = String(data: fileData, encoding: .utf8) else {
        return
      }

      // https://stackoverflow.com/questions/27768064/check-if-swift-text-field-contains-non-whitespace
      let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)

      if !trimmed.isEmpty {
        if let glyph = glyph {
          let glyphed = trimmed.components(separatedBy: .newlines).map { "\(glyph) | " + $0 }.joined(separator: "\n")
          if shellLogLevel <= commandLogLevel { print(glyphed) }

        } else {
          if shellLogLevel <= commandLogLevel {
            print(trimmed)
          }
        }

        guard let output = trimmed.data(using: .utf8) else {
          return
        }

        data?.append(output)
      }
    }
  }
}

@available(macOS 10.13, *)
extension Shell.Reporter {
  public enum Glyph: String {
    case unicorn = "🦄"
  }

  /// The log level.
  ///
  /// Log levels are ordered by their severity, with `.trace` being the least severe and
  /// `.critical` being the most severe.
  public enum Level: String, Codable, CaseIterable {
    /// logging off
    case off

    /// Appropriate for messages that contain information only when debugging a program.
    case trace

    /// Appropriate for messages that contain information normally of use only when
    /// debugging a program.
    case debug

    /// Appropriate for informational messages.
    case info

    /// Appropriate for conditions that are not error conditions, but that may require
    /// special handling.
    case notice

    /// Appropriate for messages that are not error conditions, but more severe than
    /// `.notice`.
    case warning

    /// Appropriate for error conditions.
    case error

    /// Appropriate for critical error conditions that usually require immediate
    /// attention.
    ///
    /// When a `critical` message is logged, the logging backend (`LogHandler`) is free to perform
    /// more heavy-weight operations to capture system state (such as capturing stack traces) to facilitate
    /// debugging.
    case critical
  }
}

@available(macOS 10.13, *)
extension Shell.Reporter.Level {
  internal var naturalIntegralValue: Int {
    switch self {
      case .off:
        return -1
      case .trace:
        return 0
      case .debug:
        return 1
      case .info:
        return 2
      case .notice:
        return 3
      case .warning:
        return 4
      case .error:
        return 5
      case .critical:
        return 6
    }
  }
}

@available(macOS 10.13, *)
extension Shell.Reporter.Level: Comparable {
  public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
    lhs.naturalIntegralValue < rhs.naturalIntegralValue
  }
}
