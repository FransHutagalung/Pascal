
uses graph, crt;

procedure init;
var
  gd, gm: integer;
begin
  gm := detect;
  gd := 0;
  initgraph(gd, gm, 'C:\TP\BGI');
  if graphresult <> grok then
  begin
    writeln('Graph driver', gd, 'graph mode', gm, 'not supported');
    halt(1);
  end;
end;

procedure destroy;
begin
  closegraph;
end;

procedure drawbressline(xa, ya, xb, yb: integer);
var
  dx, p, dy, xend: integer;
  x, y: real;
begin
  dx := abs(xb - xa);
  dy := abs(yb - ya);
  p := 2 * dy - dx;
  if xa > xb then
  begin
    x := xb;
    y := yb;
    xend := xa;
  end
  else
  begin
    x := xa;
    y := ya;
    xend := xb;
  end;
  putpixel(round(x), round(y), 30);
  while x < xend do
  begin
    x := x + 1;
    if p < 0 then
      p := p + (2 * dy)
    else
    begin
      y := y + 1;
      p := p + (2 * (dy - dx));
    end;
    putpixel(round(x), round(y), 30);
  end;
end;

procedure BlinkText(x, y: integer; text: string; delayTime: integer);
var
  i: integer;
begin
  for i := 1 to 1000 do  { Ubah angka 10 untuk jumlah kedipan }
  begin
    if i mod 2 = 0 then
    begin
      setcolor(white);
      outtextxy(x, y, text);
    end
    else
    begin
      setcolor(black);  { Hapus teks dengan menggambar di atasnya dengan warna latar belakang }
      outtextxy(x, y, text);
    end;
    delay(delayTime);
  end;
end;

var
  xa, ya, xb, yb: integer;
  nama: string[25];

begin
  clrscr;
  gotoXY(25, 10);
  textcolor(3);
  write('Masukkan Nama Anda :');
  readln(nama);
  gotoXY(15, 15);
  textcolor(12);
  write('Saudara ', nama, ', Anda bersama dengan teman-teman Memasuki Dunia Aplikasi');
  gotoXY(15, 17);
  textcolor(6);
  writeln('Anda Sudah Siap ???');
  gotoXY(15, 18);
  textcolor(6);
  write('masukan titik awal X1 : ');
  readln(xa);
  gotoXY(15, 19);
  textcolor(6);
  write('masukan titik awal Y1 : ');
  readln(ya);
  gotoXY(15, 20);
  textcolor(6);
  write('masukan titik akhir X2 : ');
  readln(xb);
  gotoXY(15, 21);
  textcolor(6);
  write('masukan titik akhir Y2 : ');
  readln(yb);

  init;
  drawbressline(xa, ya, xb, yb);
  { Menampilkan nama berkedip di jendela grafis }
  BlinkText(10, 10, 'Nama: ' + nama, 500);
  readkey;
  destroy;
end.
