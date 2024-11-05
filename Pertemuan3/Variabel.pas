uses crt;
var a,b,c : INTEGER;
begin 
  CLRSCR;
  write  ('Masukkan Bilangan Pertama : ');
  readln(a);
  write ('Masukkan Bilangan Kedua : ');
  readln(b);
  c:=a+b;
  writeln('Hasilnya adalah  : ' , c);
  readln;
end.