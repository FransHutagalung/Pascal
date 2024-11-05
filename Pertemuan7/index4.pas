Program Example15;
uses Crt;

{ Program utk demonstrasi function Delay . }
var
  i : longint;
begin
  WriteLn(' hitung mundur');
  for i:=10 downto 1 do
   begin
     WriteLn(i);
     Delay(1000); { tunggu 1 menit}
   end;
  WriteLn('BOOM!!!');
end.