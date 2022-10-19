//
//  SMBStrings.swift
//  SMB
//
//  Created by Vinoth on 22/09/20.
//  Copyright © 2020 NOVIS. All rights reserved.
//

import Foundation

extension String {
    func applyPatternOnNumbers(pattern: String, replacmentCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex  = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacmentCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
  
  func camelCaseString() -> String {
    return unicodeScalars.reduce("") {
      if CharacterSet.uppercaseLetters.contains($1) {
        return ($0 + " " + String($1))
      }
      else {
        return $0 + String($1)
      }
    }
  }
  var trim:String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  var cusEmpty : Bool {
    if self.isEmpty  { return false }
    return self.trim.count == 0
  }
}
