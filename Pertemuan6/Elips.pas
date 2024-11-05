uses graph, crt;

procedure init;
var
  gd, gm: integer;
begin
  gd := detect;
  gm := 0;
  initgraph(gd, gm, '');
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

  // Region 1
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

  // Region 2
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
  elipsMidPoint(160, 240, 120, 190);
  readkey;
  closegraph;
end.
