with Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants;
with Ada.Text_IO;
with Raw_Text_Output;

package body Hex_IO is

   use type Bytes.Unsigned_Byte;

   function To_Unsigned_Byte (Representation : Hex_Byte) return Bytes.Unsigned_Byte is
      function Hex_Value (Digit : Hex_Digit) return Hex_Digit_Value is (case Digit is
                                                                           when '0' .. '9' => Hex_Digit'Pos (Digit) - Zero_Pos,
                                                                           when 'a' .. 'f' => Hex_Digit'Pos (Digit) - A_Pos + 10);
   begin
      return Hex_Value (Representation (1)) * 16 + Hex_Value (Representation (2));
   end To_Unsigned_Byte;

   function To_Hex_Byte (Value : Bytes.Unsigned_Byte) return Hex_Byte is
      function Hex_Image (Digit : Hex_Digit_Value) return Hex_Digit is (case Digit is
                                                                           when 0 .. 9 => Hex_Digit'Val (Digit + Zero_Pos),
                                                                           when 10 .. 15 => Hex_Digit'Val (Digit - 10 + A_Pos));
   begin
      return (Hex_Image (Value / 16), Hex_Image (Value mod 16));
   end To_Hex_Byte;

   function Input_Hex_Byte return Bytes.Unsigned_Byte is
      Input : String (Hex_Byte'Range);
   begin
      -- Fetch two hexadecimal digits of input and convert it to lowercase
      Ada.Text_IO.Get (Input);
      declare
         Lower_Input : constant String := Ada.Strings.Fixed.Translate (Input,
                                                                       Ada.Strings.Maps.Constants.Lower_Case_Map);
      begin
         -- Check that the input is full of valid hexadecimal digits
         for Char of Lower_Input loop
            if Char not in Hex_Digit then
               raise Invalid_Hex_Byte with "Input should be composed of hexadecimal digits";
            end if;
         end loop;

         -- Convert the result to the equivalent unsigned byte
         return To_Unsigned_Byte (Input);
      end;
   exception
      -- An exception will be raised on read if the input does not have an even number of digits
      when Ada.Text_IO.End_Error => raise Invalid_Hex_Byte with "Input should have an even number of hexadecimal digits";
   end Input_Hex_Byte;

   procedure Output_Hex_Byte (Byte : Bytes.Unsigned_Byte) is
      Output : constant Hex_Byte := To_Hex_Byte (Byte);
   begin
      Raw_Text_Output.Write (Output);
   end Output_Hex_Byte;

end Hex_IO;
