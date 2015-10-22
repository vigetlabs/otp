with Ada.Text_IO;
with Ada.Text_IO.Text_Streams;

-- This packages enables character output on the standard output, without a trailing newline
package Raw_Text_Output is

   procedure Write (Char : Character);
   procedure Write (Str : String);

private

   package Text_Streams renames Ada.Text_IO.Text_Streams;
   Internal_Stream : constant Text_Streams.Stream_Access := Text_Streams.Stream(Ada.Text_IO.Standard_Output);

end Raw_Text_Output;
