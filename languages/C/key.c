#include "key.h"
#include "convert.h"

// For a given key, return a decimal representation of the
// hexadecimal digit.  This returns a byte at a time and will
// iterate through the key as many times as necessary.
int next_key_byte(char *key, int key_length)
{
    char buf[2];
    static int key_index = 0;
    int i = 0;

    for (i = 0; i < sizeof(buf); i++) {
        if (key_index > (key_length - 1)) { key_index = 0; }

        buf[i] = key[key_index];

        key_index++;
    }

    return hex_to_decimal(buf);
}
