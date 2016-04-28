// Structures and Classes

import Cocoa

// Vector struct
struct Vector: CustomStringConvertible {
   var _x: Double
   var _y: Double
   
   var length: Double {
      return sqrt(_x*_x + _y*_y)
   }
   
   var description: String {
      return "(\(_x) \(_y))"
   }
   
   var angle: Double {
      return atan2(_y, _x)
   }
   
   init() {
      self.init(x: 0, y: 0)
   }
   
   init(x: Double, y: Double) {
      _x = x; _y = y
   }
   
   func vectorByAddingVectorViaMult(vector: Vector, numberOfTimes times: Int) -> Vector { // external internal: type
      let t = Double(times)
      return Vector(x: _x + vector._x*t, y: _y + vector._y*t)
   }
   
   func vectorByAddingVectorViaLoop(vector: Vector, times: Int) -> Vector {
      var v = self
      for _ in 0..<times {
         v._x += vector._x
         v._y += vector._y
      }
      return v
   }
   
   func vectorByAddingVector(vector: Vector) -> Vector {
      return Vector(x: _x + vector._x, y: _y + vector._y)
   }
}

func +(left: Vector, right: Vector) -> Vector {
   return left.vectorByAddingVector(right)
}

func *(left: Vector, right: Vector) -> Vector {
   return Vector(x: left._x * right._x, y: left._y * right._y)
}

func *(left: Double, right: Vector) -> Vector {
   return Vector(x: left * right._x, y: left * right._y)
}

func *(left: Vector, right: Double) -> Vector {
   return Vector(x: left._x * right, y: left._y * right)
}

func ==(left: Vector, right: Vector) -> Bool {
   return left._x == right._x && left._y == right._y
}

func !=(left: Vector, right: Vector) -> Bool {
   return !(left == right)
}

// Particle class
class Particle {
   var _pos: Vector
   var _vel: Vector
   var _acc: Vector
   
   init(pos: Vector) {
      _pos = pos
      _vel = Vector()
      _acc = Vector()
   }
   
   convenience init() {
      self.init(pos: Vector())
   }
   
   func tick(dt: NSTimeInterval) {
      _vel = _vel + _acc * dt
      _pos = _pos + _vel * dt
      _pos._y = max(0, _pos._y)
   }
}

// Rocket sublcass
class Rocket: Particle {
   let _thrust: Double
   var _thrustTimeRemaining: NSTimeInterval
   let _direction = Vector(x: 0, y: 1)
   var _deploy_parachute = false
   let _parachute_size = Vector(x: 0, y: 9.8)
   
   init(position: Vector, thrust: Double, thrustTime: NSTimeInterval) {
      _thrust = thrust
      _thrustTimeRemaining = thrustTime
      super.init(pos: position)
   }
   
   convenience init(thrust: Double, thrustTime: NSTimeInterval) {
      self.init(position: Vector(), thrust: thrust, thrustTime: thrustTime)
   }
   
   override func tick(dt: NSTimeInterval) {
      if _thrustTimeRemaining > 0 {
         let thrustTime = min(dt, _thrustTimeRemaining)
         let thrustToApply = _thrust * thrustTime
         let thrustForce = _direction * thrustToApply
         _acc = _acc + thrustForce
         _thrustTimeRemaining -= thrustTime
      }
      if _deploy_parachute {
         let upwardForce = _direction * _parachute_size
         _acc = _acc + upwardForce
      }
      if _vel._y < 0 {
         _deploy_parachute = true
      }
      super.tick(dt)
   }
}

// Simulation class
class Simulation {
   var _particles: [Particle] = []
   var _time: NSTimeInterval = 0
   var _gravity: Vector
   
   init(gravity: Vector = Vector(x: 0, y: -9.8)) {
      _gravity = gravity
   }
   
   func addParticle(particle: Particle) {
      _particles.append(particle)
   }
   
   func tick(dt: NSTimeInterval) {
      for particle in _particles {
         particle._acc = particle._acc + _gravity
         particle.tick(dt)
         particle._acc = Vector()
         particle._pos._y
         particle._pos._x
      }
      _time += dt
      
      /*
      // most verbose
      _particles = _particles.filter({ (particle: Particle) -> Bool in
         let live = particle._pos._y > 0.0
         if !live {
            print("Particle terminated at time \(self._time)")
         }
         return live
      })

      // medium verbose
      _particles = _particles.filter({ particle in
         let live = particle._pos._y > 0.0
         if !live {
            print("Particle terminated at time \(self._time)")
         }
         return live
      })
      */
      
      // least verbose
      _particles = _particles.filter({$0._pos._y > 0.0})
   }
}

////////////////////////////////////////////////////////////////
// Vector play

let gravity = Vector(x: 0.0, y: -9.8)
let one_down = Vector(x: 0.0, y: -1)

var twoGs = gravity.vectorByAddingVector(gravity)
print("\(twoGs)")

var foo = gravity.vectorByAddingVectorViaLoop(one_down, times: 2)
foo = gravity.vectorByAddingVectorViaMult(gravity, numberOfTimes: 2)
foo = gravity + gravity + twoGs
twoGs = 2 * gravity
twoGs = gravity * 2

foo = Vector(x: 2, y: 3)
foo.length

foo = Vector(x: 5.5, y: -9.8)
var bar = Vector(x: 5.5, y: -9.8)
foo == bar
foo != bar
foo != twoGs

foo = Vector(x: 1, y: 2)
foo._x
foo._y
foo.angle

////////////////////////////////////////////////////////////////
// Particle play
var p = Particle()
var p2 = Particle()
var p3 = p

p === p2 // identical instance check
p !== p2
p === p3
p !== p3

////////////////////////////////////////////////////////////////
// Simulation test

/*
let simulation = Simulation()

let ball = Particle()
ball._acc = Vector(x: 0, y: 100)
simulation.addParticle(ball)

while simulation._particles.count > 0 && simulation._time < 500 {
   simulation.tick(1.0)
}
*/


////////////////////////////////////////////////////////////////
// Rocket Simulation


let rsim = Simulation()

let rocket = Rocket(thrust: 10.0, thrustTime: 60.0)
rsim.addParticle(rocket)

while rsim._particles.count > 0 && rsim._time < 500 {
   rsim.tick(1)
}



////////////////////////////////////////////////////////////////
// Swift and Objective C
let originalString = "Mavericks Mavericks"
let newString = originalString.stringByReplacingOccurrencesOfString("Mavericks", withString: "Yosemite")

let string = "Howdy"
let objcstring: NSString = string
let swiftstring = objcstring
let swiftstring2 = objcstring as String

let num = 3
let objcnum: NSNumber = num
let swiftnum = objcnum
let swiftnum2 = objcnum as Int

let array = [1, 2, 4, 8]
let objcarr: NSArray = array
let swiftarr = objcarr
let swiftarr_unsafe = objcarr as! [Int]  // as! for forced cast
let strings: [NSString] = ["foo", "1", "bar"]
let swiftarr_safe = strings as? [String] // if change [String] to [Int] the compiler catches it

let procinfo = NSProcessInfo()
for (k, v) in procinfo.environment { // as? [String:String] { // no need to cast apparently
   print("\(k) : \(v)")
}

////////////////////////////////////////////////////////////////
// Classes and Structures play

// structures are pass by value
// structures have a default memberwise initializer
// structures do NOT support inheritance
// structures do NOT have convenience inits
struct Foo {
   var x: Int
   var y = 2 // default value for one property will force client to init all members
}

var f = Foo(x: 3, y: 2)

// classes are pass by ref
// classes have NO default memberwise initializer (i.e. if default values are set for stored props, a default init is given, otherwise a user defined init is required)
// classes support inheritances
// classes have convenience inits
class Bar {
   var x: Int
   var y: Int
   
   init(x: Int, y: Int) {
      self.x = x
      self.y = y
   }
}

var b = Bar(x: 5, y: 6)

////////////////////////////////////////////////////////////////
// Properties play

struct FixedLengthRange {
   var firstValue: Int
   let length: Int
}

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
// rangeOfFourItems.firstValue = 6 // compile time error since const. 
                                   // This does not apply to classes since they are reference types

// lazy modifier test
class LazyGuy {
   var iamlazy: String {
      print("fine, i'll do it")
      return "fine, i'll do it"
   }
}

class LazyGuyManager {
   lazy var lg = LazyGuy()
   var i = 3
}

var lgm = LazyGuyManager()
print("initialized LazyGuyManager")
lgm.i
lgm.lg.iamlazy

struct ComputedProp: CustomStringConvertible {
   var _num: Int
   
   var prop: Int {
      get {
         return _num
      }
      set (val) {
         _num = val
      }
   }
   
   var prop2: Int {
      get {
         return _num
      }
      set {
         _num = newValue // newValue is an implicit alias to the rvalue
      }
   }
   
   var prop3: Int {
      return _num // getter shortcut
   }
   
   var description: String {
      return "num: \(_num), prop: \(prop)"
   }
}

var cp = ComputedProp(_num: 5)
cp.prop = 10
cp.prop2 = 20
cp.prop
cp.prop2
cp.prop3

class StepCounter : CustomStringConvertible {
   var totalSteps: Int = 0 {
      willSet(newSteps) {
         print("About to set totalSteps to \(newSteps)") // newValue default implicit
      }
      didSet(prevSteps) { // oldValue default implicit
         if totalSteps > prevSteps {
            print("Added \(totalSteps - prevSteps) steps")
         }
      }
   }
   
   var description: String {
      return "\(totalSteps)"
   }
}

var stepcounter = StepCounter()
stepcounter.totalSteps = 200
stepcounter.totalSteps = 360
stepcounter.totalSteps = 896

// small inout test
func add_10_steps(inout sc: StepCounter) {
   sc.totalSteps += 10
}

add_10_steps(&stepcounter)
print(stepcounter)

// global test which is implicitly lazy
var computed_var_global: Int =  10 {
   willSet {
      print("computed_var_global: about to set \(newValue)")
   }
}

print("before computed_var_global")
computed_var_global
computed_var_global = 20

// test type properties
struct SomeStructure {
   static var storedTypeProperty = "Some value."
   static var computedTypeProperty: Int {
      return 1
   }
}

enum SomeEnumeration {
   static var storedTypeProperty = "Some value."
   static var computedTypeProperty: Int {
      return 6
   }
}

class SomeClass {
   static var storedTypeProperty = "Some value."
   static var computedTypeProperty: Int {
      return 27
   }
   class var overrideableComputedTypeProperty: Int { // overridable by subclasses
      return 107
   }
}

print(SomeStructure.storedTypeProperty)
print(SomeStructure.computedTypeProperty)

print(SomeEnumeration.storedTypeProperty)
print(SomeEnumeration.computedTypeProperty)

print(SomeClass.storedTypeProperty)
print(SomeClass.computedTypeProperty)
print(SomeClass.overrideableComputedTypeProperty)

struct AudioChannel {
   static let thresholdLevel = 10
   static var maxInputLevelForAllChannels = 0
   
   var currentLevel = 0 {
      didSet {
         if currentLevel > AudioChannel.thresholdLevel {
            currentLevel = AudioChannel.thresholdLevel
         }
         if currentLevel > AudioChannel.maxInputLevelForAllChannels {
            AudioChannel.maxInputLevelForAllChannels = currentLevel
         }
      }
   }
}

var left = AudioChannel()
var right = AudioChannel()

left.currentLevel = 7
print(left.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

right.currentLevel = 11
print(right.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)


////////////////////////////////////////////////////////////////
// Methods play

class Counter : CustomStringConvertible {
   var count = 0
   
   var description: String {
      return "\(count)"
   }
   
   func increment() {
      ++count
   }
   
   func incrementBy(amount: Int, _ numberOfTimes: Int = 1) { // underscore external name means there's no external label
      count += amount * numberOfTimes
   }
   
   func reset() {
      count = 0
   }
}

let cnt = Counter()
cnt.increment()
cnt.incrementBy(5, 2)
cnt.reset()

// mutating example for value types : structs
struct Point : CustomStringConvertible {
   var x = 0.0, y = 0.0
   var description: String {
      return "(\(x), \(y))"
   }
   
   mutating func moveBy(deltaX: Double, deltaY: Double) { // modify stored props (instance vars)
      x += deltaX
      y += deltaY
   }
   
   mutating func moveBy(delta: Point) { // create entirely new instance
      self = Point(x: x + delta.x, y: y + delta.y)
   }
}

var pnt = Point()
pnt.moveBy(3.5, deltaY: 2.1)
let fixedPnt = Point()
// fixedPnt.moveBy(1.4, deltaY: 1.5) // illegal because const
pnt.moveBy(Point(x: 1, y: 2))

// mutating example for value types: enums
enum TriStateSwitch {
   case Off, Low, High
   mutating func next() {
      switch self {
         case Off:
            self = Low
         case Low:
            self = High
         case High:
            self = Off
      }
   }
}

var tsw: TriStateSwitch = .Off
tsw.next()

// static/class method
class SomeClassToTestTypeMethod {
   class func typeMethod() {
      self.printSomething() // self refers to type in a static/class method
   }
   
   class func printSomething() {
      print("typeMethod")
   }
}

SomeClassToTestTypeMethod.typeMethod()

// LevelTracker and Player test
struct LevelTracker : CustomStringConvertible {
   static var highestUnlockedLevel = 1
   static func unlockLevel(level: Int) {
      if level > highestUnlockedLevel {
         highestUnlockedLevel = level
      }
   }
   static func levelIsUnlocked(level: Int) -> Bool {
      return level <= highestUnlockedLevel
   }
   
   var currentLevel = 1
   var description: String {
      return "\(currentLevel)"
   }
   mutating func advanceToLevel(level: Int) -> Bool {
      if level <= LevelTracker.highestUnlockedLevel {
         currentLevel = level
         return true
      }
      else {
         return false
      }
   }
}

class Player {
   var tracker = LevelTracker()
   let playerName: String
   
   init(playerName: String) {
      self.playerName = playerName
   }
   
   func completedLevel(level: Int) {
      LevelTracker.unlockLevel(level + 1)
      tracker.advanceToLevel(level + 1)
   }
}

let player1 = Player(playerName: "player1")
player1.completedLevel(1)
player1.tracker.advanceToLevel(2)

let player2 = Player(playerName: "player2")
player2.completedLevel(1)
player2.tracker.advanceToLevel(3)


////////////////////////////////////////////////////////////////
// Initialization play

class Animal: CustomStringConvertible {
   var legs: Int = 0
   var description: String { return "\(legs) legs" }
   
   init() {}
   init(legs: Int) { self.legs = legs }
   func speak() { print("animal sounds") }
   func play() { print("animal playing") }
}

// either define none of the superclass designated inits or all of them to inherit the superclass inits
class Dog: Animal {
   var friendly: Bool = true
   override var description: String { return "friendly: \(friendly)" }
   override init() { super.init(legs: 4) }
   override func speak() { print("woof woof") }
   // func play() { print("rolling over!") } // forced to use override
}

var buckie = Dog()
buckie.speak()
var animal = buckie
animal.speak()

// failable init
struct FailableInitTest {
   var foo: String
   
   init?(foo: String) {
      if foo.isEmpty {
         return nil
      }
      self.foo = foo
   }
}

if let fit = FailableInitTest(foo: "") {
   print("init succeeded")
}
else {
   print("init failed")
}

// failable enum
enum FailableInitEnum : CustomStringConvertible {
   case A, B
   var description: String {
      switch self {
      case .A:
         return "A"
      case .B:
         return "B"
      }
   }
   
   init?(sym: String) {
      switch sym {
         case "A":
            self = .A
         case "B":
            self = .B
         default:
            return nil
      }
   }
}

if let fie = FailableInitEnum(sym: "C") {
   print("init succeeded")
}
else {
   print("init failed")
}

if let fie = FailableInitEnum(sym: "B") {
   print("fie is \(fie)")
}

// default init?
enum Temp: Character {
   case K = "K"
   case F = "F"
   case C = "C"
}

if let t = Temp(rawValue: "K") {
   print("temperature in units Kelvin")
}
if Temp(rawValue: "X") == nil {
   print("invalid rawValue")
}

// failing init delegation up
class Product {
   var name: String
   
   init?(name: String) {
      self.name = name
      if name.isEmpty { return nil } // apparently you gotta initialize all stored props first before you can return nil
   }
}

class CartItem: Product {
   let quantity: Int
   
   override init(name: String) { // can override failable init with non-failable init, but not the other way around
      self.quantity = 1
      let n = name.isEmpty ? "NUGGIES" : name
      super.init(name: n)!
   }
   
   init?(name: String, quantity: Int) {
      self.quantity = quantity
      super.init(name: name)
      if quantity < 1 { return nil }
   }
}

assert(Product(name: "") == nil, "expect nil")
assert(Product(name: "foo") != nil, "expect no nil")
assert(CartItem(name: "foo", quantity: 1) != nil, "expect no nil")
assert(CartItem(name: "", quantity: 1) == nil, "expect nil")
assert(CartItem(name: "foo", quantity: 0) == nil, "expect nil")


// required
class FooClass {
   required init() { print("entered required init") }
}

class FooSubClass: FooClass {
   // required init is inherited here. required keyword tells the compiler
   // that the init needs to be implemented
}

var fsc = FooSubClass()

// setting default property with closure or function

class FooClass2 {
   var someprop: Int = {
      var x = 1 + 2
      return x
   }() // curly brace at the end means you're not assigning a pointer to a closure, but rather the return value
}

var fc2 = FooClass2()
fc2.someprop

struct CheckerBoard {
   var tempboard: [Bool] = {
      var isBlack = false
      var tb: [Bool] = []
      
      for row in 1...8 {
         for col in 1...8 {
            tb.append(isBlack)
            isBlack = !isBlack
         }
         isBlack = !isBlack
      }
      return tb
   }()
   
   func isSquareBlackAtRow(row: Int, col: Int) -> Bool {
      return tempboard[8 * row  + col]
   }
   
   func printBoard() {
      for row in 0..<8 {
         for col in 0..<8 {
            let x = tempboard[8 * row + col] ? "b" : "w"
            print(x, terminator: "")
         }
         print("")
      }
   }
}

let board = CheckerBoard()
board.isSquareBlackAtRow(0, col: 1)
board.isSquareBlackAtRow(0, col: 2)
board.isSquareBlackAtRow(7, col: 7)
board.printBoard()











