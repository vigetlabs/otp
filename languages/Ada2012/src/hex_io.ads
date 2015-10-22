with Bytes;

-- This package allows the input and output of bytes in raw hexadecimal representation
package Hex_IO is

   -- We will need to convert between unsigned bytes and their hexadecimal representation, as defined below
   subtype Hex_Digit is Character with Static_Predicate => Hex_Digit in '0' .. '9' | 'a' .. 'f';
   subtype Hex_Byte is String (1 .. 2) with Dynamic_Predicate => (for all Digit of Hex_Byte => Digit in Hex_Digit);

   -- These functions convert between bytes and their hexadecimal representation
   function To_Unsigned_Byte (Representation : Hex_Byte) return Bytes.Unsigned_Byte;
   function To_Hex_Byte (Value : Bytes.Unsigned_Byte) return Hex_Byte;

   -- These functions perform unsigned byte I/O in hex byte representation.
   -- Invalid_Hex_Byte will be raised upon receiving malformed input.
   Invalid_Hex_Byte : exception;
   function Input_Hex_Byte return Bytes.Unsigned_Byte;
   procedure Output_Hex_Byte (Byte : Bytes.Unsigned_Byte);

private

   subtype Hex_Digit_Value is Bytes.Unsigned_Byte range 0 .. 15;
   Zero_Pos : constant := Hex_Digit'Pos ('0');
   A_Pos : constant := Hex_Digit'Pos ('a');

end Hex_IO;
