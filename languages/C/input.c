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
        iteration    = 0; // keep track of loop iterations to grow our allocation

    size_t message_index = 0,
           chars_read    = 0;

    while (1) {
        // Function signature:
        //   size_t
        //   fread(void *restrict ptr, size_t size, size_t nitems, FILE *restrict stream);
        // We want to read in BUF_SIZE - 1 characters -- the size of our item is `sizeof(char)`
        chars_read = fread(buffer, sizeof(char), BUF_SIZE - 1, stdin);

        // allocate enough memory to store chars + NUL byte.  This ends up creating 1 more byte
        // than we need on every iteration, but it's not worth worrying about.
        tmp = realloc(message, (BUF_SIZE * iteration) + (chars_read + 1));

        if (tmp == NULL) {
            // bad allocation, just return what we have of `message`
            return message;
        } else {
            message = tmp;
        }

        // Loop through all the characters in the buffer we just fetched from STDIN
        // and append it to the message
        for (buffer_index = 0; buffer_index < chars_read; buffer_index++) {
            message[message_index] = buffer[buffer_index];
            message_index++;
        }

        // Ensure we NUL terminate the string -- `realloc` does not do this
        message[message_index] = 0;

        // Exit loop when we reach EOF, per manpage:
        //   The function fread() does not distinguish between end-of-file and error;
        //   callers must use feof(3) and ferror(3) to determine which occurred.
        if (feof(stdin)) { break; }

        iteration++;
    }

    // Free our buffer allocation, we no longer need it
    free(buffer);

    return message;
}