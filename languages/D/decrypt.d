module decrypt;

import std.stdio;
import decrypter, utility;

int main(string[] args)
{
    string message, key;

    if (args.length != 2) {
        writefln("Usage: %s <key>", args[0]);
        return 1;
    }

    key = args[1];

    if (!Utility.isHexadecimal(key)) {
        writeln("Key must be a hexadecimal string");
        return 2;
    }

    string cipherText;
    readf(" %s", &cipherText);

    auto decrypter = new Decrypter(key, cipherText);

    write(decrypter.message);

    return 0;
}