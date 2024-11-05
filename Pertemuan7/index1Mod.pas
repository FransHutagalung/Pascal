uses graph, crt;

procedure init;
var
  gd, gm: integer;
begin
  gd := detect;
  initgraph(gd, gm, 'C:\TP\BGI');
  if graphresult <> grok then
  begin
    writeln('Graph driver not supported');
    halt(1);
  end;
end;

procedure destroy;
begin
  closegraph;
end;

procedure drawTriangle(x1, y1, x2, y2, x3, y3, color: integer);
begin
  SetColor(color);
  Line(x1, y1, x2, y2);
  Line(x2, y2, x3, y3);
  Line(x3, y3, x1, y1);
end;

procedure translateTriangleWithDelay(x1, y1, x2, y2, x3, y3, xinc, yinc, steps: integer; color: integer; nama, npm: string);
var
  i: integer;
  x1_temp, y1_temp, x2_temp, y2_temp, x3_temp, y3_temp: integer;
begin
  x1_temp := x1;
  y1_temp := y1;
  x2_temp := x2;
  y2_temp := y2;
  x3_temp := x3;
  y3_temp := y3;

  outtextxy(800, 50, 'Nama: ' + nama + ' NPM: ' + npm);
  for i := 1 to steps do
  begin
    drawTriangle(x1, y1, x2, y2, x3, y3, 4);

    drawTriangle(x1_temp, y1_temp, x2_temp, y2_temp, x3_temp, y3_temp, 0);
  

    // Update posisi titik-titik segitiga
    x1_temp := x1 + (i * xinc div steps);
    y1_temp := y1 + (i * yinc div steps);
    x2_temp := x2 + (i * xinc div steps);
    y2_temp := y2 + (i * yinc div steps);
    x3_temp := x3 + (i * xinc div steps);
    y3_temp := y3 + (i * yinc div steps);

    // Gambar segitiga baru dengan warna yang diinginkan
    drawTriangle(x1_temp, y1_temp, x2_temp, y2_temp, x3_temp, y3_temp, color);

    // Delay untuk efek translasi
    delay(400);
  end;
end;

var
  x0, y0, x1, y1, x2, y2, xinc, yinc: integer;
  nama, npm: string;
begin
  writeln('Masukkan Nama');
  readln(nama);
  writeln('Masukkan NPM');
  readln(npm);
  writeln('Masukkan X1');
  readln(x0);
  writeln('Masukkan Y1');
  readln(y0);
  writeln('Masukkan X2');
  readln(x1);
  writeln('Masukkan Y2');
  readln(y1);
  writeln('Masukkan X3');
  readln(x2);
  writeln('Masukkan Y3');
  readln(y2);
  writeln('Masukkan Pertambahan X');
  readln(xinc);
  writeln('Masukkan Pertambahan Y');
  readln(yinc);

  init;

  // Gambar segitiga pertama tetap
  drawTriangle(x0, y0, x1, y1, x2, y2, 4);

  // Gambar segitiga kedua yang bergerak dengan delay
  translateTriangleWithDelay(x0, y0, x1, y1, x2, y2, xinc, yinc, 50, 2, nama, npm);

  readkey;
  destroy;
end.
