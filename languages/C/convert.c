#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>

#include "convert.h"

#define HEX_LOWER_OFFSET ('a' - 10)
#define HEX_UPPER_OFFSET ('A' - 10)

// Check all characters in a string to ensure they are hexadecimal digits
short is_hex_key(char *key, int length)
{
    short is_hex = 1;
    int   i      = 0;

    for (i = 0; i < length; i++) {
        is_hex = is_hex && isxdigit(key[i]);
    }

    return is_hex;
}

// Convert a single hexadecimal to decimal, assumes `char` is
// a valid hexadecimal digit: 0-9, a-f, A-F
int hex_digit_to_decimal(char hex)
{
    char subtrahend = '0';

    if (hex >= 'a') {
        subtrahend = HEX_LOWER_OFFSET;
    } else if (hex >= 'A') {
        subtrahend = HEX_UPPER_OFFSET;
    }

    return hex - subtrahend;
}

// Convert a pair of hexadecimal digits to decimal
int hex_to_decimal(char hex[])
{
    // TODO: access issues -- assumes array has 2 elements
    int left  = hex_digit_to_decimal(hex[0]) * 16,
        right = hex_digit_to_decimal(hex[1]);

    return left + right;
}

// Convert a decimal number to a 2-digit hexadecimal string
int decimal_to_hex(char *hex, int number)
{
    return snprintf(hex, 3, "%02x", number);
}