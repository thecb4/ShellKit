//
//  File 2.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-11 (07).
//

import Foundation

@available(macOS 10.13, *)
extension Process {
  
  public static func process(for command: Command, using shell: Shell.Name) -> Process {
    
    let process = Process()
    
    process.executableURL = URL(fileURLWithPath: shell.path)
    
    process.arguments = ["-c"] + [command.nameAndArguments]

    if !command.environment.isEmpty {
     process.environment = command.environment
    }

    process.currentDirectoryURL = URL(fileURLWithPath: command.workingDirectory)
    
    return process
    
  }
  
}
