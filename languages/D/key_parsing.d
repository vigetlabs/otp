module key_parsing;

import std.conv;

interface KeyParsing
{
    static string key;
    static int keyIndex;

    final ushort nextKeyByte()
    {
        char[2] buf;

        for (int i = 0; i < buf.length; i++) {
            if (keyIndex > (key.length - 1)) { keyIndex = 0; }

            buf[i] = key[keyIndex];
            keyIndex++;
        }

        return buf[0..2].to!ushort(16);
    }
}
