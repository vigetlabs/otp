with Bytes;

-- This package manages encryption keys
package Encryption_Keys is

   -- Actual encryption key, and abstraction of a repeating key
   type Encryption_Key is array (Natural range <>) of Bytes.Unsigned_Byte;
   type Cyclical_Encryption_Key (<>) is private;

   -- Decode a cyclical encryption key from an hexadecimal input string.
   -- Bad_Key will be raised if the input turns out to be invalid.
   Bad_Key : exception;
   function Decode_Key (Input : String) return Cyclical_Encryption_Key;

   -- Generate a single byte of key
   function Generate_Key_Byte (Input : in out Cyclical_Encryption_Key) return Bytes.Unsigned_Byte;

private

   -- Implementation of the cyclical encryption key
   type Cyclical_Encryption_Key (Last_Key_Index : Natural) is
      record
         Data : Encryption_Key (0 .. Last_Key_Index);
         Offset : Natural := 0;
      end record;

end Encryption_Keys;
