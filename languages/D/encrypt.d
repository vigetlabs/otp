import std.conv, std.string, std.stdio;

int main(string[] args)
{
    string message, key, cipherText;

    char[2] charBuf;
    ushort[] keyBytes;
    int keyIndex = 0;

    // TODO: ensure key is hexadecimal
    if (args.length != 2) {
        writefln("Usage: %s <key>", args[0]);
        return 1;
    }

    key = args[1];

    // read message from STDIN
    readf(" %s", &message);
    ubyte[] messageBytes = representation(message);

    foreach(b; messageBytes) {
        // we have a single byte char from the message, get the key that we'll use to XOR
        for (int i = 0; i < charBuf.length; i++) {
            if (keyIndex > (key.length - 1)) { keyIndex = 0; }

            charBuf[i] = key[keyIndex];
            keyIndex++;
        }

        // charBuf now holds a single hex byte
        ushort charByte = charBuf[0..2].to!ushort(16);

        sformat(charBuf, "%x", b ^ charByte);
        cipherText ~= charBuf;
    }

    write(cipherText);

    return 0;
}