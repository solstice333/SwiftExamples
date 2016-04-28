//
//  GeneratePassword.swift
//  RandomPassword
//
//  Created by poky on 2/24/16.
//  Copyright © 2016 poky. All rights reserved.
//

import Foundation

private let charset = [Character](("0123456789" +
   "abcdefghijklmnopqrstuvwxyz" +
   "ABCDEFGHIJKLMNOPQRSTUVWXYZ").characters)

func generateRandomCharacter() -> Character {
   let index = Int(arc4random_uniform(UInt32(charset.count)))
   return charset[index]
}

func generateRandomString(length: Int) -> String {
   var string = ""
   for _ in 0..<length {
      string.append(generateRandomCharacter())
   }
   return string
}