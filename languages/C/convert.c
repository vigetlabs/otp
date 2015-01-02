#include <stdlib.h>
#include <stdio.h>
#include "convert.h"

#define HEX_LOWER_OFFSET ('a' - 10)
#define HEX_UPPER_OFFSET ('A' - 10)

// Check if a single character is a valid hexadecimal digit
short is_hex_digit(char digit)
{
    short is_hex_digit = 0;

    is_hex_digit = is_hex_digit || (digit >= '0' && digit <= '9');
    is_hex_digit = is_hex_digit || (digit >= 'A' && digit <= 'F');
    is_hex_digit = is_hex_digit || (digit >= 'a' && digit <= 'f');

    return is_hex_digit;
}

// Check all characters in a string to ensure they are hexadecimal digits
short is_hex_key(char *key, int length)
{
    short is_hex = 1;
    int   i      = 0;

    for (i = 0; i < length; i++) {
        is_hex = is_hex && is_hex_digit(key[i]);
    }

    return is_hex;
}

// Convert a single hexadecimal to binary, assumes `char` is
// a valid hexadecimal digit: 0-9, a-f, A-F
int hex_digit_to_binary(char hex)
{
    char subtrahend = '0';

    if (hex >= 'a') {
        subtrahend = HEX_LOWER_OFFSET;
    } else if (hex >= 'A') {
        subtrahend = HEX_UPPER_OFFSET;
    }

    return hex - subtrahend;
}

// Convert a pair of hexadecimal digits to binary
int hex_to_binary(char hex[])
{
    // TODO: access issues -- assumes array has 2 elements
    int left  = hex_digit_to_binary(hex[0]) * 16,
        right = hex_digit_to_binary(hex[1]);

    return left + right;
}

// Convert a binary number to a 2-digit hexadecimal string
char *binary_to_hex(int number)
{
    char *hex = calloc(3, sizeof(char));
    snprintf(hex, 3, "%02x", number);

    return hex;
}