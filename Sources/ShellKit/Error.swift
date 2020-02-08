//
//  Error.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
extension Shell {
  public enum Error: Swift.Error {
    case nonZeroExit(String)
  }
}
