program LineClipping;
uses Graph, Crt;
const
  INSIDE = 0;
  LEFT = 1;
  RIGHT = 2;
  BOTTOM = 4;
  TOP = 8;
  OFFSET_X = 400; { Jarak antara tampilan kiri dan kanan }
var
  gd, gm: integer;
  xmin, ymin, xmax, ymax: integer;
  accept: boolean;

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

procedure DrawOriginalLine(x1, y1, x2, y2: real);
begin
  setcolor(LIGHTGRAY);
  line(round(x1) + OFFSET_X, round(y1), round(x2) + OFFSET_X, round(y2));
end;

procedure CohenSutherlandClip(x1, y1, x2, y2: real; var accept: boolean);
var
  code1, code2, codeOut: integer;
  x, y: real;
  done: boolean;
begin
  accept := false;
  done := false;
  
  { Gambar garis asli di sebelah kanan }
  DrawOriginalLine(x1, y1, x2, y2);
  
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
        x1 := x;
        y1 := y;
        code1 := ComputeCode(x1, y1);
      end
      else
      begin
        x2 := x;
        y2 := y;
        code2 := ComputeCode(x2, y2);
      end;
    end;
  end;
  
  if accept then
  begin
    setcolor(RED);
    line(round(x1), round(y1), round(x2), round(y2));
  end;
end;

procedure DrawClippingWindow;
begin
  setcolor(WHITE);
  rectangle(xmin, ymin, xmax, ymax);
  { Gambar window kedua di sebelah kanan }
  rectangle(xmin + OFFSET_X, ymin, xmax + OFFSET_X, ymax);
  
  { Tambah label }
  outtextxy(xmin, ymin - 20, 'Hasil Clipping');
  outtextxy(xmin + OFFSET_X, ymin - 20, 'Garis Asli');
end;

procedure DrawMountainPattern;
var
  i: integer;
  x1, y1, x2, y2: real;
  stepX, amplitude: integer;
begin
  stepX := 20;  { Jarak horizontal antar titik }
  amplitude := 50; { Tinggi gunungan }

  x1 := 0;
  y1 := ymax;  { Mulai dari bawah layar }

  for i := 1 to 20 do  { Gambar 20 segmen gunungan }
  begin
    x2 := x1 + stepX;
    if i mod 2 = 1 then
      y2 := ymax - amplitude  { Naik ke puncak gunungan }
    else
      y2 := ymax;  { Turun ke dasar }

    { Gambar garis gunungan dan potong }
    CohenSutherlandClip(x1, y1, x2, y2, accept);

    { Pindah ke titik berikutnya }
    x1 := x2;
    y1 := y2;
  end;
end;

begin
  gd := Detect;
  InitGraph(gd, gm, '');
  
  { Set clipping window coordinates }
  xmin := 100;
  ymin := 100;
  xmax := 300;
  ymax := 200;
  
  { Draw clipping windows }
  DrawClippingWindow;
  
  { Gambar pola gunungan dan potong }
  DrawMountainPattern;
  
  readln;
  CloseGraph;
end.