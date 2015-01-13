#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "convert.h"
#include "input.h"
#include "key.h"

int main(int argc, char *argv[])
{
    // argv[0] => "./decrypt"

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
    char *ciphertext       = read_message_from(stdin);

    // cache `ciphertext_length` for later
    int  ciphertext_length = strlen(ciphertext);

    // Allocate memory to store the resulting message -- every byte of the ciphertext
    // is represented as 2 hexadecimal characters (e.g. '61' ^ '0' => 'a'), so allocate
    // half the ciphertext plus room for trailing NUL byte.  This is already
    // NUL-terminated since we are using `calloc`
    char *message  = calloc((ciphertext_length / 2) + 1, sizeof(char));

    // iterators
    int ciphertext_index = 0, message_index = 0, i = 0, next_index = 0;
    char buf[2];


    // Iterate through the ciphertext 2 characters at a time
    for (ciphertext_index = 0; ciphertext_index < ciphertext_length; ciphertext_index+= 2) {
        next_index = ciphertext_index + 1;

        // While there are still a pair of characters to fetch...
        if (next_index <= (ciphertext_length - 1)) {

            // Fill the temporary buffer with the next 2 characters of the ciphertext
            for (i = 0; i < 2; i++) {
                buf[i] = ciphertext[ciphertext_index + i];
            }

            // XOR the ciphertext byte with the key byte and store it in the resulting message
            message[message_index] = hex_to_decimal(buf) ^ next_key_byte(key, key_length);

            message_index++;
        }
    }

    // Print out our decrypted message
    printf("%s", message);

    // Clean up allocated memory (though this would be returned to the OS after we exit)
    free(key);
    free(ciphertext);
    free(message);

    return 0;
}