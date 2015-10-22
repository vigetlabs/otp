package body Raw_Text_Output is

   procedure Write (Char : Character) is
   begin
      Character'Write (Internal_Stream, Char);
   end Write;

   procedure Write (Str : String) is
   begin
      String'Write (Internal_Stream, Str);
   end Write;

end Raw_Text_Output;
