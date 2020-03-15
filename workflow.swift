#!/usr/bin/env beak --path
// beak: https://gitlab.com/thecb4/shellkit.git  ShellKit @ revision:85933edb

import ShellKit
import Foundation

let env = ["PATH": "/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]

/// Hygene before any real work begins
public func hygene() throws {
  try validate(Shell.exists(at: "commit.yml"), "You need to add a commit.yml file")
  try validate(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
  try validate(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")
}

/// Releases the product
/// - Parameters:
///   - version: the version to release
public func test() throws {
  try Shell.swiftTestGenerateLinuxMain(environment: env)
  try Shell.swiftFormat(version: "5.1", environment: env)
  try Shell.swiftTest(arguments: ["--enable-code-coverage"], environment: env)

  // try Shell.git
  // try Shell.swiftFormat(arguments: ["--swiftversion", "5.1", "."])
  // try Shell.swiftLint(arguments: ["."])
  // try Shell.swiftTest(using: .zsh, arguments: ["--enable-code-coverage"])

  // swift test --generate-linuxmain && \
  // swiftformat --swiftversion 5.1 . && \
  // swiftlint lint . && \
  // swift test --enable-code-coverage && \
  // git add . && git commit -m "$1"

  try Shell.git(arguments: ["add", "."])
  try Shell.git(arguments: ["commit", "-F", "commit.yml"])
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
