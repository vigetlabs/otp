#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "convert.h"
#include "input.h"
#include "key.h"

int main(int argc, char *argv[])
{
    // argv[0] => "./encrypt"

    // check to ensure key is present
    if (argc != 2) {
        printf("Usage: %s <key>\n", argv[0]);
        return 1;
    }

    // argv[1] => "d34db33f"

    // Fetch the key from arguments and allocate memory to store the key plus
    // the trailing NUL byte
    int  key_length = strlen(argv[1]);
    char *key       = calloc(key_length + 1, sizeof(char));

    // Copy `key_length` chars from argument into `key` -- the use of `calloc`
    // means that `key` is already NUL-terminated
    strncpy(key, argv[1], key_length);

    // Ensure the chars in `key` are all valid hexadecimal digits (e.g. 0-9,A-F,a-f).
    // This is case-insensitive
    if (!is_hex_key(key, key_length)) {
        printf("Key must be a hexadecimal string\n");
        return 2;
    }

    // read message text from stdin
    char *message = read_from(stdin);

    // Cache `message_length` for later
    int message_length = strlen(message);

    // Allocate memory to store the ciphertext -- each message character will
    // correspond with 2 hexadecimal characters (e.g. 'a' ^ 0 => 61), so allocate
    // double the message plus room for trailing NUL byte.  This is already
    // NUL-terminated since we are using `calloc`
    char *ciphertext  = calloc((message_length * 2) + 1, sizeof(char));

    // iterators
    int cipher_index = 0, message_index = 0, byte_index = 0;
    char *cipher_byte;

    for (message_index = 0; message_index < message_length; message_index++) {
        // Take the next char in the message message (`message[message_index]`) and XOR this with
        // the next byte in the key supplied in the commandline arguments.  Since ASCII chars are
        // stored as integers, you can XOR without conversion.  Convert the resulting decimal
        // number into its hexadecimal equivalent.
        cipher_byte = decimal_to_hex(message[message_index] ^ next_key_byte(key, key_length));

        // At this point, `cipher_byte` will be a NUL-terminated string of length 2, containing
        // the hexadecimal digits.  Append these characters to the end of `ciphertext`.
        for (byte_index = 0; byte_index < strlen(cipher_byte); byte_index++) {
            ciphertext[cipher_index] = cipher_byte[byte_index];
            cipher_index++;
        }

        // Since `cipher_byte` is allocated from the heap, we need to free this
        // between iterations
        free(cipher_byte);
    }

    // Print our ciphertext
    printf("%s", ciphertext);

    // Clean up allocated memory (though this would be returned to the OS after we exit)
    free(key);
    free(ciphertext);
    free(message);

    return 0;
}