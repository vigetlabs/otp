with Bytes;

-- This package allows one to manipulate the ASCII representation of characters : unsigned bytes
package ASCII_Handling is

   -- This code will perform bitwise boolean operations on ASCII character representations. For this, the proper tool is a modular type.
   subtype ASCII_Representation is Bytes.Unsigned_Byte range 0 .. 127;

   -- These functions convert between characters and their ASCII representation
   function To_ASCII_Representation (Char : Character) return ASCII_Representation;
   function To_Character (Representation : ASCII_Representation) return Character;

   -- This function transparently performs the conversion upon input
   function Input_ASCII return ASCII_Representation;
   procedure Output_ASCII (Data : ASCII_Representation);

end ASCII_Handling;
