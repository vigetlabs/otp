function decrypt(cipherText, key) {
  // split the cipher text into pairs of characters
  var cipherPairs = cipherText.match(/.{1,2}/g);
  var keyChars    = key.split('');

  return cipherPairs
    .map(function(val) {
      var h1, h2, encodedChar, hexChar;

      // get the next two characters of the hex key
      h1 = keyChars.shift();
      h2 = keyChars.shift();

      // calculate decimal number from encoded ascii bits
      encodedChar = parseInt(val, 16);

      // calculate decimal number from key bits
      hexChar = parseInt(h1 + h2, 16);

      // return the characters to the array for looping
      keyChars.push(h1, h2);

      // XOR the encoded char with the hex char, convert to characters
      return strfchar(encodedChar ^ hexChar);
    }).join('');
}

function strfchar(code) {
  var cache = {};
  return cache[code] || (cache[code] = String.fromCharCode(code));
}

module.exports = decrypt;
