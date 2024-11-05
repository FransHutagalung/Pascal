program MovingLine;
uses crt;  { crt digunakan untuk GotoXY, clrscr, dan delay }

const
  screenWidth = 80;  { Lebar layar terminal (dalam karakter) }
  lineLength = 10;   { Panjang garis yang akan bergerak }

var
  posX: integer;     { Posisi X (horizontal) dari garis }
  direction: integer; { Arah gerakan, 1 untuk maju, -1 untuk mundur }

procedure DrawLine(x: integer);
var
  i: integer;
begin
  GotoXY(x, lineLength);  { Pindah ke posisi X dengan Y tetap (misalnya di baris 10) }
  for i := 1 to lineLength do
    write('-');   { Gambar garis sepanjang lineLength }
end;

procedure ClearLine(x: integer);
var
  i: integer;
begin
  GotoXY(x, 10);  { Pindah ke posisi X yang sama }
  for i := 1 to lineLength do
    write(' ');   { Hapus garis dengan menimpa karakter dengan spasi }
end;

begin
  clrscr;  { Bersihkan layar }
  posX := 1;   { Posisi awal garis di sisi kiri layar }
  direction := 1;  { Mulai bergerak ke kanan (maju) }

  { Loop animasi sampai tombol ditekan }
  while not keypressed do
  begin
    DrawLine(posX);    { Gambar garis di posisi X saat ini }
    delay(50);         { Beri jeda untuk menciptakan efek animasi }
    ClearLine(posX);   { Hapus garis di posisi X saat ini }

    { Update posisi garis berdasarkan arah gerakan }
    posX := posX + direction;

    { Cek apakah garis mencapai tepi layar dan ubah arah jika perlu }
    if (posX = 1) or (posX + lineLength = screenWidth) then
      direction := direction * -1;  { Balik arah gerakan }
  end;

//    if (posX = 3) then
//      setColor(black);
//   end;

  clrscr;  { Bersihkan layar setelah loop selesai }
end.
