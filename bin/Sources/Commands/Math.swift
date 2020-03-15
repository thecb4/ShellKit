//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Mar-15 (11).
//

import ArgumentParser

public struct Math: ParsableCommand {
  public init() {}

  public static var configuration = CommandConfiguration(
    abstract: "A utility for performing maths.",
    subcommands: [Add.self, Multiply.self, Statistics.self],
    defaultSubcommand: Add.self
  )

  struct Options: ParsableArguments {
    @Flag(name: [.long, .customShort("x")], help: "Use hexadecimal notation for the result.")
    var hexadecimalOutput: Bool

    @Argument(help: "A group of integers to operate on.")
    var values: [Int]
  }
}

extension Math {
  struct Add: ParsableCommand {
    static var configuration
      = CommandConfiguration(abstract: "Print the sum of the values.")

    @OptionGroup()
    var options: Math.Options

    func run() {
      let result = options.values.reduce(0, +)
      print(format(result: result, usingHex: options.hexadecimalOutput))
    }
  }

  struct Multiply: ParsableCommand {
    static var configuration
      = CommandConfiguration(abstract: "Print the product of the values.")

    @OptionGroup()
    var options: Math.Options

    func run() {
      let result = options.values.reduce(1, *)
      print(format(result: result, usingHex: options.hexadecimalOutput))
    }
  }
}

func format(result: Int, usingHex: Bool) -> String {
  String(result)
}

extension Math {
  struct Statistics: ParsableCommand {
    static var configuration = CommandConfiguration(
      commandName: "stats",
      abstract: "Calculate descriptive statistics.",
      subcommands: [Average.self, StandardDeviation.self]
    )
  }
}

extension Math.Statistics {
  struct Average: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Print the average of the values.")

    enum Kind: String, ExpressibleByArgument {
      case mean, median, mode
    }

    @Option(default: .mean, help: "The kind of average to provide.")
    var kind: Kind

    @Argument(help: "A group of floating-point values to operate on.")
    var values: [Double]

    func calculateMean() -> Double { 0.0 }
    func calculateMedian() -> Double { 0.0 }
    func calculateMode() -> [Double] { [0.0] }

    func run() {
      switch kind {
        case .mean:
          print(calculateMean())
        case .median:
          print(calculateMedian())
        case .mode:
          let result = calculateMode()
            .map(String.init(describing:))
            .joined(separator: " ")
          print(result)
      }
    }
  }

  struct StandardDeviation: ParsableCommand {
    static var configuration = CommandConfiguration(
      commandName: "stdev",
      abstract: "Print the standard deviation of the values."
    )

    @Argument(help: "A group of floating-point values to operate on.")
    var values: [Double]

    func run() {
      if values.isEmpty {
        print(0.0)
      } else {
        let sum = values.reduce(0, +)
        let mean = sum / Double(values.count)
        let squaredErrors = values
          .map { $0 - mean }
          .map { $0 * $0 }
        let variance = squaredErrors.reduce(0, +)
        let result = variance.squareRoot()
        print(result)
      }
    }
  }
}
