with Ada.Strings.Fixed;
with Ada.Strings.Maps.Constants;
with Hex_IO;

package body Encryption_Keys is

   function Decode_Key (Input : String) return Cyclical_Encryption_Key is
      Lower_Input : constant String := Ada.Strings.Fixed.Translate (Input,
                                                                    Ada.Strings.Maps.Constants.Lower_Case_Map);
   begin
      -- Validate the input hex string : check that it is solely composed of hexadecimal digits
      for Char of Lower_Input loop
         if Char not in Hex_IO.Hex_Digit then
            raise Bad_Key with Character'Image (Char) & " is not a valid hexadecimal digit";
         end if;
      end loop;

      -- ...and that the length is even or only 1 (we should not accept incomplete bytes)
      if Lower_Input'Length mod 2 /= 0 then
         if Lower_Input'Length = 1 then
            return (Last_Key_Index => 0,
                    Data => (0 => Hex_IO.To_Unsigned_Byte ('0' & Lower_Input)),
                    Offset => 0);
         else
            raise Bad_Key with "A valid key should have an even number of hexadecimal digits";
         end if;
      end if;

      -- Convert it to raw key bytes
      declare
         Key : Cyclical_Encryption_Key (Lower_Input'Length / 2 - 1);
      begin
         for Output_Index in Key.Data'Range loop
            declare
               Input_Index : constant Natural := 2 * Output_Index + Lower_Input'First;
            begin
               Key.Data (Output_Index) := Hex_IO.To_Unsigned_Byte (Lower_Input (Input_Index .. Input_Index + 1));
            end;
         end loop;

         return Key;
      end;
   end Decode_Key;

   function Generate_Key_Byte (Input : in out Cyclical_Encryption_Key) return Bytes.Unsigned_Byte is
   begin
      return Output : constant Bytes.Unsigned_Byte := Input.Data (Input.Offset) do
         Input.Offset := (Input.Offset + 1) mod Input.Data'Length;
      end return;
   end Generate_Key_Byte;

end Encryption_Keys;
