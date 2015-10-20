with Ada.Text_IO;
with ASCII_Handling;
with Bytes; use Bytes;
with CLI;
with Encryption_Keys;
with Hex_IO;

procedure Encrypt is
   Encryption_Key : Encryption_Keys.Cyclical_Encryption_Key := CLI.Get_Key_From_CLI;
begin
   while not Ada.Text_IO.End_Of_File loop
      declare
         Input_Byte : Unsigned_Byte := ASCII_Handling.Input_ASCII;
         Key_Byte : Unsigned_Byte := Encryption_Keys.Generate_Key_Byte (Encryption_Key);
      begin
         Hex_IO.Output_Hex_Byte (Input_Byte xor Key_Byte);
      end;
   end loop;
end Encrypt;
