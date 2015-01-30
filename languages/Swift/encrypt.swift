import Foundation

let key = validateInputAndExtractKeyOrExit(Process.arguments)

let plaintextData = NSFileHandle.fileHandleWithStandardInput().availableData
let plaintext = chomp(NSString(data: plaintextData, encoding: NSUTF8StringEncoding))

let nextKeyPair = key(key)

let result = Array(plaintext).reduce("", { (string, char) in
    string + intToHexString(xor(char, nextKeyPair()))
})

print(result)
