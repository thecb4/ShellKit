#!/usr/bin/swift sh

import ShellKit // ./ == 3ecae72
// https://gitlab.com/thecb4/shellkit.git == a32f572

// do {
//   let modified = Shell.git_ls_modified
//   print(modified)
// }

Shell.outLog = true

do {
  print(Shell.git_ls_modified)
  // precondition(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
  // precondition(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")
  try Shell.swiftTest(using: .zsh, arguments: ["--generate-linuxmain"], environment: ["PATH": "/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"])
  // try Shell.swiftFormat(arguments: ["--swiftversion", "5.1", "."])
  // try Shell.swiftLint(arguments: ["."])
  // try Shell.swiftTest(using: .zsh, arguments: ["--enable-code-coverage"])

  // swift test --generate-linuxmain && \
  // swiftformat --swiftversion 5.1 . && \
  // swiftlint lint . && \
  // swift test --enable-code-coverage && \
  // git add . && git commit -m "$1"

  try Shell.git(arguments: ["add", "."])
  try Shell.git(arguments: ["commit", "-F", "commit.yml", "--author", "TheCB4 <cavelle@thecb4.io>"])
} catch {
  print("exiting early")
  print(error)
  // exit(0)
}
