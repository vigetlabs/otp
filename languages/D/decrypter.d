module decrypter;

import std.conv, key_parsing;

class Decrypter : KeyParsing
{
    string cipherText;

    this(string key, string cipherText)
    {
        this.key        = key;
        this.cipherText = cipherText;
    }

    ushort[] cipherTextBytes()
    {
        ushort[] bytes;
        ulong    rangeEnd;
        string   slice;

        for (int i = 0; i < cipherText.length; i+= 2) {
            rangeEnd = i + 2;
            if (rangeEnd > cipherText.length) { rangeEnd = cipherText.length; }

            slice = cipherText[i..rangeEnd];

            try {
                bytes ~= slice.to!ushort(16);
            } catch (ConvException) {
                // NOOP
            }
        }

        return bytes;
    }

    string message()
    {
        string message;

        foreach(b; this.cipherTextBytes) {
            message ~= (b ^ this.nextKeyByte).to!char();
        }

        return message;
    }

}
