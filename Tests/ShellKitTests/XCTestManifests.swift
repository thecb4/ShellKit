#if !canImport(ObjectiveC)
import XCTest

extension ShellTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ShellTests = [
        ("testCopy", testCopy),
        ("testCreateShell", testCreateShell),
        ("testEcho", testEcho),
        ("testExecute", testExecute),
        ("testGitStatusPorcelain", testGitStatusPorcelain),
        ("testGitUntrackedFiles", testGitUntrackedFiles),
        ("testLookup", testLookup),
        ("testRm", testRm),
        ("testShellName", testShellName),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ShellTests.__allTests__ShellTests),
    ]
}
#endif
