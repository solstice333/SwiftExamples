//: Playground - noun: a place where people can play

import Cocoa

var d = NSDate()
var i = NSNumber(integer: 65)
i.integerValue
i.charValue
i.boolValue
var s = NSString(format: "foo%d", 3)
s = NSString(string: "hello")

var x: NSInteger = 0
var n = NSScanner(string: "5")
n.scanInteger(&x)
var y: Int = x

