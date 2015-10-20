-- This pakage enables raw byte manipulation
package Bytes is

   -- We will perform bitwise boolean operations on ASCII character representations. For this, the proper tool is a modular byte.
   type Unsigned_Byte is mod 2 ** 8;

end Bytes;
