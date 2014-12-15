module utility;

import std.ascii;

class Utility
{
    static bool isHexadecimal(string text)
    {
        bool isHex = true;

        foreach(c; text) {
            isHex = isHex && isHexDigit(c);
        }

        return isHex;
    }
}