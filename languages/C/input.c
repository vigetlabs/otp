#include <stdlib.h>
#include <stdio.h>
#include "input.h"

// Read from the specified input stream until EOF and return
// the contents
char *read_message_from(FILE *stream)
{
    char *message = NULL, *tmp = NULL;
    char *buffer  = calloc(BUF_SIZE, sizeof(char));

    int buffer_index = 0,
        iteration    = 1;

    size_t message_index = 0,
           chars_read    = 0;

    while (1) {
        chars_read = fread(buffer, sizeof(char), BUF_SIZE - 1, stdin);

        tmp = realloc(message, BUF_SIZE * iteration);

        if (tmp == NULL) {
            // bad allocation, just return what we have of `message`
            return message;
        } else {
            message = tmp;
        }

        for (buffer_index = 0; buffer_index < chars_read; buffer_index++) {
            message[message_index] = buffer[buffer_index];
            message_index++;
        }

        if (feof(stdin)) { break; }
    }

    free(buffer);

    return message;
}