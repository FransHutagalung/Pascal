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

procedure drawCircle(xCenter, yCenter, radius: integer);
begin
  line(xCenter - radius+80, yCenter - radius-40, xCenter + radius, yCenter + radius+2); // kiri
  setcolor(black);
  setlinestyle(solidln, 5, normwidth * 6);
  line(xCenter - radius+100, yCenter - radius, xCenter + radius-18, yCenter + radius-34);  // kiri
  setcolor(white);
  setlinestyle(dashedln, 2, thickwidth);
  line(xCenter - radius+20, yCenter - radius-20, xCenter - radius+20, yCenter + radius+20); // tegak lurus
  setlinestyle(solidln, 2, normwidth * 3);
  line(xCenter - radius+20, yCenter - radius+25, xCenter - radius+20, yCenter + radius-40); // tegak lurus
  setlinestyle(dashedln, 2, thickwidth);
  line(xCenter - radius-20, yCenter + radius+20, xCenter + radius+20, yCenter - radius-20); // kanan
  setlinestyle(solidln, 2, normwidth);
  circle(xCenter, yCenter, radius);
  setlinestyle(solidln, 2, normwidth * 3);
  line(xCenter - radius+25, yCenter + radius-25, xCenter + radius-25, yCenter - radius+25); // kanan
end;

var
  xCenter, yCenter, radius: integer;
  hidden: boolean;

begin
  init;
  xCenter := GetMaxX div 2;
  yCenter := GetMaxY div 2;
  radius := 100; // Set desired radius
  drawCircle(xCenter, yCenter, radius);
  readln;
  destroy;
end.
