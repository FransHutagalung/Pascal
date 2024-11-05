Program Warna_Teks_Nama;
Uses Crt;
Var nama:string[25];
begin
Clrscr;
gotoXY(25,10);
textcolor(3 + blink);
Write('Masukkan Nama Anda :');readln(nama);
gotoXY(15,15);
textcolor(12);
Write('Saudara',' ',nama,' ','Anda bersama dengan teman-teman Memasuki Dunia Aplikasi');
GotoXY(15,17);
textcolor(6);
Write('Anda Sudah Siap ???');
readln;
end.