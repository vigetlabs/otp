with Ada.Command_Line;

package body CLI is

   function Get_Key_From_CLI return Encryption_Keys.Cyclical_Encryption_Key is
      Nb_CLI_Arguments : constant Natural := Ada.Command_Line.Argument_Count;
   begin
      -- Check that there is one and only one CLI argument
      if Nb_CLI_Arguments /= 1 then
         raise Bad_Arguments with "One command line argument expected";
      end if;

      -- Fetch the key string from CLI
      declare
         Key_String : constant String := Ada.Command_Line.Argument (1);
      begin
         return Encryption_Keys.Decode_Key (Key_String);
      end;
   end Get_Key_From_CLI;

end CLI;
