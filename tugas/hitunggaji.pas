program HitungGaji;

uses crt;

var
  jamKerja: integer;
  gajiPerJam, gajiHarian: real;
  jamLembur: integer;

begin
  clrscr;
  gajiPerJam := 500; // Gaji per jam
  writeln('Masukkan jumlah jam kerja: ');
  readln(jamKerja);

  if jamKerja > 7 then
  begin
    jamLembur := jamKerja - 7; // Hitung jam lembur
    gajiHarian := (7 * gajiPerJam) + (jamLembur * gajiPerJam * 1.5);
  end
  else
  begin
    gajiHarian := jamKerja * gajiPerJam; // Gaji tanpa lembur
  end;

  writeln('Gaji harian pegawai adalah: Rp', gajiHarian:0:2);
  readln;
end.
