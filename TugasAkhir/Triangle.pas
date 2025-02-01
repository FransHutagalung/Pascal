program TriangleClipping;
uses Graph, Crt;

const
  INSIDE = 0;
  LEFT = 1;
  RIGHT = 2;
  BOTTOM = 4;
  TOP = 8;
  OFFSET_X = 400; { Jarak antara tampilan kiri dan kanan }
  MAX_POINTS = 10; { Maksimum titik untuk polygon }

type
  TPoint = record
    x, y: real;
  end;
  
  TPolygon = array[1..MAX_POINTS] of TPoint;

var
  gd, gm: integer;
  xmin, ymin, xmax, ymax: integer;
  numPoints: integer;
  
function ComputeCode(x, y: real): integer;
var
  code: integer;
begin
  code := INSIDE;
  
  if x < xmin then
    code := code or LEFT
  else if x > xmax then
    code := code or RIGHT;
    
  if y < ymin then
    code := code or BOTTOM
  else if y > ymax then
    code := code or TOP;
    
  ComputeCode := code;
end;

procedure DrawPolygon(var poly: TPolygon; n: integer; offset: integer);
var
  i: integer;
begin
  for i := 1 to n-1 do
    line(round(poly[i].x) + offset, round(poly[i].y),
         round(poly[i+1].x) + offset, round(poly[i+1].y));
  { Menghubungkan titik terakhir dengan titik pertama }
  line(round(poly[n].x) + offset, round(poly[n].y),
       round(poly[1].x) + offset, round(poly[1].y));
end;

procedure ClipLine(x1, y1, x2, y2: real; var outX1, outY1, outX2, outY2: real; var accept: boolean);
var
  code1, code2, codeOut: integer;
  x, y: real;
  done: boolean;
begin
  accept := false;
  done := false;
  outX1 := x1;
  outY1 := y1;
  outX2 := x2;
  outY2 := y2;
  
  code1 := ComputeCode(x1, y1);
  code2 := ComputeCode(x2, y2);
  
  while not done do
  begin
    if (code1 = 0) and (code2 = 0) then
    begin
      accept := true;
      done := true;
    end
    else if (code1 and code2) <> 0 then
      done := true
    else
    begin
      if code1 <> 0 then
        codeOut := code1
      else
        codeOut := code2;
        
      if (codeOut and TOP) <> 0 then
      begin
        x := x1 + (x2 - x1) * (ymax - y1) / (y2 - y1);
        y := ymax;
      end
      else if (codeOut and BOTTOM) <> 0 then
      begin
        x := x1 + (x2 - x1) * (ymin - y1) / (y2 - y1);
        y := ymin;
      end
      else if (codeOut and RIGHT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmax - x1) / (x2 - x1);
        x := xmax;
      end
      else if (codeOut and LEFT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmin - x1) / (x2 - x1);
        x := xmin;
      end;
      
      if codeOut = code1 then
      begin
        outX1 := x;
        outY1 := y;
        code1 := ComputeCode(x, y);
      end
      else
      begin
        outX2 := x;
        outY2 := y;
        code2 := ComputeCode(x, y);
      end;
    end;
  end;
end;

procedure ClipPolygon(var inPoly: TPolygon; inPoints: integer; var outPoly: TPolygon; var outPoints: integer);
var
  i, j: integer;
  x1, y1, x2, y2, outX1, outY1, outX2, outY2: real;
  accept: boolean;
begin
  outPoints := 0;
  
  for i := 1 to inPoints do
  begin
    if i < inPoints then
    begin
      j := i + 1;
    end
    else
    begin
      j := 1;
    end;
    
    x1 := inPoly[i].x;
    y1 := inPoly[i].y;
    x2 := inPoly[j].x;
    y2 := inPoly[j].y;
    
    ClipLine(x1, y1, x2, y2, outX1, outY1, outX2, outY2, accept);
    
    if accept then
    begin
      inc(outPoints);
      outPoly[outPoints].x := outX1;
      outPoly[outPoints].y := outY1;
      
      if (outX2 <> outX1) or (outY2 <> outY1) then
      begin
        inc(outPoints);
        outPoly[outPoints].x := outX2;
        outPoly[outPoints].y := outY2;
      end;
    end;
  end;
end;

procedure DrawClippingWindow;
begin
  setcolor(WHITE);
  rectangle(xmin, ymin, xmax, ymax);
  rectangle(xmin + OFFSET_X, ymin, xmax + OFFSET_X, ymax);
  
  outtextxy(xmin, ymin - 20, 'Hasil Clipping');
  outtextxy(xmin + OFFSET_X, ymin - 20, 'Segitiga Asli');
end;

var
  inPoly, outPoly: TPolygon;
  outPoints: integer;
  
begin
  gd := Detect;
  InitGraph(gd, gm, '');
  
  { Set clipping window coordinates }
  xmin := 100;
  ymin := 100;
  xmax := 300;
  ymax := 200;
  
  { Definisikan segitiga }
  numPoints := 3;
  inPoly[1].x := 50;   inPoly[1].y := 50;   { Titik 1 }
  inPoly[2].x := 250;  inPoly[2].y := 150;  { Titik 2 }
  inPoly[3].x := 150;  inPoly[3].y := 250;  { Titik 3 }
  
  { Gambar window clipping }
  DrawClippingWindow;
  
  { Gambar segitiga asli di sebelah kanan }
  setcolor(LIGHTGRAY);
  DrawPolygon(inPoly, numPoints, OFFSET_X);
  
  { Lakukan clipping }
  ClipPolygon(inPoly, numPoints, outPoly, outPoints);
  
  { Gambar hasil clipping di sebelah kiri }
  setcolor(RED);
  if outPoints > 0 then
    DrawPolygon(outPoly, outPoints, 0);
    
  readln;
  CloseGraph;
end.