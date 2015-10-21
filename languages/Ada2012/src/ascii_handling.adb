with Ada.Text_IO;
-- DEBUG : This is not standard Ada, but is required to achieve test compliance. See below.
with GNAT.IO;

package body ASCII_Handling is

   function To_ASCII_Representation (Char : Character) return ASCII_Representation is
     (ASCII_Representation (Character'Pos (Char)));

   function To_Character (Representation : ASCII_Representation) return Character is
     (Character'Val (Representation));

   function Input_ASCII return ASCII_Representation is
      Input : Character;
   begin
      Ada.Text_IO.Get (Input);
      return To_ASCII_Representation (Input);
   end Input_ASCII;

   procedure Output_ASCII (Data : ASCII_Representation) is
   begin
      -- DEBUG : This is standard Ada, but will cause trailing newlines in output
      --    Ada.Text_IO.Put (To_Character (Data));
      -- DEBUG : This is not standard Ada, but it will do what we want
      GNAT.IO.Put (To_Character (Data));
   end Output_ASCII;

end ASCII_Handling;
