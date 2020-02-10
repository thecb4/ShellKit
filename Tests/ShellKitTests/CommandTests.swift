//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import XCTest
@testable import ShellKit

@available(macOS 10.13, *)
final class CommandTests: XCTestCase {
  func testCreateCommand() {
    // given

    // when
    let command = Command(
      name: "echo",
      arguments:
      ["Hello, World!"],
      environment: [:],
      workingDirectory: ".",
      logLevel: .info
    )

    // then
    XCTAssertEqual(command.name, "echo")
    XCTAssertEqual(command.arguments, ["Hello, World!"])
    XCTAssertEqual(command.environment, [:])
    XCTAssertEqual(command.workingDirectory, ".")
    XCTAssertEqual(command.logLevel, .info)
  }
}
