#if !canImport(ObjectiveC)
  import XCTest

  extension CommandTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CommandTests = [
      ("testCreateCommand", testCreateCommand)
    ]
  }

  extension ShellTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ShellTests = [
      ("testChangeLoggerInit", testChangeLoggerInit),
      ("testCopy", testCopy),
      ("testCreateDirectory", testCreateDirectory),
      ("testCreateProcess", testCreateProcess),
      ("testCreateShell", testCreateShell),
      ("testDeleteDirectory", testDeleteDirectory),
      ("testDirectoryPath", testDirectoryPath),
      ("testEcho", testEcho),
      ("testExecute", testExecute),
      ("testExists", testExists),
      ("testGitListFiles", testGitListFiles),
      ("testGitListModifiedFiles", testGitListModifiedFiles),
      ("testGitListUntrackedFiles", testGitListUntrackedFiles),
      ("testJazzyMacOS", testJazzyMacOS),
      ("testNotExists", testNotExists),
      ("testRm", testRm),
      ("testShellName", testShellName),
      ("testShellPrepare", testShellPrepare),
      ("testSourceKittenSPMMacOS", testSourceKittenSPMMacOS),
      ("testSwiftDoc", testSwiftDoc),
      ("testSwiftlintMacOS", testSwiftlintMacOS)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    [
      testCase(CommandTests.__allTests__CommandTests),
      testCase(ShellTests.__allTests__ShellTests)
    ]
  }
#endif
