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
  func scenario(_ test: () throws -> Void) {
    do {
      try test()
    } catch let Shell.Error.nonZeroExit(message) {
      XCTFail(message)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }

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

  func testExecute() {
    
    scenario {
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
  }

  func testEcho() {
    
    scenario {
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

  }

  func testCopy() {
    
    scenario {
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

  }

  func testExists() {
    scenario {
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
  }

  func testNotExists() {
    scenario {
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
  }

  func testRm() {
    scenario {
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
  }

  func testCreateDirectory() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath
      let resource = "Tests/ShellKitTests/fixtures/test-create-directory"
      try Shell.rm(resource, directory: true, force: true)

      // when
      try Shell.mkdir(at: resource)

      // then
      XCTAssertTrue(Shell.exists(at: resource))
    }
  }

  func testDeleteDirectory() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath
      let resource = "Tests/ShellKitTests/fixtures/test-delete-directory"
      try Shell.mkdir(at: resource)

      // when
      try Shell.rm(resource, directory: true, force: true)

      // then
      XCTAssertFalse(Shell.exists(at: resource))
    }
  }

  func testGitListFiles() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath

      // when
      let files = Shell.git_ls

      // then
      XCTAssertTrue(!files.isEmpty)
    }
  }

  func testGitListModifiedFiles() {
    scenario {
      // given
       Shell.name = .sh
       Shell.logLevel = .debug
       Shell.Path.cwd = Shell.Path.shellKitSourcePath

       // when
       let files = Shell.git_ls_modified

       // then
       XCTAssertTrue(!files.isEmpty)
    }
  }

  func testGitListUntrackedFiles() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath

      // when
      let files = Shell.git_ls_untracked

      // then
      XCTAssertTrue(!files.isEmpty)
    }
  }

  func testSourceKittenSPM() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath
      let json = "Tests/ShellKitTests/fixtures/docs.json"
      let env = ["PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]

      // when
      if Shell.exists(at: json) { try Shell.rm(json, from: Shell.Path.cwd) }
      let result = try Shell.sourceKittenSPM(destination: json, environment: env, logLevel: .debug)

      // then
      XCTAssertTrue(Shell.git_ls_untracked.contains(json))
    }
  }

  func testJazzy() {
    scenario {
      // given
      Shell.name = .sh
      Shell.logLevel = .debug
      Shell.Path.cwd = Shell.Path.shellKitSourcePath
      let env = ["PATH": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]
      let apiPath = "docs/api"
      let apiIndexHtml = "docs/api/index.html"
      try Shell.rm(apiPath, directory: true, force: true)

      // when
      if Shell.exists(at: apiPath) { try Shell.rm(apiPath, from: Shell.Path.cwd) }
      try Shell.jazzy(environment: env)

      // then
      XCTAssertTrue(Shell.exists(at: apiPath))
      XCTAssertTrue(Shell.exists(at: apiIndexHtml))
    }
  }

  func testDirectoryPath() {
    scenario {
      print("FileManager.default.CurrentDirectoryPath: \(FileManager.default.currentDirectoryPath)")
      print("Shell Source Path: \(Shell.Path.shellKitSourcePath)")
      print("Environment PWD: \(ProcessInfo.processInfo.environment["PWD"])")
      print("Environment: \(ProcessInfo.processInfo.environment["HOME"])")
    }
  }
}
