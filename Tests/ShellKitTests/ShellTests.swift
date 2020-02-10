//
//  ShellTypeTests.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

import XCTest
@testable import ShellKit

@available(macOS 10.13, *)
final class ShellTests: XCTestCase {
  func testShellName() {
    // given
    let name: Shell.Name = .sh

    // when

    // then
    XCTAssertEqual(name.rawValue, "sh")
    XCTAssertEqual(name.name, "sh")
    XCTAssertEqual(name.path, "/bin/sh")
  }

  func testCreateShell() throws {
    // given
    let name: Shell.Name = .sh

    // when
    Shell.name = name
    let shell = Shell()

    // then
    XCTAssertEqual(Shell.name, .sh)
    XCTAssertNotNil(shell.outReport)
    XCTAssertNotNil(shell.errReport)
    XCTAssertFalse(shell.debug)
  }

  func testExecute() throws {
    // given
    let name: Shell.Name = .sh
    let command = Command(
      name: "which",
      arguments: ["echo"]
    )

    // when
    Shell.name = name
    let shell = Shell()

    // then
    let result = try shell.execute(command)

    XCTAssertEqual(result.out, "/bin/echo")
    XCTAssertEqual(result.err, "")
    XCTAssertEqual(result.status, Int32(0))
  }

  func testEcho() throws {
    // given
    let words = "Hello, World!"

    // when
    let result = try Shell.echo(words, logLevel: .off)

    // then
    XCTAssertEqual(result.out, words)
    XCTAssertEqual(result.err, "")
    XCTAssertEqual(result.status, Int32(0))
  }

  func testCopy() throws {
    // given
    let source = "Tests/ShellKitTests/fixtures/source.txt"
    let destination = "Tests/ShellKitTests/fixtures/destination.txt"

    // when
    let result = try Shell.copy(source: source, destination: destination)

    // then
    XCTAssertEqual(result.status, Int32(0))
  }

  func testRm() throws {
    // given
    let resource = "Tests/ShellKitTests/fixtures/destination.txt"

    // when
    let result = try Shell.rm(resource)

    // then
    XCTAssertEqual(result.status, Int32(0))
  }

  func testGitListFiles() throws {
    // given

    // when
    let files = Shell.git_ls

    // then
    XCTAssertTrue(!files.isEmpty)
  }

  func testGitListModifiedFiles() throws {
    // given

    // when
    let files = Shell.git_ls_modified

    // then
    XCTAssertTrue(!files.isEmpty)
  }

  func testGitListUntrackedFiles() throws {
    // given

    // when
    let files = Shell.git_ls_untracked

    // then
    XCTAssertTrue(!files.isEmpty)
  }
}
