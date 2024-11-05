uses graph, crt, math;

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
  setcolor(color);
  line(x1, y1, x2, y2);
  line(x2, y2, x3, y3);
  line(x3, y3, x1, y1);
end;

procedure rotatePoint(x, y, xcenter, ycenter: integer; angle: real; var xout, yout: integer);
begin
  xout := round(xcenter + ((x - xcenter) * cos(angle)) - ((y - ycenter) * sin(angle)));
  yout := round(ycenter + ((x - xcenter) * sin(angle)) + ((y - ycenter) * cos(angle)));
end;

procedure rotateTriangleWithDelay(x1, y1, x2, y2, x3, y3, xcenter, ycenter: integer; angleStep: real; steps: integer; color: integer);
var
  i: integer;
  currentAngle: real;
  x1_rot, y1_rot, x2_rot, y2_rot, x3_rot, y3_rot: integer;
begin
  x1_rot := x1;
  y1_rot := y1;
  x2_rot := x2;
  y2_rot := y2;
  x3_rot := x3;
  y3_rot := y3;

  for i := 1 to steps do
  begin
    currentAngle := angleStep * i;

    if i > 1 then
    begin
      setcolor(0); // Warna 0 untuk menghapus segitiga sebelumnya
      drawTriangle(x1_rot, y1_rot, x2_rot, y2_rot, x3_rot, y3_rot, 0);
    end;

    rotatePoint(x1, y1, xcenter, ycenter, currentAngle, x1_rot, y1_rot);
    rotatePoint(x2, y2, xcenter, ycenter, currentAngle, x2_rot, y2_rot);
    rotatePoint(x3, y3, xcenter, ycenter, currentAngle, x3_rot, y3_rot);

    drawTriangle(x1_rot, y1_rot, x2_rot, y2_rot, x3_rot, y3_rot, color);
    delay(300);
  end;
end;

var
  x1, y1, x2, y2, x3, y3: integer;
  angleStep, totalAngle: real;
  nama, npm: string;
begin
  writeln('Masukkan Nama');
  readln(nama);
  writeln('Masukkan NPM');
  readln(npm);
  writeln('Masukkan X1');
  readln(x1);
  writeln('Masukkan Y1');
  readln(y1);
  writeln('Masukkan X2');
  readln(x2);
  writeln('Masukkan Y2');
  readln(y2);
  writeln('Masukkan X3');
  readln(x3);
  writeln('Masukkan Y3');
  readln(y3);

  writeln('Masukkan sudut rotasi (dalam derajat)');
  readln(totalAngle);

  angleStep := (totalAngle * pi) / 180; // Konversi derajat ke radian

  init;

  drawTriangle(x1, y1, x2, y2, x3, y3, 4);
  outtextxy(10, 10, 'Nama: ' + nama + ' NPM: ' + npm);

  rotateTriangleWithDelay(x1, y1, x2, y2, x3, y3, x2, y2, angleStep / 45, 45, 2);

  readkey;
  destroy;
end.
