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
    let shell = Shell(name)

    // then
    XCTAssertEqual(shell.name, .sh)
    XCTAssertNotNil(shell.outReport)
    XCTAssertNotNil(shell.errReport)
    XCTAssertFalse(shell.debug)
  }

  func testExecute() throws {
    // given
    let name: Shell.Name = .sh

    // when
    let sh = Shell(name)

    // then
    let result = try sh.execute(sh.name.path, arguments: ["-l", "-c", "which echo"])

    XCTAssertEqual(result.out, "/bin/echo")
    XCTAssertEqual(result.err, "")
    XCTAssertEqual(result.status, Int32(0))
  }

  func testLookup() throws {
    // given
    let command = "echo"

    // when
    let result = try Shell.lookup(command)

    // then
    XCTAssertEqual(result.out, "/bin/echo")
    XCTAssertEqual(result.err, "")
    XCTAssertEqual(result.status, Int32(0))
  }

  func testEcho() throws {
    // given
    let words = "Hello, World!"

    // when
    let result = try Shell.echo(words)

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
    let result = try Shell.rm(resource: resource)

    // then
    XCTAssertEqual(result.status, Int32(0))
  }

  func testGitStatusPorcelain() throws {
    // given

    // when
    let result = try Shell.gitStatusPorcelain()

    // then
    print(result.out)
  }

  func testGitUntrackedFiles() throws {
    // given

    // when
    let files = try Shell.gitUntrackedFiles()

    // then
    print(files)
  }
}
