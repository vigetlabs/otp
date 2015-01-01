let keyAt = (string, i) => string[i % string.length]

let keyPair = (key, i) => {
  return parseInt(keyAt(key, i) + keyAt(key, i + 1), 16)
}

export default keyPair
