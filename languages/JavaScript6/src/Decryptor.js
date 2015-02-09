import stream from "stream"
import keyPair from "./keyPair"

class Decryptor extends stream.Transform {

  constructor(key) {
    super()
    this.mask = keyPair(key)
  }

  reveal([ a, b, ...tail ]) {
    // Pull off two hex chars from the ciphertext & two from the key
    let code = parseInt(a + b, 16)

    // Convert both pairs to numbers and XOR them
    let pair = code ^ this.mask.next().value

    // Convert the resulting number to an ASCII character and print it out
    let result = String.fromCharCode(pair)

    return tail.length ? result + this.reveal(tail) : result
  }

  _transform (chunk, encoding, done) {
    var message = this.reveal(chunk.toString())

    this.push(message)

    done()
  }

}

export default Decryptor
