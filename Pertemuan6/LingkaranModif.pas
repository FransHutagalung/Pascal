uses graph, crt;

procedure init;
var
  gd, gm: integer;
begin
  gd := detect;
  initgraph(gd, gm, 'C:\TP\BGI');
  if graphresult <> grOk then
  begin
    writeln('Graphics mode not supported');
    halt(1);
  end;
end;

procedure destroy;
begin
  closegraph;
end;

procedure circlePlotPoints(xCenter, yCenter, x, y: integer);
begin
  putpixel(xCenter + x, yCenter + y, 30);
  putpixel(xCenter - x, yCenter + y, 30);
  putpixel(xCenter + x, yCenter - y, 30);
  putpixel(xCenter - x, yCenter - y, 30);
  putpixel(xCenter + y, yCenter + x, 30);
  putpixel(xCenter - y, yCenter + x, 30);
  putpixel(xCenter + y, yCenter - x, 30);
  putpixel(xCenter - y, yCenter - x, 30);
end;

procedure circleMidpoint(xCenter, yCenter, radius: integer);
var
  x, y, p: integer;
begin
  x := 0;
  y := radius;
  p := 1 - radius;

  circlePlotPoints(xCenter, yCenter, x, y);
  
  while x < y do
  begin
    x := x + 1;
    if p < 0 then
      p := p + 2 * x + 1
    else
    begin
      y := y - 1;
      p := p + 2 * (x - y) + 1;
    end;
    circlePlotPoints(xCenter, yCenter, x, y);
  end;
end;


procedure elipsPlotPoints(xCenter, yCenter, x, y: integer);
begin
  putpixel(xCenter + x, yCenter + y, White);
  putpixel(xCenter - x, yCenter + y, White);
  putpixel(xCenter + x, yCenter - y, White);
  putpixel(xCenter - x, yCenter - y, White);
end;

procedure elipsMidPoint(xCenter, yCenter, Rx, Ry: integer);
var
  x, y: integer;
  Rx2, Ry2, twoRx2, twoRy2: longint;
  p, px, py: longint;
begin
  x := 0;
  y := Ry;

  Rx2 := Rx * Rx;
  Ry2 := Ry * Ry;
  twoRx2 := 2 * Rx2;
  twoRy2 := 2 * Ry2;


  p := round(Ry2 - (Rx2 * Ry) + (0.25 * Rx2));
  px := 0;
  py := twoRx2 * y;

  while px < py do
  begin
    elipsPlotPoints(xCenter, yCenter, x, y);
    x := x + 1;
    px := px + twoRy2;
    if p < 0 then
      p := p + Ry2 + px
    else
    begin
      y := y - 1;
      py := py - twoRx2;
      p := p + Ry2 + px - py;
    end;
  end;


  p := round(Ry2 * (x + 0.5) * (x + 0.5) + Rx2 * (y - 1) * (y - 1) - Rx2 * Ry2);
  while y > 0 do
  begin
    elipsPlotPoints(xCenter, yCenter, x, y);
    y := y - 1;
    py := py - twoRx2;
    if p > 0 then
      p := p + Rx2 - py
    else
    begin
      x := x + 1;
      px := px + twoRy2;
      p := p + Rx2 - py + px;
    end;
  end;
end;


begin
  init;
//   elipsMidPoint(480, 200, 120, 190);
  circleMidpoint(200, 200, 80);
  readkey;
  destroy;
end.
