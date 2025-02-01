program CircleClipping;
uses Graph, Crt, Math;

const
  INSIDE = 0;
  LEFT = 1;
  RIGHT = 2;
  BOTTOM = 4;
  TOP = 8;
  OFFSET_X = 400;     { Jarak antara tampilan kiri dan kanan }
  SEGMENTS = 72;      { Jumlah segmen untuk membuat lingkaran (360/5 derajat) }
  PI = 3.14159265359;

type
  TPoint = record
    x, y: real;
  end;

var
  gd, gm: integer;
  xmin, ymin, xmax, ymax: integer;

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

procedure DrawCircle(centerX, centerY, radius: real; offset: integer; isClipped: boolean);
var
  i: integer;
  angle, nextAngle: real;
  x1, y1, x2, y2: real;
  outX1, outY1, outX2, outY2: real;
  accept: boolean;
begin
  for i := 0 to SEGMENTS-1 do
  begin
    angle := (i * 2 * PI) / SEGMENTS;
    nextAngle := ((i + 1) * 2 * PI) / SEGMENTS;
    
    x1 := centerX + radius * cos(angle);
    y1 := centerY + radius * sin(angle);
    x2 := centerX + radius * cos(nextAngle);
    y2 := centerY + radius * sin(nextAngle);
    
    if isClipped then
    begin
      ClipLine(x1, y1, x2, y2, outX1, outY1, outX2, outY2, accept);
      if accept then
        line(round(outX1), round(outY1), round(outX2), round(outY2));
    end
    else
      line(round(x1) + offset, round(y1), round(x2) + offset, round(y2));
  end;
end;

procedure DrawClippingWindow;
begin
  setcolor(WHITE);
  rectangle(xmin, ymin, xmax, ymax);
  rectangle(xmin + OFFSET_X, ymin, xmax + OFFSET_X, ymax);
  
  outtextxy(xmin, ymin - 20, 'Hasil Clipping');
  outtextxy(xmin + OFFSET_X, ymin - 20, 'Lingkaran Asli');
end;

begin
  gd := Detect;
  InitGraph(gd, gm, '');
  
  { Set clipping window coordinates }
  xmin := 100;
  ymin := 100;
  xmax := 300;
  ymax := 200;
  
  { Gambar window clipping }
  DrawClippingWindow;
  
  { Gambar lingkaran asli di sebelah kanan }
  setcolor(LIGHTGRAY);
  DrawCircle(200, 150, 70, OFFSET_X, false);  { Radius diubah dari 100 menjadi 70 }
  
  { Gambar hasil clipping di sebelah kiri }
  setcolor(RED);
  DrawCircle(200, 150, 70, 0, true);  { Radius diubah dari 100 menjadi 70 }
  
  readln;
  CloseGraph;
end.