#!/usr/bin/swift sh

import Calm // @thecb4 == 0.9.0

import Path

// extension Shell {
//   @discardableResult
//   public static func swiftDoc(arguments: [String] = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result {
//     try Shell.execute(Command(name: "swift", arguments: ["doc"] += arguments, environment: environment, workingDirectory: workingDirectory, logLevel: logLevel))
//   }
// }

// class TemporaryDirectory {
//     let url: URL
//     var path: DynamicPath { return DynamicPath(Path(string: url.path)) }

//     /**
//      Creates a new temporary directory.

//      The directory is recursively deleted when this object deallocates.

//      If you need a temporary directory on a specific volume use the `appropriateFor`
//      parameter.

//      - Important: If you are moving a file, ensure to use the `appropriateFor`
//      parameter, since it is volume aware and moving the file across volumes will take
//      exponentially longer!
//      - Important: The `appropriateFor` parameter does not work on Linux.
//      - Parameter appropriateFor: The temporary directory will be located on this
//      volume.
//     */
//     init(appropriateFor: URL? = nil) throws {
//       #if !os(Linux)
//         let appropriate: URL
//         if let appropriateFor = appropriateFor {
//             appropriate = appropriateFor
//         } else if #available(OSX 10.12, iOS 10, tvOS 10, watchOS 3, *) {
//             appropriate = FileManager.default.temporaryDirectory
//         } else {
//             appropriate = URL(fileURLWithPath: NSTemporaryDirectory())
//         }
//         url = try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: appropriate, create: true)
//       #else
//         let envs = ProcessInfo.processInfo.environment
//         let env = envs["TMPDIR"] ?? envs["TEMP"] ?? envs["TMP"] ?? "/tmp"
//         let dir = Path.root/env/"swift-sh.XXXXXX"
//         var template = [UInt8](dir.string.utf8).map({ Int8($0) }) + [Int8(0)]
//         guard mkdtemp(&template) != nil else { throw CocoaError.error(.featureUnsupported) }
//         url = URL(fileURLWithPath: String(cString: template))
//       #endif
//     }

//     deinit {
//         do {
//             try path.chmod(0o777).delete()
//         } catch {
//             //TODO log
//         }
//     }
// }

// extension Path {
//     static func mktemp<T>(body: (DynamicPath) throws -> T) throws -> T {
//         let tmp = try TemporaryDirectory()
//         return try body(tmp.path)
//     }
// }

@available(macOS 10.13, *)
extension Calm.Work {
  struct Hygene: ParsableCommand {
    public static var configuration: CommandConfiguration = "Perform hygene activities on the project"

    public func run() throws {
      try ShellKit.validate(Shell.exists(at: "commit.yml"), "You need to add a commit.yml file")
      try ShellKit.validate(!Shell.git_ls_untracked.contains("commit.yml"), "You need to track commit file")
      try ShellKit.validate(Shell.git_ls_modified.contains("commit.yml"), "You need to update your commit file")
    }
  }

  struct Test: ParsableCommand {
    public static var configuration: CommandConfiguration = "Run tests"

    public func run() throws {
      try Shell.swiftTestGenerateLinuxMain(environment: Calm.env)
      try Shell.swiftFormat(version: "5.1", environment: Calm.env)

      let arguments = [
        "--parallel",
        "--xunit-output Tests/Results.xml",
        "--enable-code-coverage"
      ]

      #if os(Linux)
        arguments += ["--filter \"^(?!.*MacOS).*$\""]
      #endif

      try Shell.swiftTest(arguments: arguments)
    }
  }

  struct Save: ParsableCommand {
    public static var configuration: CommandConfiguration = "git commit activities"

    public func run() throws {
      try Hygene.run()
      try Shell.changelogger(arguments: ["log"])
      try Shell.git(arguments: ["add", "-A"])
      try Shell.git(arguments: ["commit", "-F", "commit.yml"])
    }
  }

  struct Documentation: ParsableCommand {
    public static var configuration: CommandConfiguration = "Generate Documentation"

    public func run() throws {
      try Shell.swiftDoc(
        name: "ShellKit",
        output: "docs",
        author: "Cavelle Benjamin",
        authorUrl: "https://thecb4.io",
        twitterHandle: "_thecb4",
        gitRepository: "https://github.com/thecb4/ShellKit"
      )
    }
  }

  struct Integration: ParsableCommand {
    public static var configuration = "Perform integration"

    @Flag(help: "Save on integration completion")
    var save: Bool

    @Flag(help: "local integration")
    var local: Bool

    public func run() throws {
      if local {
        try Hygene.run()
      }

      try Test.run()

      if save {
        try Save.run()
      }
    }
  }

  struct LocalIntegration: ParsableCommand {
    public static var configuration = "Perform local integration"

    @Flag(help: "Save on integration completion")
    var save: Bool

    public func run() throws {
      // try Hygene.run()
      try Test.run()
      // if save { try Save.run() }
    }
  }

  struct ContinuousIntegration: ParsableCommand {
    public static var configuration: CommandConfiguration = "Perform continous integration"

    public func run() throws {
      try Test.run()
    }
  }
}

Calm.Work.configuration.subcommands += [
  Calm.Work.Hygene.self,
  Calm.Work.Test.self,
  Calm.Work.Save.self,
  Calm.Work.Integration.self,
  Calm.Work.Documentation.self
]

if #available(macOS 10.13, *) {
  Calm.main()
} else {
  print("Please at least run macOS 10.13")
}
