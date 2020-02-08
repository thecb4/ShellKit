//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Feb-08 (06).
//

//typealias Arguments = [String]

struct Command {
  
  typealias Arguments = [String]
  
  public let name: String
  public let arguments: ShellAguments
  public let environment: ShellEnvironment?
  public let emoji: String?
  public let echoString: String?
  public let directory: String
}
