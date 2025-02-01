program CohenSutherland;

uses
  Graph, Crt;

const
  INSIDE = 0; // 0000
  LEFT = 1;   // 0001
  RIGHT = 2;  // 0010
  BOTTOM = 4; // 0100
  TOP = 8;    // 1000

  SCALE_FACTOR = 50; // Faktor skala untuk memperbesar gambar

var
  xmin, xmax, ymin, ymax: integer;

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

procedure CohenSutherlandLineClip(x1, y1, x2, y2: real);
var
  code1, code2, code: integer;
  x, y: real;
  accept, done: boolean;
begin
  accept := False;
  done := False;

  repeat
    code1 := ComputeCode(x1, y1);
    code2 := ComputeCode(x2, y2);

    WriteLn('Point 1 (', x1:0:2, ', ', y1:0:2, ') Code: ', code1);
    WriteLn('Point 2 (', x2:0:2, ', ', y2:0:2, ') Code: ', code2);

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
        x := x1 + (x2 - x1) * (ymax - y1) / (y2 - y1);
        y := ymax;
      end
      else if (code and BOTTOM) <> 0 then
      begin
        x := x1 + (x2 - x1) * (ymin - y1) / (y2 - y1);
        y := ymin;
      end
      else if (code and RIGHT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmax - x1) / (x2 - x1);
        x := xmax;
      end
      else if (code and LEFT) <> 0 then
      begin
        y := y1 + (y2 - y1) * (xmin - x1) / (x2 - x1);
        x := xmin;
      end;

      if code = code1 then
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
  until done;

  if accept then
  begin
    WriteLn('Garis berada di dalam jendela.');
    SetColor(Green);
    SetLineStyle(SolidLn, 0, NormWidth);
    Line(Round(x1 * SCALE_FACTOR), Round(y1 * SCALE_FACTOR), Round(x2 * SCALE_FACTOR), Round(y2 * SCALE_FACTOR)); // Skala diperbesar
  end
  else
  begin
    WriteLn('Garis berada di luar jendela.');
    SetColor(Red);
    SetLineStyle(DottedLn, 0, NormWidth);
    Line(Round(x1 * SCALE_FACTOR), Round(y1 * SCALE_FACTOR), Round(x2 * SCALE_FACTOR), Round(y2 * SCALE_FACTOR)); // Skala diperbesar
  end;
end;

procedure DrawWindow;
begin
  SetColor(White);
  Rectangle(Round(xmin * SCALE_FACTOR), Round(ymin * SCALE_FACTOR), Round(xmax * SCALE_FACTOR), Round(ymax * SCALE_FACTOR)); // Skala diperbesar
end;

var
  gd, gm: integer;
  x1, y1, x2, y2: real;
begin
  gd := Detect;
  InitGraph(gd, gm, '');

  // Set nilai jendela kliping sesuai soal
  xmin := 2;
  xmax := 8;
  ymin := 3;
  ymax := 10;

  // Set nilai titik garis sesuai soal
  x1 := 3;
  y1 := 4;
  x2 := 7;
  y2 := 9;

  DrawWindow;

  WriteLn('Menghitung kode bit untuk titik (', x1:0:2, ', ', y1:0:2, ') dan (', x2:0:2, ', ', y2:0:2, ')');
  CohenSutherlandLineClip(x1, y1, x2, y2);

  ReadLn;
  CloseGraph;
end.