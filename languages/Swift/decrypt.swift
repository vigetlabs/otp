import Foundation

let key = validateInputAndExtractKeyOrExit(Process.arguments)

let ciphertextData = NSFileHandle.fileHandleWithStandardInput().availableData
let ciphertext = chomp(NSString(data: ciphertextData, encoding: NSUTF8StringEncoding))
let ciphertextArray = Array(ciphertext)

let nextKeyPair = key(key)
var ciphertextPairs = [(Character, Character)]()
var i = 0

while (i < ciphertextArray.count) {
    var pair: (Character, Character)

    if (i < ciphertextArray.count - 1) {
        pair = (ciphertextArray[i++], ciphertextArray[i++])
    } else {
        // Only one character left
        pair = (ciphertextArray[i++], Character(""))
    }

    ciphertextPairs.append(pair)
}

let result = ciphertextPairs.reduce("", { (string, cipherPair) in
    return string + intToString(xor(cipherPair, nextKeyPair()))
})

print(result)

