import std.stdio, std.conv;

int main(string[] args)
{
    string message, key;
    char[2] charBuf;
    int keyIndex = 0;

    if (args.length != 2) {
        writefln("Usage: %s <key>", args[0]);
        return 1;
    }

    key = args[1];

    string cipherText;
    readf(" %s", &cipherText);

    for (int i = 0; i < cipherText.length; i+= 2) {
        // we have a single byte char from the cipher text, get the key that we'll use to XOR
        for (int bufIndex = 0; bufIndex < charBuf.length; bufIndex++) {
            if (keyIndex > (key.length - 1)) { keyIndex = 0; }

            charBuf[bufIndex] = key[keyIndex];
            keyIndex++;
        }

        // charBuf now holds a single hex byte
        ushort keyByte = charBuf[0..2].to!ushort(16);

        ulong rangeEnd = i + 2;
        if (rangeEnd > cipherText.length) { rangeEnd = cipherText.length; }

        string slice = cipherText[i..rangeEnd]; // slice contains the hexadecimal representation as a string

        try {
            ushort charByte = slice.to!ushort(16);
            message ~= (charByte ^ keyByte).to!char();
        } catch (ConvException) {
            // NOOP, continue
        }
    }

    write(message);

    return 0;
}