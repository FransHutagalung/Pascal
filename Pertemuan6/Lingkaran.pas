Uses graph, crt;

Procedure init;

Var gd,gm: integer;

Begin

  gm := detect;
  gd := 0;

  initgraph(gd,gm,'C:\TP\BGI');

  If graphresult <> grok Then

    Begin

      writeln ('Graph driver', gd,' graph mode', gm, 'not supported');

      halt(1);

    End;

End;
Procedure destroy;

Begin

  closegraph;

End;

Procedure circleplotpoints(xcenter, ycenter,x,y:integer);

Begin

  putpixel(xcenter+x, ycenter+y,30);
  putpixel(xcenter-x, ycenter+y, 30);
  putpixel(xcenter+x, ycenter-y, 30);
  putpixel(xcenter-x, ycenter-y, 30);
  putpixel(xcenter+y, ycenter+x,30);
  putpixel(xcenter-y, ycenter+x,30);
  putpixel(xcenter+y, ycenter-x,30);
  putpixel(xcenter-y, ycenter-x,30);
End;

Procedure circlemidpoint(xcenter, ycenter, radius:integer);

Var 

  x,y,p: integer;

Begin

  x := 0;

  y := radius;

  p := 1-radius;
  circleplotpoints(xcenter, ycenter,x,y);
  While x < y Do

    Begin

      x := x+1;

      If p < 0 Then

        p := p+(2*x+1)

      Else

        Begin
          y := y-1;

          p := p+(2*(x-y)+1);

        End;

    End;

  circleplotpoints(xcenter, ycenter,x,y);

End;

Begin

  init;

  circlemidpoint(100,100,90);

  readkey;

  destroy;

End.
