//
//  Result.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import Foundation

// https://github.com/JohnSundell/ShellOut/blob/master/Sources/ShellOut.swift
extension Data {
  var string: String {
    guard let output = String(data: self, encoding: .utf8) else {
      return ""
    }

    // guard !output.hasSuffix("\n") else {
    //   let endIndex = output.index(before: output.endIndex)
    //   return String(output[..<endIndex])
    // }

    return output
  }
}

@available(macOS 10.13, *)
extension Shell {
  public struct Result {
    public let out: String
    public let err: String
    public let status: Int32
  }
}
