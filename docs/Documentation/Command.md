# Command

``` swift
@available(macOS 10.13, *) public struct Command
```

## Nested Type Aliases

## Arguments

``` swift
Typealias(context: Optional("Command"), attributes: [], modifiers: [public], keyword: "typealias", name: "Arguments", initializedType: Optional("[String]"), genericParameters: [], genericRequirements: [])
```

## Environment

``` swift
Typealias(context: Optional("Command"), attributes: [], modifiers: [public], keyword: "typealias", name: "Environment", initializedType: Optional("[String: String]"), genericParameters: [], genericRequirements: [])
```

## Properties

## name

``` swift
let name: String
```

## arguments

``` swift
let arguments: Command.Arguments
```

## environment

``` swift
let environment: Command.Environment
```

## workingDirectory

``` swift
let workingDirectory: String
```

## outLog

``` swift
let outLog: Bool
```

## errLog

``` swift
let errLog: Bool
```

## logLevel

``` swift
let logLevel: LogLevel
```
