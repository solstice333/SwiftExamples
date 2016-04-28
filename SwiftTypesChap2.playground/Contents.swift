// Chapter 2: Swift Types

import Cocoa

var str = "Hello, playground"
str = "Hello, Swift"
let constStr = str

var nextYear: Int
var bodyTemp: Float
var myMoney: Double
var hasPet: Bool

hasPet = true

var arrayOfInts: [Int]
var dictionaryOfCapitalsByCountry: [String:String]
var winningLotteryNumbers: Set<Int>

let number = 42
let fmStation = 91.1

var countingUp = ["one", "two"]
let nameByParkingSpace = [13: "Alice", 27: "Bob"]
let secondElement = countingUp[1]

arrayOfInts = [Int]()
arrayOfInts.append(0)
arrayOfInts.append(1)

let defaultNumber = Int()
let defaultBool = Bool()

let meaningOfLife = String(number)
let availableRooms = Set([205, 411, 412])

let defaultFloat = Float()
let floatFromLiteral = Float(3.14)
let easyPi = 3.14
let floatFromDouble = Float(easyPi)
let floatingPi: Float = 3.14

var emptyString = ""
emptyString.isEmpty
emptyString = "foo"
emptyString.isEmpty

countingUp.count

countingUp.append("three")
let countingDown = countingUp.reverse()

var reading1: Float?
var reading2: Float?
var reading3: Float?

reading1 = 9.8
reading2 = 9.2
reading3 = 9.7

let avgReading = (reading1! + reading2! + reading3!) / 3

if let r1 = reading1,
let r2 = reading2,
let r3 = reading3 {
    let avgReading = (r1 + r2 + r3) / 3
}
else {
    let errorString = "Instrument reported a reading that was nil."
}

if let spaceAssignee: String? = nameByParkingSpace[13] {
    print("Key 13 was in the dictionary!")
}

for var i = 0; i < countingUp.count; i++ {
    let string = countingUp[i]
    print("\(string)")
}

for i in 0..<countingUp.count {
    let string = countingUp[i]
    print("\(string)")
}

for string in countingUp {
    print("\(string)")
}

for (i, string) in countingUp.enumerate() {
    print("(\(i), \(string))")
}

for (space, name) in nameByParkingSpace {
    let permit = "Space \(space): \(name)"
}

enum Pie: Int {
    case Apple
    case Strawberry = 30
    case Blueberry
}

var piesToBake: [Pie] = []
piesToBake.append(.Apple)
piesToBake.append(.Strawberry)

var name: String
let favoritePie = Pie.Strawberry
switch favoritePie {
case .Apple:
   name = "Apple"
   fallthrough
case .Blueberry:
   name = "Blueberry"
case .Strawberry:
   name = "Strawberry"
}

let osxVersion: Int = 10
switch osxVersion {
case 0...8:
   print("A big cat")
case 9:
   print("Mavericks")
case 10:
   print("Yosemite")
default:
   print("Greetings, people of the future! What's new in 10.\(osxVersion)?")
}

var pieRawValue = Pie.Apple.rawValue
if let pieType = Pie(rawValue: pieRawValue) {
    print("valid pie type")
}

pieRawValue = Pie.Blueberry.rawValue
pieRawValue = Pie.Strawberry.rawValue
let pieType = Pie(rawValue: 20)


// Going over official swift doc

// The Basics

var x = 3, y = 5, z = 7
var welcomeMsg: String

welcomeMsg = "Hello"

var red, green, blue: (Int, Int, Int)
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)

print("red color is \(red)", terminator: "")
print(" while blue is \(blue)")

let sintmax = Int.max
let sintmin = Int.min

let uintmax = UInt.max
let uintmin = UInt.min

let over_9000 = 9_000

let twoThous: UInt16 = 2_000
let one: UInt8 = 1
let twoThousAndOne = twoThous + UInt16(one) // type conv

let three = 3
let pointAfter = 0.14159
let pi = Double(three) + pointAfter // int to double conv

let integerPi = Int(pi) // double to int conv

typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min

let i = 1
if i == 1 {
    print("note that conditions MUST eval to type Bool")
}

let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error

print("Status code is \(statusCode)")
print("Status message is \(statusMessage)")

let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")

print("Status code is \(http404Error.0)")
print("Status message is \(http404Error.1)")

let http200Status = (statusCode: 200, description: "OK")
print("Status code is \(http200Status.statusCode)")
print("Status message is \(http200Status.description)")

let numstr1 = "1241"
let numstr2 = "456"

if var convnum1 = Int(numstr1),
var convnum2 = Int(numstr2) where convnum1 > convnum2 {
   print("Greater converted number is \(convnum1)")
}
else if var convnum1 = Int(numstr1),
var convnum2 = Int(numstr2) where convnum1 <= convnum2 {
   print("Greater converted number is \(convnum2)")
}
else {
   print("Something couldn't be converted to a number")
}

var serverResponseCode: Int? = 404
serverResponseCode = nil

let possibleString: String? = "An optional string."
let forcedString = possibleString!

let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString

enum CantError: ErrorType {
   case OutOfCleanDishes
   case MissingIngredients
   case LazyAsHell
}

func makeASandwich(type: CantError? = nil) throws -> String {
   if let type = type {
      throw type
   }
   return "Making a yummy sandwich"
}

let errorToTry = CantError.LazyAsHell
do {
   let doit = try makeASandwich(errorToTry)
}
catch CantError.OutOfCleanDishes {
   print("Wash dishes")
}
catch CantError.MissingIngredients {
   print("Buy groceries")
}
catch {
   print("You must be a lazy mofo")
}

let age = 3
assert(age >= 0, "A person's age cannot be negative") // msg can be omitted


// Basic Operators

// &+, &-, &* overflow operators
var someMaxVal = UInt8.max
someMaxVal = someMaxVal &+ 1

let defaultColorName = "blue"
var userDefinedColorName: String? = "red"
var colorNameToUse = userDefinedColorName ?? defaultColorName
colorNameToUse = userDefinedColorName != nil ? userDefinedColorName! : defaultColorName

for i in 1...3 {i}   // closed (everything inclusive)
for i in 1..<3 {i}   // half-open (include first, exclude last)


// Strings and Characters

let dog = "Buckie!"
for c in dog.characters {
   print(c, terminator: "")
}
print("")

let dog_arr = [Character](dog.characters)
var dog_str = String(dog_arr)
let more_dog = dog_str + " and " + dog
var more_more_dog = "\(more_dog) and \(dog)"
more_more_dog += "!"
more_more_dog.append(Character("!"))
more_more_dog += "\u{1f425}"

var kevin_and_drea = "Kevin \u{1f496} Drea \u{2665}"

kevin_and_drea[kevin_and_drea.startIndex]
kevin_and_drea[kevin_and_drea.endIndex.predecessor()]
kevin_and_drea[kevin_and_drea.startIndex.successor()]
kevin_and_drea[kevin_and_drea.startIndex.advancedBy(2)]

for i in kevin_and_drea.characters.indices {
   print(kevin_and_drea[i], terminator: " ")
}

kevin_and_drea.insert("\u{1f496}",
   atIndex: kevin_and_drea.startIndex.advancedBy(5))

dog_str.insertContentsOf("cckk".characters,
   at: dog_str.startIndex.advancedBy(3))

dog_str.removeAtIndex(dog_str.endIndex.predecessor())
dog_str

let range =
   dog_str.startIndex.advancedBy(3)...dog_str.endIndex.advancedBy(-4)
dog_str.removeRange(range)

dog_str.hasPrefix("Buc")
dog_str.hasSuffix("kie")


// Collection Types

// arrays
var arrDecl: [Int]
var arrInit = [Int]()
var arrInit2: [Int] = []
var arrInit3 = [1, 2, 3]

var intArr: [Int]
intArr = []
intArr.isEmpty

var strArr = [String]()
strArr.append("foo")

var blockzero = [Int](count: 3, repeatedValue: 0)
var addzeroes = [Int](count: 3, repeatedValue: 0)
blockzero += addzeroes

var shoppingList = ["Eggs", "Milk"]
for i in 0..<shoppingList.count {i}
for i in shoppingList {i}
shoppingList.append("Meat")
shoppingList += ["Nuggies", "Hummus"]
shoppingList[1...3] = ["Beef", "Salmon"]
shoppingList
shoppingList.insert("Chicken", atIndex: 1)
shoppingList.removeAtIndex(2)
shoppingList
shoppingList.removeLast()
shoppingList
shoppingList.popLast()
shoppingList
shoppingList.removeFirst()
shoppingList += ["Nuggies"]

// stack
shoppingList.append("Salmon")
var popped = shoppingList.popLast()
shoppingList

// queue
shoppingList.append("Eggs")
popped = shoppingList.removeFirst()
shoppingList

print("")
for (priority, item) in shoppingList.enumerate() {
   print("Item \(priority + 1): \(item)")
}

let itemToLookFor = "Nuggies"
if shoppingList.contains(itemToLookFor) {
   print("Found \(itemToLookFor) in shopping list")
}


// set
var setDecl: Set<String>
var setInit = Set<String>()
var setInit2: Set<String> = []
var setInit3: Set = ["foo", "bar", "baz"]

var letters = Set<Character>()
letters.insert("a")
letters = []

var favoriteGenres: Set = ["Rock", "Indie", "Pop"]
favoriteGenres.count
favoriteGenres.isEmpty
favoriteGenres.insert("Epic")

if let removed = favoriteGenres.remove("Pop") {
   print("removed \(removed)")
}

favoriteGenres.contains("Epic")
for g in favoriteGenres {g}
for g in favoriteGenres.sort() {g}
let odds: Set = [1, 3, 5]
let evens: Set = [2, 4, 6]
let primes: Set = [2, 3, 5, 7]
odds.union(evens).sort()
odds.intersect(evens).sort()
odds.subtract(primes).sort()
odds.exclusiveOr(primes).sort()

let someodds: Set = [1]
odds == evens
odds.isSubsetOf(primes)
odds.isSupersetOf(someodds)
someodds.isSubsetOf(odds)
odds.isSubsetOf(odds)
odds.isSupersetOf(odds)
odds.isStrictSubsetOf(odds)
odds.isStrictSupersetOf(odds)
odds.isDisjointWith(evens)
odds.isDisjointWith(primes)


// dictionary
var htDecl: [String:String]
var htInit = [String:String]()
var htInit2: [String:String] = [:]
var htInit3 = ["foo":"foo", "bar":"bar"]

var namesOfIntegers = [Int:String]()
namesOfIntegers[16] = "sixteen"
namesOfIntegers.isEmpty
namesOfIntegers = [:]
namesOfIntegers.isEmpty

var airports = ["SJC":"San Jose International", "ONT":"Ontario International"]
airports.count
airports["LHR"] = "London"
airports["LHR"] = "London Heathrow"
airports

let airport = "SJC"
if let old = airports.updateValue("San Jose Mineta International", forKey: airport) {
   print("\(old) changed to \(airports[airport]!)")
}

airports["LHR"] = nil
airports.count
print(airports)

let rm_airport = "ONT"
if let removedValue = airports[rm_airport] {
   airports[rm_airport] = nil
   print("removed \(removedValue)")
}
else {
   print("\(rm_airport) never existed")
}

airports

airports["ONT"] = "Ontario International"

for (code, name) in airports {
   print("\(code) - \(name)")
}

for code in airports.keys {
   print("\(code)")
}

for name in airports.values {
   print("\(name)")
}

let codes = [String](airports.keys.sort())
let names = [String](airports.values.sort())



















