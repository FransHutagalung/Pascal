uses crt;

  Procedure menu(var pil:integer);
  Begin
     clrscr;
     gotoxy(10,9);write('Menu Pilihan');
     gotoxy(10,10);write('1. Input Data');
     gotoxy(10,11);write('2. Hitung Luas');
     gotoxy(10,12);write('3. Hitung Volume');
     gotoxy(10,13);write('4. Hitung Keliling');
     gotoxy(10,14);write('5. Keluar');
     gotoxy(10,15);write('Pilihan(1-5)?? : ');readln(pil);
  End;

  Procedure input(var a,b,c :real);
  Begin
    clrscr;
    gotoxy(10,14);write('Panjang = ');readln(a);
    gotoxy(10,15);write('Lebar   = ');readln(b);
    gotoxy(10,16);write('Tinggi  = ');readln(c);
  End;

  Procedure Luas(a,b,c :real; var ls:real);
  Begin
     Ls:=2*(a*b+ a*c + b*c);
  End;

  Procedure Vol(a,b,c :real; var vl:real);
  Begin
      vl:=a*b*c;
  End;

  Procedure Kel(a,b,c:real; var kl:real);
  Begin
     kl:= 4*(a+b+c);
  End;

  Procedure cetak(a,b,c :real);
  Begin

     gotoxy(10,14);writeln('Panjang  = ',a:0:2);
     gotoxy(10,15);writeln('Lebar    = ',b:0:2);
     gotoxy(10,16);writeln('Tinggi   = ',c:0:2);
  End;

{Program Utama}
var p:integer;
a,b,c, v,k,l : real;
ya : char;
Begin
 clrscr;
 ya:='y';
 while ya='y' do
 Begin
    menu(p);writeln;
    gotoxy(5,17);
    clrscr;
    case p of
    1 : Begin
        clrscr;
        input(a,b,c);
        End;
    2 : Begin
        clrscr;
        luas(a,b,c,l);
        cetak(a,b,c);
        gotoxy(10,17);writeln('Luas     = ',l:0:2);
        End;
    3 : Begin
        clrscr;
        vol(a,b,c,v);
        cetak(a,b,c);
        gotoxy(10,17);writeln('Volume   = ',v:0:2);
        End;
    4 : Begin
        clrscr;
        kel(a,b,c,k);
        cetak(a,b,c);
        gotoxy(10,17);writeln('Keliling = ',k:0:2);
        End;
    5 : Begin
         exit;
        End;
   End;
   readln;
 End;
   READKEY;
END.