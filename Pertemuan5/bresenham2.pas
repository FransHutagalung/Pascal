uses graph, crt;

var
  x1, x2, y1, y2: integer;
  nama: string;

procedure init;
var
  gd, gm: integer;
begin
  gm := detect; gd := 0;
  initgraph(gd, gm, 'C:\TP\BGI');
  if graphresult <> grok then
  begin
    writeln('Graph driver', gd, 'Graph Mode', gm, 'not supported');
    halt(1);
  end;
end;

procedure destroy;
begin
  closegraph;
end;

procedure drawbressline(xa, ya, xb, yb: integer);
var
  dx, p, dy, xend: integer;
  x, y: real;
begin
  warna := random(15) + 1;
  settextstyle(DefaultFont, HorizDir, 4);  
  dx := abs(xb - xa);
  dy := abs(yb - ya);
  p := 2 * dy - dx;

  if xa > xb then
  begin
    x := xb;
    y := yb;
    xend := xa;
  end
  else
  begin
    x := xa;
    y := ya;
    xend := xb;
  end;
  putpixel(round(x), round(y), 30);


  while x < xend do
  begin
    x := x + 1;
    if p < 0 then
      p := p + 2 * dy
    else
    begin
      y := y + 1;
      p := p + 2 * dy - 2 * dx;
    end;
    putpixel(round(x), round(y), 30);
  end;

  for i := 0 to 200 do
  begin
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    setcolor(warna);

    delay(300);
  end;

end;

procedure blinkText(x, y: integer; nama: string);
var
  i, w
  
  
  
  
  
  arna: integer;
begin
  settextstyle(DefaultFont, HorizDir, 4);  
  for i := 1 to 200 do
  begin
 
    warna := random(15) + 1;
    setcolor(warna);
    // setSize(5, 5);
    outtextxy(x, y, nama);

    delay(300); 

  
    setcolor(0);
    outtextxy(x, y, nama);

    delay(300);
  end;
end;


procedure blinkTextInput3(prompt: string; var inputVar: integer);
var
  i: integer;
  userInput: string;
begin

  gotoXY(20, 50);
  userInput := '';  { Menyimpan teks yang diketik }
  
  { Teks berkedip sebelum pengguna mulai mengetik }
  for i := 1 to 10 do
  begin
    if KeyPressed then
      break;  { Jika ada input dari pengguna, keluar dari loop berkedip }

    TextColor(LightGreen);         { Warna teks berkedip hijau }
    Write(prompt);                 { Tampilkan prompt berkedip }
    Delay(300);                    { Tunggu 300 ms }
    
    TextColor(Black);              { Warna hitam untuk "menghapus" prompt }
    Write(#13 + StringOfChar(' ', Length(prompt))); { Hapus prompt }
    Delay(300);                    { Tunggu 300 ms }

    Write(#13);                    { Kembali ke awal baris }
  end;

  { Setelah berkedip, tampilkan prompt permanen untuk pengguna mengetik }
  TextColor(White);
  Write(prompt);

  { Menerima input dari pengguna dan menampilkannya di layar }
  ReadLn(inputVar);
end;


procedure blinkTextInput2(prompt: string; var inputVar: integer);
var
  i: integer;
  userInput: string;
begin
  userInput := '';
  
  for i := 1 to 10 do
  begin
    
    if Length(userInput) = 0 then
    begin
      TextColor(LightGreen);         
      Write(prompt);                 
      Delay(300);                 
      
      TextColor(Black);             
      Write(#13 + StringOfChar(' ', Length(prompt))); { Hapus prompt }
      Delay(100);                    
      
      Write(#13);                    { Kembali ke awal baris }
    end;
  end;
  
  TextColor(White);                  { Kembalikan warna teks ke putih }
  Write(prompt);                     { Tampilkan prompt permanen }
  
  { Menerima input dari pengguna }
  ReadLn(inputVar);                  { Meminta input pengguna }
end;


procedure blinkTextInput(prompt: string; var inputVar: integer);
var
  i: integer;
begin
  for i := 1 to 100 do
  begin
    TextColor(LightGreen);        
    Write(prompt);                
    Delay(300);                 
    
    TextColor(White);              
    Write(#13 + StringOfChar(' ', Length(prompt)));
    Delay(300);           

    Write(#13);                  
  end;

  TextColor(White);                
  Write(prompt);                  
  ReadLn(inputVar);                
end;

begin


 


  write('Masukkan Nama => ');
  readln(nama);
  clrscr;
    GotoXY(20 , 50);
  blinkTextInput3('Masukkan X1 => ', x1);
  GotoXY(20 , 100);
  blinkTextInput3('Masukkan Y1 => ', y1);
  GotoXY(20 , 150);
  blinkTextInput3('Masukkan X2 => ', x2);
  GotoXY(20 , 200);
  blinkTextInput3('Masukkan Y2 => ', y2);
  clrscr;

  init;
  textcolor(10);
  textbackground(4);

  drawbressline(x1, y1, x2, y2);

 

  blinkText(30, 10, nama);

  readkey;
  destroy;
end.
