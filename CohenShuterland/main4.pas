program CohenSutherland;
uses
  Graph, Crt;
const
  INSIDE = 0; // 0000
  LEFT = 1;   // 0001
  RIGHT = 2;  // 0010
  BOTTOM = 4; // 0100
  TOP = 8;    // 1000
  WINDOW_SIZE = 400; // Ukuran tetap untuk window grafis
var
  xmin, xmax, ymin, ymax: integer;
  screenWidth, screenHeight: integer;

// Prosedur untuk menginisialisasi layar dengan ukuran seragam
procedure InitializeScreen;
begin
  screenWidth := WINDOW_SIZE;
  screenHeight := WINDOW_SIZE;
  
  // Mengatur window clipping di tengah layar
  xmin := screenWidth div 4;
  xmax := (screenWidth * 3) div 4;
  ymin := screenHeight div 4;
  ymax := (screenHeight * 3) div 4;
end;

// Prosedur untuk menggambar label region
procedure DrawRegionLabels;
var
  centerX, centerY: integer;
begin
  SetColor(LightGray);
  SetTextStyle(DefaultFont, HorizDir, 1);
  
  // Menghitung titik tengah setiap region
  centerX := (xmin + xmax) div 2;
  centerY := (ymin + ymax) div 2;
  
  // Region Tengah
  OutTextXY(centerX - 20, centerY - 10, '0000');
  
  // Region Atas
  OutTextXY(centerX - 20, ymin - 30, '1000');
  
  // Region Bawah
  OutTextXY(centerX - 20, ymax + 10, '0100');
  
  // Region Kiri
  OutTextXY(xmin - 60, centerY - 10, '0001');
  
  // Region Kanan
  OutTextXY(xmax + 10, centerY - 10, '0010');
  
  // Region Pojok
  OutTextXY(xmin - 60, ymin - 30, '1001'); // Kiri Atas
  OutTextXY(xmax + 10, ymin - 30, '1010'); // Kanan Atas
  OutTextXY(xmin - 60, ymax + 10, '0101'); // Kiri Bawah
  OutTextXY(xmax + 10, ymax + 10, '0110'); // Kanan Bawah
end;

// Prosedur untuk menggambar garis pembatas region
procedure DrawRegionBoundaries;
begin
  SetColor(LightBlue);
  SetLineStyle(DottedLn, 0, NormWidth);
  
  // Garis vertikal
  Line(0, ymin, screenWidth, ymin);
  Line(0, ymax, screenWidth, ymax);
  
  // Garis horizontal
  Line(xmin, 0, xmin, screenHeight);
  Line(xmax, 0, xmax, screenHeight);
end;

// Prosedur untuk menggambar grid tambahan
procedure DrawGrid;
var
  i: integer;
begin
  SetColor(DarkGray);
  SetLineStyle(DottedLn, 0, NormWidth);
  
  // Menggambar grid vertikal
  for i := 0 to screenWidth div 40 do
  begin
    Line(i * 40, 0, i * 40, screenHeight);
  end;
  
  // Menggambar grid horizontal
  for i := 0 to screenHeight div 40 do
  begin
    Line(0, i * 40, screenWidth, i * 40);
  end;
end;

function ComputeCode(x, y: integer): integer;
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

procedure CohenSutherlandLineClip(x1, y1, x2, y2: integer);
var
  code1, code2, code: integer;
  accept, done: boolean;
  x, y: integer;
begin
  accept := False;
  done := False;
  
  repeat
    code1 := ComputeCode(x1, y1);
    code2 := ComputeCode(x2, y2);
    
    if (code1 = 0) and (code2 = 0) then
    begin
      accept := True;
      done := True;
    end
    else if (code1 and code2) <> 0 then
      done := True
    else
    begin
      if code1 <> 0 then
        code := code1
      else
        code := code2;
        
      if (code and TOP) <> 0 then
      begin
        x := x1 + (x2 - x1) * (ymax - y1) div (y2 - y1);
        y := ymax;
      end
      else if (code and BOTTOM) <> 0 then
      begin
        x := x1 + (x2 - x1) * (ymin - y1) div (y2 - y1);
        y := ymin;
      end
      else if (code and RIGHT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmax - x1) div (x2 - x1);
        x := xmax;
      end
      else if (code and LEFT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmin - x1) div (x2 - x1);
        x := xmin;
      end;
      
      if code = code1 then
      begin
        x1 := x;
        y1 := y;
      end
      else
      begin
        x2 := x;
        y2 := y;
      end;
    end;
  until done;
  
  if accept then
  begin
    SetColor(Green);
    SetLineStyle(SolidLn, 0, ThickWidth);
    Line(x1, y1, x2, y2);
  end
  else
  begin
    SetColor(Red);
    SetLineStyle(DottedLn, 0, NormWidth);
    Line(x1, y1, x2, y2);
  end;
end;

var
  gd, gm: integer;
  x1, y1, x2, y2: integer;
begin
  gd := Detect;
  InitGraph(gd, gm, '');
  
  InitializeScreen;
  
  // Menggambar elemen visual
  ClearDevice;
  DrawGrid;
  DrawRegionBoundaries;
  
  // Menggambar window clipping
  SetColor(White);
  Rectangle(xmin, ymin, xmax, ymax);
  
  DrawRegionLabels;
  
  // Contoh garis untuk di-clip
  x1 := 150;
  y1 := 150;
  x2 := 350;
  y2 := 350;
  
  CohenSutherlandLineClip(x1, y1, x2, y2);
  
  ReadLn;
  CloseGraph;
end.