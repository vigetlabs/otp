// otp.swift

import Foundation

func validateInputAndExtractKeyOrExit(arguments: [String]) -> String {
    if arguments.count != 2 {
        println("Usage: \(arguments[0]) <key>")
        exit(1)
    }

    let key = arguments[1]

    let validKeyMatch = key.rangeOfString("^[0-9a-f]*$", options: .RegularExpressionSearch)

    if validKeyMatch == nil {
        println("Key must be a hex string of 0-9a-f")
        exit(2)
    }

    return key
}

func chomp(input: String?) -> String {
    if let string = input {
        return string.stringByTrimmingCharactersInSet(NSCharacterSet.newlineCharacterSet())
    }
    return ""
}

// Produces a function that returns the "next pair" of characters from key,
// wrapping when it reaches the end of the string.
func key(string: String) -> (() -> (Character, Character)) {
    let chars = Array(string.lowercaseString)
    var index = 0

    func nextPair() -> (Character, Character) {
        return (chars[index++ % chars.count], chars[index++ % chars.count])
    }

    return nextPair;
}

func hexToInt(hex: Character) -> Int {
    switch(hex) {
    case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
        return String(hex).toInt()!
    case "a", "A": return 10
    case "b", "B": return 11
    case "c", "C": return 12
    case "d", "D": return 13
    case "e", "E": return 14
    case "f", "F": return 15
    default: return 0
    }
}

func hexPairToInt(pair: (Character, Character)) -> Int {
    let (a, b) = pair
    return 16 * hexToInt(a) + hexToInt(b)
}

func intToHexString(int: Int) -> String {
    return String(format: "%2x", int)
}

func intToString(int: Int) -> String {
    return String(UnicodeScalar(int))
}

func characterToInt(char: Character) -> Int {
    let string = String(char)
    let index = string.unicodeScalars.startIndex
    let scalar = string.unicodeScalars[index]
    return Int(scalar.value)
}

func xor(text: Character, pad: (Character, Character)) -> Int {
    let textValue = characterToInt(text)
    let padValue = hexPairToInt(pad)
    return textValue ^ padValue
}

func xor(text: (Character, Character), pad: (Character, Character)) -> Int {
    let textValue = hexPairToInt(text)
    let padValue = hexPairToInt(pad)
    return textValue ^ padValue
}
