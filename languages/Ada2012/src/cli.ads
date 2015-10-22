with Encryption_Keys;

-- This package handles the program's CLI arguments
package CLI is

   -- Fetch the encryption key from CLI, or raise Bad_Arguments if the argument count is incorrect
   Bad_Arguments : exception;
   function Get_Key_From_CLI return Encryption_Keys.Cyclical_Encryption_Key;

end CLI;
