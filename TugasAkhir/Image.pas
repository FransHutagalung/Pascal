program TerminalClipping;
uses Crt;

const
  CANVAS_WIDTH = 60;
  CANVAS_HEIGHT = 20;
  CLIP_X1 = 15;
  CLIP_Y1 = 5;
  CLIP_X2 = 45;
  CLIP_Y2 = 15;

type
  TCanvas = array[1..CANVAS_HEIGHT, 1..CANVAS_WIDTH] of char;

var
  canvas: TCanvas;

procedure InitCanvas;
var
  i, j: integer;
begin
  for i := 1 to CANVAS_HEIGHT do
    for j := 1 to CANVAS_WIDTH do
      canvas[i,j] := ' ';
end;

procedure DrawClippingWindow;
var
  i: integer;
begin
  { Draw horizontal lines }
  for i := CLIP_X1 to CLIP_X2 do
  begin
    canvas[CLIP_Y1,i] := '-';
    canvas[CLIP_Y2,i] := '-';
  end;
  
  { Draw vertical lines }
  for i := CLIP_Y1 to CLIP_Y2 do
  begin
    canvas[i,CLIP_X1] := '|';
    canvas[i,CLIP_X2] := '|';
  end;
  
  { Draw corners }
  canvas[CLIP_Y1,CLIP_X1] := '+';
  canvas[CLIP_Y1,CLIP_X2] := '+';
  canvas[CLIP_Y2,CLIP_X1] := '+';
  canvas[CLIP_Y2,CLIP_X2] := '+';
end;

procedure DrawCircle(centerX, centerY, radius: integer);
var
  x, y: integer;
begin
  for y := centerY-radius to centerY+radius do
    for x := centerX-radius*2 to centerX+radius*2 do
    begin
      if (x >= 1) and (x <= CANVAS_WIDTH) and 
         (y >= 1) and (y <= CANVAS_HEIGHT) then
      begin
        if round(sqr((x-centerX)/2) + sqr(y-centerY)) = round(sqr(radius)) then
        begin
          if (x >= CLIP_X1) and (x <= CLIP_X2) and 
             (y >= CLIP_Y1) and (y <= CLIP_Y2) then
            canvas[y,x] := 'O'
          else
            canvas[y,x] := '.';
        end;
      end;
    end;
end;

procedure DrawRectangle(x1, y1, x2, y2: integer);
var
  x, y: integer;
begin
  for y := y1 to y2 do
    for x := x1 to x2 do
    begin
      if (x >= 1) and (x <= CANVAS_WIDTH) and 
         (y >= 1) and (y <= CANVAS_HEIGHT) then
      begin
        if (x = x1) or (x = x2) or (y = y1) or (y = y2) then
        begin
          if (x >= CLIP_X1) and (x <= CLIP_X2) and 
             (y >= CLIP_Y1) and (y <= CLIP_Y2) then
            canvas[y,x] := '#'
          else
            canvas[y,x] := '.';
        end;
      end;
    end;
end;

procedure DisplayCanvas;
var
  i, j: integer;
begin
  ClrScr;
  writeln('Clipping Demo in Terminal (. = clipped, O/# = visible)');
  writeln;
  
  for i := 1 to CANVAS_HEIGHT do
  begin
    for j := 1 to CANVAS_WIDTH do
      write(canvas[i,j]);
    writeln;
  end;
end;

begin
  InitCanvas;
  DrawClippingWindow;
  
  { Draw a circle }
  DrawCircle(30, 10, 5);
  
  { Draw a rectangle }
  DrawRectangle(20, 7, 40, 13);
  
  DisplayCanvas;
  
  writeln;
  writeln('Press Enter to exit...');
  readln;
end.