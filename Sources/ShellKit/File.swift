//
//  File.swift
//  
//
//  Created by Cavelle Benjamin on 20-Feb-10 (07).
//

extension String {
  public var isAbsolute: Bool {
    if let first = self.first, first == "/" {
      return true
    } else {
      return false
    }
  }
}
