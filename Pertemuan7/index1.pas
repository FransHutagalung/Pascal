
Uses graph,crt;

Procedure init;

Var gd, gm: integer;

Begin

  gm := detect;
  gd := 0;

  InitGraph(gd,gm,'C:\TP\BGI');

  If GraphResult <> grok Then

    Begin

      Writeln('Graph driver', gd, 'graph mode', gm, 'not supported');

      Halt(1);

    End;

End;

Procedure destroy;

Begin

  closegraph;

End;

Var 

  x0,y0,x1,y1: integer;

{tambahkan pada bagian ini prosedur penginisialisasian device, lihat pada bab 1}

Procedure drawLine(xstart, ystart, xend, yend:integer);

Var 
  step,k: integer;

  dx,dy: real;

  x_inc,y_inc,x,y: real;

Begin

  dx := xend-xstart;

  dy := yend-ystart;

  x := xstart;

  y := ystart;

  If abs(dx) > abs(dy) Then step := round(abs(dx))

  Else step := round(abs(dy));
  x_inc := dx/step;
  y_inc := dy/step;
  putPixel(round(x), round(y), 30);
  For k:=1 To step Do
    Begin

      x := x+x_inc;

      y := y+y_inc;

      putPixel(round(x), round(y),30);

    End;

End;

Procedure transLine(xstart, ystart, xend, yend, xtrans, ytrans:integer; Var
                    xstartout, ystartout, xendout, yendout:integer);

Begin

  xstartout := xstart+xtrans;

  ystartout := ystart+ytrans;

  xendout := xend+xtrans;

  yendout := yend+ytrans;

End;

Begin

  init;
{menggambar garis dari titik 10,10 ke 500,103 drawLine(10,10,500,10);}

  drawLine(10,10,500,10);
  transLine(10, 10,500,10,20, 10, x0,y0,x1,y1);
  drawLine(x0,y0,x1,y1);

  readkey;

  destroy;

End.
