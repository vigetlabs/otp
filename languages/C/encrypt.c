#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "convert.h"
#include "input.h"
#include "key.h"

int main(int argc, char *argv[])
{
    // check to ensure key is present
    if (argc != 2) {
        printf("Usage: %s <key>\n", argv[0]);
        return 1;
    }

    int  key_length = strlen(argv[1]);
    char *key       = calloc(key_length + 1, sizeof(char));

    strncpy(key, argv[1], key_length);

    if (!is_hex_key(key, key_length)) {
        printf("Key must be a hexadecimal string\n");
        return 2;
    }

    // read message text from stdin
    char *message = read_message_from(stdin);

    int message_length = strlen(message);
    char *cipher_text  = calloc((message_length * 2) + 1, sizeof(char));

    int cipher_index = 0, message_index = 0, byte_index = 0;
    char *cipher_byte;

    for (message_index = 0; message_index < message_length; message_index++) {
        cipher_byte = binary_to_hex(message[message_index] ^ next_key_byte(key, key_length));

        for (byte_index = 0; byte_index < 2; byte_index++) {
            cipher_text[cipher_index] = cipher_byte[byte_index];
            cipher_index++;
        }

        free(cipher_byte);
    }

    printf("%s", cipher_text);

    free(key);
    free(cipher_text);

    return 0;
}