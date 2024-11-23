
Program EyeOfProvidence;

Uses Graph;

Var 
  GraphDriver, GraphMode: integer;
  CenterX, CenterY: integer;
  TriangleSize: integer;

Procedure DrawTriangle;

Var 
  x1, y1, x2, y2, x3, y3: integer;
Begin
  x1 := CenterX;
  y1 := CenterY - TriangleSize;
  x2 := CenterX - Round(TriangleSize * 0.966);
  y2 := CenterY + Round(TriangleSize * 0.7);
  x3 := CenterX + Round(TriangleSize * 0.966);
  y3 := CenterY + Round(TriangleSize * 0.7);

  SetColor(Blue);
  Line(x1, y1, x2, y2);
  Line(x2, y2, x3, y3);
  Line(x3, y3, x1, y1);
End;



Procedure DrawEye;

Var 
  EyeWidth, EyeHeight: integer;
  i: integer;
  InnerArcWidth: integer;
Begin
  EyeWidth := Round(TriangleSize * 0.5);
  EyeHeight := Round(TriangleSize * 0.25);

  SetColor(Blue);

  { Gambar mata luar }
  Ellipse(CenterX, CenterY, 0, 360, EyeWidth, EyeHeight);

  { Tambahkan garis-garis lengkung di dalam mata }
  InnerArcWidth := EyeWidth - 5;  { Sedikit lebih kecil dari mata luar }

  { Gambar beberapa garis lengkung dengan ukuran berbeda }
  For i := 1 To 3 Do
    Begin
      Arc(CenterX, CenterY, 180, 360, Round(InnerArcWidth * (0.8 - i * 0.15)));
      Arc(CenterX, CenterY, 0, 180, Round(InnerArcWidth * (0.8 - i * 0.15)));
    End;

  { Gambar lingkaran dalam mata (pupil) }
  SetFillStyle(SolidFill, Blue);
  FillEllipse(CenterX, CenterY, Round(EyeWidth * 0.2), Round(EyeHeight * 0.2));

  { Gambar garis lengkung di atas dan bawah mata }
  Arc(CenterX, CenterY - Round(TriangleSize * 0.1), 180, 360, Round(EyeWidth * 1
                                                                    .2));
  Arc(CenterX, CenterY + Round(TriangleSize * 0.1), 0, 180, Round(EyeWidth * 1.2
  ));
End;


Procedure DrawDashedCircle;

Var 
  Radius: integer;
  Angle: real;
  x1, y1, x2, y2: integer;
  i: integer;
Begin
  { Kurangi ukuran lingkaran putus-putus }
  Radius := Round(TriangleSize * 0.8);    { Sebelumnya 1.2 }
  SetColor(Blue);

  For i := 0 To 35 Do
    Begin
      If i Mod 2 = 0 Then
        Begin
          Angle := i * 10 * Pi / 180;
          x1 := CenterX + Round(Radius * Cos(Angle));
          y1 := CenterY + Round(Radius * Sin(Angle));
          x2 := CenterX + Round(Radius * Cos(Angle + 5 * Pi / 180));
          y2 := CenterY + Round(Radius * Sin(Angle + 5 * Pi / 180));
          Line(x1, y1, x2, y2);
        End;
    End;
End;


Begin
  GraphDriver := Detect;
  InitGraph(GraphDriver, GraphMode, '');

  If GraphResult <> grOk Then
    Begin
      WriteLn('Error initializing graphics');
      Exit;
    End;

  CenterX := GetMaxX Div 2;
  CenterY := GetMaxY Div 2;
  TriangleSize := 150;

  { Gambar komponen-komponen simbol }
  DrawTriangle;
  DrawEye;
  DrawDashedCircle;

  ReadLn;
  CloseGraph;
End.
