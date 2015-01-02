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
    char *ciphertext       = read_message_from(stdin);
    int  ciphertext_length = strlen(ciphertext);

    char *message  = calloc((ciphertext_length / 2) + 1, sizeof(char));

    int ciphertext_index = 0, message_index = 0, i = 0, next_index = 0;
    char buf[2];

    for (ciphertext_index = 0; ciphertext_index < ciphertext_length; ciphertext_index+= 2) {
        next_index = ciphertext_index + 1;

        if (next_index <= (ciphertext_length - 1)) {
            for (i = 0; i < 2; i++) {
                buf[i] = ciphertext[ciphertext_index + i];
            }

            message[message_index] = hex_to_binary(buf) ^ next_key_byte(key, key_length);

            message_index++;
        }
    }

    printf("%s", message);

    free(key);
    free(ciphertext);
    free(message);

    return 0;
}