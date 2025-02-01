program CohenSutherland;

uses
  Graph;

const
  INSIDE = 0; // 0000
  LEFT = 1;   // 0001
  RIGHT = 2;  // 0010
  BOTTOM = 4; // 0100
  TOP = 8;    // 1000

  xmin = 100;
  xmax = 300;
  ymin = 100;
  ymax = 300;

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
    SetLineStyle(SolidLn, 0, NormWidth); 
    Line(Round(x1), Round(y1), Round(x2), Round(y2));
  end;
end;

var
  gd, gm: integer;
  xThird, yThird: integer;
begin
  gd := Detect;
  InitGraph(gd, gm, '');

  Rectangle(xmin, ymin, xmax, ymax);

  xThird := (xmax - xmin) div 3;
  yThird := (ymax - ymin) div 3;

  SetLineStyle(DottedLn, 0, NormWidth); 

  Line(xmin, ymin + yThird, xmax, ymin + yThird); 
  Line(xmin, ymin + 2 * yThird, xmax, ymin + 2 * yThird); 


  Line(xmin + xThird, ymin, xmin + xThird, ymax); 
  Line(xmin + 2 * xThird, ymin, xmin + 2 * xThird, ymax); 


  SetLineStyle(SolidLn, 0, NormWidth); 
  CohenSutherlandLineClip(50, 150, 350, 250); 
  CohenSutherlandLineClip(150, 40, 210, 350);  

  ReadLn;
  CloseGraph;
end.