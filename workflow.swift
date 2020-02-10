#!/usr/bin/swift sh

import ShellKit // ./ == dded6c5
// https://gitlab.com/thecb4/shellkit.git == 1a64d32

// do {
//   let modified = Shell.git_ls_modified
//   print(modified)
// }

Shell.outLog = true
Shell.errLog = true
let swiftEnv = ["PATH": "/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"]

do {
  try validate(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
  try validate(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")

  try Shell.swiftTestGenerateLinuxMain(environment: swiftEnv)
  try Shell.swiftFormat(version: "5.1", environment: swiftEnv)
  try Shell.swiftTest(arguments: ["--enable-code-coverage"], environment: swiftEnv)
  // try Shell.swiftFormat(arguments: ["--swiftversion", "5.1", "."])
  // try Shell.swiftLint(arguments: ["."])
  // try Shell.swiftTest(using: .zsh, arguments: ["--enable-code-coverage"])

  // swift test --generate-linuxmain && \
  // swiftformat --swiftversion 5.1 . && \
  // swiftlint lint . && \
  // swift test --enable-code-coverage && \
  // git add . && git commit -m "$1"

  // try Shell.git(arguments: ["add", "."])
  // try Shell.git(arguments: ["commit", "-F", "commit.yml"])
} catch {
  print("exiting early")
  print(error)
  // exit(0)
}
