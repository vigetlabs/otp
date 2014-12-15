module encrypter;

import std.string, key_parsing;

class Encrypter : KeyParsing
{
    string message;

    this(string key, string message)
    {
        this.key      = key;
        this.message  = message;
        this.keyIndex = 0;
    }

    string cipherText()
    {
        char[2] buf;
        string  cipherText;
        ubyte[] messageBytes = representation(message);

        foreach(b; messageBytes) {
            sformat(buf, "%02x", b ^ this.nextKeyByte);
            cipherText ~= buf;
        }

        return cipherText;
    }
}