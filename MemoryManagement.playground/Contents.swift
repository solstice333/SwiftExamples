//: Playground - noun: a place where people can play

import Cocoa

class Node : CustomStringConvertible {
   var children: [Node] = []
   weak var parent: Node?
   var val: Int
   var description: String { return String(val) }
   init(val : Int = 0) { self.val = val }
}

var root: Node? = Node()
root?.children = [Node(val: 1)]
root?.children[0]
root = nil






