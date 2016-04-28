//: Playground - noun: a place where people can play

import Cocoa

public class Shape {
   
   private var _sides = 0
   
   public init(sides: Int) {
      _sides = sides
   }
   
   public func get_desc() -> String {
      return "A shape with \(_sides) sides."
   }
   
   public func set_sides(sides: Int) {
      _sides = sides
   }
}

var s = Shape(sides: 3)
print(s.get_desc())
s.set_sides(4)
print(s.get_desc())

