//
//  Validate.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

@available(macOS 10.13, *)
public func validate(_ condition: Bool, _ message: String) throws {
  if !condition {
    throw Shell.Error.validationError(message)
  }
}
