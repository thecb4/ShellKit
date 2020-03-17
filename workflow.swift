// beak: https://gitlab.com/thecb4/shellkit.git  ShellKit @ revision:2630153a

import ShellKit
import Foundation

let env = ["PATH": "/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]

/// Hygene before any real work begins
public func hygene() throws {
  try validate(Shell.exists(at: "commit.yml"), "You need to add a commit.yml file")
  try validate(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
  try validate(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")
}

/// Tests the product
public func test() throws {
  try Shell.swiftTestGenerateLinuxMain(environment: env)
  try Shell.swiftFormat(version: "5.1", environment: env)

  #if os(macOS)
    try Shell.swiftTest(arguments: ["--enable-code-coverage"], environment: env)
  #else
    try Shell.swiftTest(arguments: ["--enable-code-coverage", "--filter \"^(?!.*MacOS).*$\""], environment: env)
  #endif
}

/// Document the product
public func docs() throws {
  try Shell.swiftDoc(
    name: "ShellKit",
    output: "docs",
    author: "Cavelle Benjamin",
    authorUrl: "https://thecb4.io",
    twitterHandle: "_thecb4",
    gitRepository: "https://github.com/thecb4/ShellKit"
  )
}

/// Saves the project in git with a commit message in commit.yml
public func save() throws {
  try hygene()
  try Shell.git(arguments: ["add", "."])
  try Shell.git(arguments: ["commit", "-F", "commit.yml"])
}

public func flow() throws {
  try hygene()
  try test()
  try docs()
}

public func ci() throws {
  try test()
}

public func li() throws {
  try hygene()
  try test()
  try Shell.changelogger(arguments: ["log"])
  try save()
}
