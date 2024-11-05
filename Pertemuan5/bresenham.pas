uses graph, crt;

var
  x1, x2, y1, y2: integer;
  nama : string;

procedure init;
var
  gd, gm: integer;
begin
  gm := detect; gd := 0;
  initgraph(gd, gm, 'C:\TP\BGI');
  if graphresult <> grok then
  begin
    writeln('Graph driver', gd, 'Graph Mode', gm, 'not supported');
    halt(1);
  end;
end;

procedure destroy;
begin
  closegraph;
end;

procedure drawbressline(xa, ya, xb, yb: integer ; nama :string);
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
      p := p + 2 * dy
    else
    begin
      y := y + 1;
      p := p + 2 * dy - 2 * dx;
    end;
    putpixel(round(x), round(y), 30);
  end;


//   outtextxy((xa + xb) div 2, (ya + yb) div 2, nama);
  outtextxy(10, 10, nama);
end;

begin
  write('Masukkan Nama => ');
  readln(nama);
  write('Masukkan X1 => ');
  readln(x1);
  write('Masukkan Y1 => ');
  readln(y1);
  write('Masukkan X2 => ');
  readln(x2);
  write('Masukkan Y2 => ');
  readln(y2);

  init;
  textcolor(10);
  textbackground(4);

  drawbressline(x1, y1, x2, y2 , nama);

  readkey;
  destroy;
end.
