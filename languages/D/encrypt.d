import std.stdio;
import encrypter, utility;

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

    // read message from STDIN
    readf(" %s", &message);
    auto encrypter = new Encrypter(key, message);

    write(encrypter.cipherText);

    return 0;
}