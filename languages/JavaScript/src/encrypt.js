function encrypt(message, key) {
  var keyChars = key.split('');

  return message.split('')
    .map(function(val) {
      var h1, h1, asciiChar, hexChar;

      // get the next two characters in the key
      h1 = keyChars.shift();
      h2 = keyChars.shift();

      // get number from ascii character
      asciiChar = val.charCodeAt();

      // calculate decimal number from key bits
      hexChar = parseInt(h1 + h2, 16);

      // return the characters to the array for looping
      keyChars.push(h1, h2);

      // XOR the ascii number with the hex number, and convert to hex
      return (asciiChar ^ hexChar).toString(16);
    }).join('');
}

module.exports = encrypt;
