//
//  Reporter.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

@available(macOS 10.13, *)
extension Shell {
  public class Reporter {
    public var log: Bool
    // swiftlint:disable implicitly_unwrapped_optional
    public var data: Data!
    public var pipe: Pipe!
    // swiftlint:enable implicitly_unwrapped_optional
    public var glyph: Reporter.Glyph?

    public init(glyph: Reporter.Glyph? = nil, log: Bool = false) {
      self.log = log
      self.glyph = glyph
    }

    public func prepare(log: Bool = false) {
      self.log = log
      data = Data()
      pipe = Pipe()

      pipe.fileHandleForReading.readabilityHandler = report
    }

    public func halt() {
      data = nil
      pipe.fileHandleForReading.readabilityHandler = nil
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
          if log { print(glyphed) }

        } else {
          if log { print(trimmed) }
        }

        guard let output = trimmed.data(using: .utf8) else {
          return
        }

        data.append(output)
      }
    }
  }
}

@available(macOS 10.13, *)
extension Shell.Reporter {
  public enum Glyph: String {
    case unicorn = "🦄"
  }
}
