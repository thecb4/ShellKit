# Shell

``` swift
@available(macOS 10.13, *) public class Shell
```

## Nested Types

  - Shell.Error
  - Shell.Result
  - Shell.Path
  - Shell.Name
  - Shell.Reporter

## Enumeration Cases

## nonZeroExit

``` swift
case nonZeroExit(: String)
```

## validationError

``` swift
case validationError(: String)
```

## sh

``` swift
case sh
```

## bash

``` swift
case bash
```

## zsh

``` swift
case zsh
```

## fish

``` swift
case fish
```

## Initializers

## init(outReport:errReport:debug:)

``` swift
public init(outReport: Shell.Reporter = Shell.Reporter(), errReport: Shell.Reporter = Shell.Reporter(), debug: Bool = false)
```

## init(glyph:log:)

``` swift
public init(glyph: Reporter.Glyph? = nil, log: Bool = false)
```

## Properties

## outLog

``` swift
var outLog: Bool = false
```

## errLog

``` swift
var errLog: Bool = false
```

## name

``` swift
var name: Shell.Name = .bash
```

## logLevel

``` swift
var logLevel: LogLevel = .info
```

## out

``` swift
let out: String
```

## err

``` swift
let err: String
```

## status

``` swift
let status: Int32
```

## git\_ls

``` swift
var git_ls: [String]
```

## git\_ls\_modified

``` swift
var git_ls_modified: [String]
```

## git\_ls\_untracked

``` swift
var git_ls_untracked: [String]
```

## cwd

``` swift
var cwd = FileManager.default.currentDirectoryPath
```

## shellKitSourcePath

``` swift
let shellKitSourcePath = {
      String(
        URL(fileURLWithPath: #file)
          .deletingLastPathComponent() // remove file
          .deletingLastPathComponent() // remove Source
          .deletingLastPathComponent() //
          .withoutScheme()
      )
    }()
```

## log

``` swift
var log: Bool
```

## shellLogLevel

``` swift
var shellLogLevel: LogLevel = .off
```

## commandLogLevel

``` swift
var commandLogLevel: LogLevel = .off
```

## data

``` swift
var data: Data?
```

## pipe

``` swift
var pipe: Pipe?
```

## glyph

``` swift
var glyph: Reporter.Glyph?
```

## Methods

## execute(\_:)

``` swift
public func execute(_ command: Command) throws -> Shell.Result
```

## execute(\_:)

``` swift
public static func execute(_ command: Command) throws -> Shell.Result
```

## swiftBuild(using:arguments:environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func swiftBuild(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result
```

## swiftTest(using:arguments:environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func swiftTest(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result
```

## swiftTestGenerateLinuxMain(environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func swiftTestGenerateLinuxMain(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result
```

## swiftlint(environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func swiftlint(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## swiftFormat(version:environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func swiftFormat(version: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result
```

## sourceKittenSPM(destination:environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func sourceKittenSPM(destination: String, environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## jazzy(environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func jazzy(environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## git(using:arguments:environment:workingDirectory:logLevel:)

``` swift
@discardableResult public static func git(using name: Shell.Name = .sh, arguments: Command.Arguments = [], environment: Command.Environment = [:], workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .info) throws -> Shell.Result
```

## echo(\_:logLevel:)

``` swift
@discardableResult public static func echo(_ words: @autoclosure () -> String, logLevel: LogLevel = .info) throws -> Shell.Result
```

## exists(at:with:logLevel:)

``` swift
@discardableResult public static func exists(at path: String, with workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) -> Bool
```

## mkdir(at:from:logLevel:)

``` swift
@discardableResult public static func mkdir(at path: String, from workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## rm(\_:directory:force:from:logLevel:)

``` swift
@discardableResult public static func rm(_ resource: String, directory: Bool = false, force: Bool = false, from workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## copy(source:destination:at:logLevel:)

``` swift
@discardableResult public static func copy(source: String, destination: String, at workingDirectory: String = Shell.Path.cwd, logLevel: LogLevel = .off) throws -> Shell.Result
```

## prepare(log:shellLogLevel:commandLogLevel:)

``` swift
public func prepare(log: Bool = false, shellLogLevel: LogLevel, commandLogLevel: LogLevel)
```

## halt()

``` swift
public func halt()
```

## report(file:)

``` swift
public func report(file: FileHandle)
```
