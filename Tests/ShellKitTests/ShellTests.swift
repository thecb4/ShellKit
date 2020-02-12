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
  
  func testShellPrepare() {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    let name: Shell.Name = .sh

    // when
    Shell.name = name
    let shell = Shell()
    shell.prepare(commandLogLevel: .info)

    // then
    XCTAssertEqual(Shell.name, .sh)
    XCTAssertNotNil(shell.outReport)
    XCTAssertNotNil(shell.errReport)
    XCTAssertFalse(shell.debug)
    XCTAssertEqual(shell.outReport.commandLogLevel, .info)
    XCTAssertEqual(shell.errReport.commandLogLevel, .info)
  }
  
  func testCreateProcess() {
    // given
    let wd = "/Users/cavellebenjamin/Development/toolbox/Shellkit"
    let command = Command(
      name: "which",
      arguments: ["echo"],
      workingDirectory: wd
    )
    
    // when
    let process = Process.process(for: command, using: .sh)
    
    // then
    XCTAssertEqual(process.executableURL?.absoluteString, "file:///bin/sh")
    XCTAssertEqual(process.arguments!, ["-c", "which echo"])
    XCTAssertEqual(process.currentDirectoryPath, wd)
  }

  func testExecute() throws {
    // given
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
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
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
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
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    let source = "Tests/ShellKitTests/fixtures/source.txt"
    let destination = "Tests/ShellKitTests/fixtures/destination.txt"

    // when
    let result = try Shell.copy(source: source, destination: destination)

    // then
    XCTAssertEqual(result.status, Int32(0))
  }
  
  func testExists() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    let path = "Tests/ShellKitTests/fixtures/exists.txt"
    
    // when
    let result = Shell.exists(at: path)
    
    // then
    XCTAssertTrue(result)
  }
  
  func testNotExists() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    let path = "Tests/ShellKitTests/fixtures/non-existant-file.txt"
    
    // when
    let result = Shell.exists(at: path)
    
    // then
    XCTAssertFalse(result)
  }

  func testRm() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    let resource = "Tests/ShellKitTests/fixtures/destination.txt"

    // when
    let result = try Shell.rm(resource)

    // then
    XCTAssertEqual(result.status, Int32(0))
  }

  func testGitListFiles() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath

    // when
    let files = Shell.git_ls

    // then
    XCTAssertTrue(!files.isEmpty)
  }

  func testGitListModifiedFiles() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath

    // when
    let files = Shell.git_ls_modified

    // then
    XCTAssertTrue(!files.isEmpty)
  }

  func testGitListUntrackedFiles() throws {
    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath

    // when
    let files = Shell.git_ls_untracked

    // then
    XCTAssertTrue(!files.isEmpty)
  }

  func testSourceKittenSPM() throws {

    // given
    Shell.name = .sh
    Shell.logLevel = .debug
    Shell.Path.cwd = Shell.Path.shellKitSourcePath
    print(Shell.Path.cwd)
    let json = "Tests/ShellKitTests/fixtures/docs.json"
    let env = ["PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]
        
    // when
    if Shell.exists(at: json) { try Shell.rm(json, from: Shell.Path.cwd) }
    let result = try Shell.sourceKittenSPM(destination: json, environment: env, logLevel: .debug)
    print(result.out)
    print(result.err)
    
    // then
    print(Shell.git_ls_untracked)
    XCTAssertTrue( Shell.git_ls_untracked.contains(json) )
  }
  
  func testDirectoryPath() {
    print("FileManager.default.CurrentDirectoryPath: \(FileManager.default.currentDirectoryPath)")
    print("Shell Source Path: \(Shell.Path.shellKitSourcePath)")
    print("Environment PWD: \(ProcessInfo.processInfo.environment["PWD"])")
    print("Environment: \(ProcessInfo.processInfo.environment["HOME"])")
  }
}
