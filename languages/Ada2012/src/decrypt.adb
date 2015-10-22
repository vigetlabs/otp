with Ada.Text_IO;
with ASCII_Handling;
with Bytes; use Bytes;
with CLI;
with Encryption_Keys;
with Hex_IO;

procedure Decrypt is
   Encryption_Key : Encryption_Keys.Cyclical_Encryption_Key := CLI.Get_Key_From_CLI;
begin
   while not Ada.Text_IO.End_Of_File loop
      declare
         Input_Byte : constant Unsigned_Byte := Hex_IO.Input_Hex_Byte;
         Key_Byte : constant Unsigned_Byte := Encryption_Keys.Generate_Key_Byte (Encryption_Key);
      begin
         ASCII_Handling.Output_ASCII (Input_Byte xor Key_Byte);
      end;
   end loop;
end Decrypt;
