program Untitled;

uses crt, dos;

const
   Maks_Pasien = 928;
   Maks_Kamar  = 10;
   Maks_Rawat  = 928; { Maksimal Data Rawat }

type
   DT_Pasien = record
      Kode      : string;
      Nama      : string;
      Alamat    : string;
      JK        : char;
      Usia      : integer;
   end; { EndRecord }

   DT_Kamar  = record
      Kode      : string;
      Kelas     : string;
      Harga     : integer;
   end; { EndRecord }

   DT_Rawat  = record
      Kode      : string;
      NoKamar   : integer;
      Pasien    : string;
      Kamar     : string;
      TglMasuk, BlnMasuk, ThnMasuk    : integer;
      TglKeluar, BlnKeluar, ThnKeluar : integer;
      BiayaTambahan : integer;
      Total     : integer;
   end; { EndRecord }

   Array_Pasien = array[1..Maks_Pasien] of DT_Pasien;
   Array_Kamar  = array[1..Maks_Kamar] of DT_Kamar;
   Array_Rawat  = array[1..Maks_Rawat] of DT_Rawat;

var
   Pasien : Array_Pasien;
   Kamar  : Array_Kamar;
   Rawat  : Array_Rawat;
   File_Pasien : File of DT_Pasien;
   Total_Pasien : integer;
   File_Kamar  : File of DT_Kamar;
   Total_Kamar : integer;
   File_Rawat  : File of DT_Rawat;
   Total_Rawat : integer;
   Pilihan : integer;
   username, password : string;

{ ********************* Lihat Data ********************* }
{ Procedure Baac Data Pasein }
procedure BacaDataPasien(var Pasien : Array_Pasien; var Total_Pasien : integer);
{I.S. : }
{F.S. : }
   var
      Temp : DT_Pasien;
      i : integer;
   begin
      assign(File_Pasien, 'pasien.dat');
      reset(File_Pasien);
      seek(File_Pasien, 0);
      i := 0;
      while not eof (File_Pasien) do
         begin
            i := i + 1;
            read(File_Pasien, Temp);
            Pasien[i].Kode := Temp.Kode;
            Pasien[i].Nama := Temp.Nama;
            Pasien[i].Alamat := Temp.Alamat;
            Pasien[i].JK := Temp.JK;
            Pasien[i].Usia := Temp.Usia;
         end; { EndWhile }
      close(File_Pasien);
      Total_Pasien := i;
   end; { EndProcedure }

{ Procedure Baac Data Kamar }
procedure BacaDataKamar(var Kamar : Array_Kamar; var Total_Kamar : integer);
{I.S. : }
{F.S. : }
   var
      Temp : DT_Kamar;
      i : integer;
   begin
      assign(File_Kamar, 'kamar.dat');
      reset(File_Kamar);
      seek(File_Kamar, 0);
      i := 0;
      while not eof (File_Kamar) do
         begin
            i := i + 1;
            read(File_Kamar, Temp);
            Kamar[i].Kode := Temp.Kode;
            Kamar[i].Kelas := Temp.Kelas;
            Kamar[i].Harga := Temp.Harga;
         end; { EndWhile }
      close(File_Kamar);
      Total_Kamar := i;
   end; { EndProcedure }

{ Procedure Baac Data Kamar }
procedure BacaDataRawat(var Rawat : Array_Rawat; var Total_Rawat : integer);
{I.S. : }
{F.S. : }
   var
      Temp : DT_Rawat;
      i : integer;
   begin
      assign(File_Rawat, 'rawat.dat');
      reset(File_Rawat);
      seek(File_Rawat, 0);
      i := 0;
      while not eof (File_Rawat) do
         begin
            i := i + 1;
            read(File_Rawat, Temp);
            Rawat[i].Kode      := Temp.Kode;
            Rawat[i].NoKamar   := Temp.NoKamar;
            Rawat[i].Pasien    := Temp.Pasien;
            Rawat[i].Kamar     := Temp.Kamar;
            Rawat[i].TglMasuk  := Temp.TglMasuk;
            Rawat[i].BlnMasuk  := Temp.BlnMasuk;
            Rawat[i].ThnMasuk  := Temp.ThnMasuk;
            Rawat[i].TglKeluar := Temp.TglKeluar;
            Rawat[i].BlnKeluar := Temp.BlnKeluar;
            Rawat[i].ThnKeluar := Temp.ThnKeluar;
            Rawat[i].BiayaTambahan := Temp.BiayaTambahan;
            Rawat[i].Total := Temp.Total;
         end; { EndWhile }
      close(File_Rawat);
      Total_Rawat := i;
   end; { EndProcedure }

{ ********************* Cari Data ********************* }
function CariDataPasien(Kode : string) : DT_Pasien;
{I.S. : Kode pasien sudah terdefinisi}
{F.S. : }
   var
      Ketemu    : boolean;
      i       : integer;
      Temp : DT_Pasien;

   begin
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataPasien(Pasien, Total_Pasien);
      while(Not Ketemu) and (i <= Total_Pasien) do
         begin
            if(Pasien[i].Kode = Kode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { EndWhile }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         CariDataPasien := Pasien[i]
      else
         begin
            Temp.Kode := 'error';
            Temp.Nama := 'error';
            Temp.Alamat := 'error';
            Temp.JK := 'x';
            Temp.Usia := 0;
            CariDataPasien := Temp;
         end; { EndIf }
   end; { EndFunction }

function CariDataKamar(Kode : string) : DT_Kamar;
{I.S. : Kode pasien sudah terdefinisi}
{F.S. : }
   var
      Ketemu    : boolean;
      i       : integer;
      Temp : DT_Kamar;

   begin
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataKamar(Kamar, Total_Kamar);
      while(Not Ketemu) and (i <= Total_Kamar) do
         begin
            if(Kamar[i].Kode = Kode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { EndWhile }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         CariDataKamar := Kamar[i]
      else
         begin
            Temp.Kode := 'error';
            Temp.Kelas := 'error';
            Temp.Harga := 0;
            CariDataKamar := Temp;
         end; { EndIf }
   end; { EndFunction }

function CariDataRawat(Kode : string) : DT_Rawat;
{I.S. : Kode pasien sudah terdefinisi}
{F.S. : }
   var
      Ketemu    : boolean;
      i       : integer;
      Temp : DT_Rawat;

   begin
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataRawat(Rawat, Total_Rawat);
      while(Not Ketemu) and (i <= Total_Rawat) do
         begin
            if(Rawat[i].Kode = Kode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { EndWhile }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         CariDataRawat := Rawat[i]
      else
         begin
            Temp.Kode := 'error';
            CariDataRawat := Temp;
         end; { EndIf }
   end; { EndFunction }

function CariDataRawatIndeks(Kode : string) : integer;
{I.S. : Kode pasien sudah terdefinisi}
{F.S. : menghasilkan indeks dari data yang dicari}
   var
      Ketemu    : boolean;
      i       : integer;

   begin
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataRawat(Rawat, Total_Rawat);
      while(Not Ketemu) and (i <= Total_Rawat) do
         begin
            if(Rawat[i].Kode = Kode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { EndWhile }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         CariDataRawatIndeks := i;
   end; { EndFunction }

function CariNoKamarPasien(KodePasien : string) : integer;
{I.S. : Kode pasien sudah terdefinisi}
{F.S. : Menghasilkan nomor kamar yang ditempati pasien}
   var
      Ketemu : boolean;
      i      : integer;

   begin
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataRawat(Rawat, Total_Rawat);
      while(Not Ketemu) and (i <= Total_Rawat) do
         begin
            if(Rawat[i].Pasien = KodePasien) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { EndWhile }

      { Menampilkan data apakah No Kamar ditemukan atau tidak }
      if(Ketemu) then
         CariNoKamarPasien := Rawat[i].NoKamar
      else
         begin
            CariNoKamarPasien := 0;
         end; { EndIf }
   end; { EndFunction }

{ Procedure Lihat Data Pasien }
procedure LihatDataPasien(Pasien : Array_Pasien; Total : integer);
{I.S. : }
{F.S. : }
   var
      i : integer;

   begin
      clrscr;
      writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, 2); write('³');
      gotoxy(31, 2); write('TAMPIL DATA PASIEN');
      gotoxy(79, 2); writeln('³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´');
      writeln('³    Kode    ³        Nama         ³          Alamat          ³  JK  ³  Usia  ³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´');
      for i:=1 to Total do
         begin
            gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
            gotoxy(3, i+5); writeln(Pasien[i].Kode);
            gotoxy(16, i+5); writeln(Pasien[i].Nama);
            gotoxy(38, i+5); writeln(Pasien[i].Alamat);
            gotoxy(66, i+5); writeln(Pasien[i].JK);
            gotoxy(74, i+5); writeln(Pasien[i].Usia);
         end; { EndWhile }
      gotoxy(1, i+6); writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ');
   end; { EndProcedure }

{ Procedure Lihat Data Pasien }
procedure LihatDataKamar(Kamar : Array_Kamar; Total : integer);
{I.S. : }
{F.S. : }
   var
      i : integer;

   begin
      clrscr;
      gotoxy(12, 1); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(12, 2); write('³                   TAMPIL DATA KAMAR                  ³');
      gotoxy(12, 3); write('ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(12, 4); write('³   Kode   ³             Kelas             ³   Harga   ³');
      gotoxy(12, 5); write('ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´');
      for i:=1 to Total do
         begin
            gotoxy(12, i+5); write('³          ³                               ³           ³');
            gotoxy(14, i+5); writeln(Kamar[i].Kode);
            gotoxy(25, i+5); writeln(Kamar[i].Kelas);
            gotoxy(57, i+5); writeln(Kamar[i].Harga);
         end; { EndWhile }
      gotoxy(12, i+6); writeln('ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ');
   end; { EndProcedure }

{ Procedure Lihat Data Pasien }
procedure LihatDataRawat(Rawat : Array_Rawat; Total : integer);
{I.S. : }
{F.S. : }
   var
      i : integer;
      DataPasien : DT_Pasien;

   begin
      clrscr;
      gotoxy(1, 1); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, 2); write('³                              TAMPIL DATA RAWAT                              ³');
      gotoxy(1, 3); write('ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(1, 4); write('³  Kode   ³        Nama         ³    Tgl Masuk   ³   Tgl Keluar   ³ No. Kamar ³');
      gotoxy(1, 5); write('ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´');
      for i:=1 to Total do
         begin
            gotoxy(1, i+5); write('³         ³                     ³    /    /      ³    /    /      ³           ³');
            gotoxy(3, i+5); writeln(Rawat[i].Kode);
            DataPasien := CariDataPasien(Rawat[i].Kode);
            gotoxy(14, i+5); writeln(DataPasien.Nama);
            gotoxy(35, i+5); writeln(Rawat[i].TglMasuk);
            gotoxy(40, i+5); writeln(Rawat[i].BlnMasuk);
            gotoxy(45, i+5); writeln(Rawat[i].ThnMasuk);
            gotoxy(52, i+5); writeln(Rawat[i].TglKeluar);
            gotoxy(57, i+5); writeln(Rawat[i].BlnKeluar);
            gotoxy(62, i+5); writeln(Rawat[i].ThnKeluar);
            gotoxy(70, i+5); writeln(Rawat[i].NoKamar);
         end; { EndWhile }
      gotoxy(1, i+6); writeln('ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ');
   end; { EndProcedure }

{ Procedure Urut Nama }
procedure UrutNama(var Pasien : Array_Pasien; N : integer);
{I.S. : data Pasien (1:N) sudah terdefinisi}
{F.S. : menghasilkan data pasien yang sudah terurut secara ascending menggunakan bubble sort}
   var
      i, j : integer;
      Temp : DT_Pasien;

   begin
      for i:=1 to (N-1) do
         begin
            for j:=N downto (i+1) do
               begin
                  if(Pasien[j].Nama < Pasien[j-1].Nama) then
                     begin
                        Temp    := Pasien[j];
                        Pasien[j]  := Pasien[j-1];
                        Pasien[j-1] := Temp;
                     end; { EndIf }
               end; { EndFor}
         end; { EndFor }
   end; { EndProcedure }

{ Procedure Urut Nama }
procedure UrutHarga(var Kamar : Array_Kamar; N : integer);
{I.S. : data Kamar (1:N) sudah terdefinisi}
{F.S. : menghasilkan data kamar yang sudah terurut secara ascending menggunakan bubble sort}
   var
      i, j : integer;
      Temp : DT_Kamar;

   begin
      for i:=1 to (N-1) do
         begin
            for j:=N downto (i+1) do
               begin
                  if(Kamar[j].Harga < Kamar[j-1].Harga) then
                     begin
                        Temp    := Kamar[j];
                        Kamar[j]  := Kamar[j-1];
                        Kamar[j-1] := Temp;
                     end; { EndIf }
               end; { EndFor}
         end; { EndFor }
   end; { EndProcedure }

{ Procedure Urut Kode Rawat }
procedure UrutKodeRawat(var Rawat : Array_Rawat; N : integer);
{I.S. : data Rawat (1:N) sudah terdefinisi}
{F.S. : menghasilkan data rawat yang sudah terurut secara ascending menggunakan bubble sort}
   var
      i, j : integer;
      Temp : DT_Rawat;

   begin
      for i:=1 to (N-1) do
         begin
            for j:=N downto (i+1) do
               begin
                  if(Rawat[j].Kode < Rawat[j-1].Kode) then
                     begin
                        Temp    := Rawat[j];
                        Rawat[j]  := Rawat[j-1];
                        Rawat[j-1] := Temp;
                     end; { EndIf }
               end; { EndFor}
         end; { EndFor }
   end; { EndProcedure }

{ Procedure Cari Kode Pasien }
procedure CariKodePasien(Pasien : Array_Pasien);
{I.S. : Data array pasien sudah terdefinisi}
{F.S. : Menampilkan data pasien berdasarkan Kode menggunakan metode sequential search dengan boolean}
   var
      Ketemu    : boolean;
      i       : integer;
      CariKode   : string;

   begin
      clrscr;
      write('Kode yang akan dicari : '); readln(CariKode);

      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataPasien(Pasien, Total_Pasien);
      while(Not Ketemu) and (i <= Total_Pasien) do
         begin
            if(Pasien[i].Kode = CariKode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { End While }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         begin
            writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            writeln('³                           HASIL PENCARIAN PASIEN                            ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´');
            writeln('³  Kode   ³        Nama         ³          Alamat          ³  JK  ³ No. Kamar ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´');
            gotoxy(1, 7); write('³         ³                     ³                          ³      ³           ³');
            gotoxy(3, 7); write(Pasien[i].Kode);
            gotoxy(13, 7); write(Pasien[i].Nama);
            gotoxy(35, 7); write(Pasien[i].Alamat);
            gotoxy(63, 7); write(Pasien[i].JK);
            gotoxy(69, 7); write(CariNoKamarPasien(Pasien[i].Kode));
            writeln;
            writeln('ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ');
         end
      else
         begin
            writeln('Kode ', CariKode, ' tidak ditemukan!');
            readln;
         end; { EndIF }
      readln;
   end; { EndProcedure }

{ Procedure Cari Nama }
procedure CariNama(Pasien : Array_Pasien);
{I.S. : Data array Pasien sudah terdefinisi}
{F.S. : Menampilkan data pasien berdasarkan Nama menggunakan metode sequential search dengan boolean}
   var
      Ketemu    : boolean;
      i,j,No     : integer;
      CariNama   : string;

   begin
      clrscr;
      write('Nama yang akan dicari : '); readln(CariNama);

      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataPasien(Pasien, Total_Pasien);
      while(Not Ketemu) and (i <= Total_Pasien) do
         begin
            if(pos(upcase(CariNama), upcase(Pasien[i].Nama)) > 0) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { End While }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         begin
            No := 1;
            writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            writeln('³                           HASIL PENCARIAN PASIEN                            ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´');
            writeln('³  Kode   ³        Nama         ³          Alamat          ³  JK  ³ No. Kamar ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´');
            for j:=i to Total_Pasien do
               begin
                  if(pos(upcase(CariNama), upcase(Pasien[j].Nama)) > 0) then
                     begin
                        gotoxy(1, No+6); write('³         ³                     ³                          ³      ³           ³');
                        gotoxy(3, No+6); write(Pasien[j].Kode);
                        gotoxy(13, No+6); write(Pasien[j].Nama);
                        gotoxy(35, No+6); write(Pasien[j].Alamat);
                        gotoxy(63, No+6); write(Pasien[j].JK);
                        gotoxy(69, No+6); write(CariNoKamarPasien(Pasien[j].Kode));
                        No := No + 1;
                     end; { End If }
               end; { End For }
            writeln;
            writeln('ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ');
         end
      else
         begin
            Total_Pasien := 0;
            writeln('Nama ', CariNama, ' tidak ditemukan!');
            readln;
         end; { EndIF }
      readln;
   end; { EndProcedure }

{ Procedure Cari Kode Pasien }
procedure CariKodeRawatInap(Rawat : Array_Rawat);
{I.S. : Data pasien sudah terdefinisi}
{F.S. : Menampilkan data pasien berdasarkan Kode menggunakan metode sequential search dengan boolean}
   var
      Ketemu    : boolean;
      i       : integer;
      CariKode   : string;
      DataPasien : DT_Pasien;

   begin
      clrscr;
      write('Kode rawat yang akan dicari : '); readln(CariKode);

      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataRawat(Rawat, Total_Rawat);
      while(Not Ketemu) and (i <= Total_Rawat) do
         begin
            if(Rawat[i].Kode = CariKode) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { End While }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         begin
            writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            writeln('³                        HASIL PENCARIAN DATA RAWAT                           ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ´');
            writeln('³ KD. PSN ³        Nama         ³    Tgl Masuk   ³   Tgl Keluar   ³ No. Kamar ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´');
            gotoxy(1, 7); write('³         ³                     ³    /    /      ³    /    /      ³           ³');
            gotoxy(3, 7); writeln(Rawat[i].Kode);
            DataPasien := CariDataPasien(Rawat[i].Kode);
            gotoxy(14, 7); writeln(DataPasien.Nama);
            gotoxy(35, 7); writeln(Rawat[i].TglMasuk);
            gotoxy(40, 7); writeln(Rawat[i].BlnMasuk);
            gotoxy(45, 7); writeln(Rawat[i].ThnMasuk);
            gotoxy(52, 7); writeln(Rawat[i].TglKeluar);
            gotoxy(57, 7); writeln(Rawat[i].BlnKeluar);
            gotoxy(52, 7); writeln(Rawat[i].ThnKeluar);
            gotoxy(70, 7); writeln(Rawat[i].NoKamar);
            writeln('ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ');
         end
      else
         begin
            writeln('Kode ', CariKode, ' tidak ditemukan!');
            readln;
         end; { EndIF }
      readln;
   end; { EndProcedure }

{ Procedure Cari Kisaran Harga }
procedure CariHarga(Kamar : Array_Kamar);
{I.S. : Data array kamar sudah terdefinisi}
{F.S. : Menampilkan data kamar berdasarkan harga menggunakan metode sequential search dengan boolean}
   var
      Ketemu    : boolean;
      i,j,No     : integer;
      HargaBawah, HargaAtas   : integer;

   begin
      clrscr;
      write('Harga terendah  : '); readln(HargaBawah);
      write('Harga tertinggi : '); readln(HargaAtas);
      { Proses Searching }
      i := 1;
      Ketemu := False;
      BacaDataKamar(Kamar, Total_Kamar);
      while(Not Ketemu) and (i <= Total_Kamar) do
         begin
            if(Kamar[i].Harga >= HargaBawah) and (Kamar[i].Harga <= HargaAtas) then
               begin
                  Ketemu := True;
               end
            else
               i := i + 1;
         end; { End While }

      { Menampilkan data apakah Nama ditemukan atau tidak }
      if(Ketemu) then
         begin
            No := 1;
            writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            writeln('³                HASIL PENCARIAN KAMAR                     ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
            writeln('³   Kode   ³             Kelas             ³     Harga     ³');
            writeln('ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');

            for j:=i to Total_Kamar do
               begin
                  if(Kamar[j].Harga >= HargaBawah) and (Kamar[j].Harga <= HargaAtas) then
                     begin
                        gotoxy(1, No+7); write('³          ³                               ³ Rp.           ³');;
                        gotoxy(3, No+7); write(Kamar[j].Kode);
                        gotoxy(14, No+7); write(Kamar[j].Kelas);
                        gotoxy(50, No+7); write(Kamar[j].Harga);
                        No := No + 1;
                     end; { End If }
               end; { End For }
            writeln;
            writeln('ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
         end
      else
         begin
            Total_Pasien := 0;
            writeln('Harga dengan kisaran ', HargaBawah, '-', HargaAtas, ' tidak ditemukan!');
            readln;
         end; { EndIF }
      readln;
   end; { EndProcedure }

{ ********************* Isi Data ********************* }
{ Procedure Isi Data Pasien }
procedure isiPasien(var File_Pasien : File of DT_Pasien);
{I.S. : }
{F.S. : }
   var
      Temp : DT_Pasien;
      i : integer;

   begin
      assign(File_Pasien, 'pasien.dat');
      rewrite(File_Pasien);

      clrscr;
      writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, 2); write('³');
      gotoxy(31, 2); write('INPUT DATA PASIEN');
      gotoxy(79, 2); writeln('³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´');
      writeln('³    Kode    ³        Nama         ³          Alamat          ³  JK  ³  Usia  ³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´');

      { Memasukan Data Pertama }
      i := 1;
      gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
      { Keterangan }
      gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, i+21); write('³ Keterangan :                                  ³');
      gotoxy(1, i+22); write('³ 1. ketik STOP di kode pasien untuk berhenti   ³');
      gotoxy(1, i+23); write('³ 2. Jenis Kelamin hanya diisi L atau P         ³');
      gotoxy(1, i+24); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(3, i+5); readln(Temp.Kode);
      while(upcase(Temp.Kode) <> 'STOP') do
         begin
            gotoxy(16, i+5); readln(Temp.Nama);
            gotoxy(38, i+5); readln(Temp.Alamat);
            gotoxy(66, i+5); readln(Temp.JK);
            gotoxy(74, i+5); readln(Temp.Usia);
            { Bersihkan Keterangan }
            gotoxy(1, i+20); clreol;
            gotoxy(1, i+21); clreol;
            gotoxy(1, i+22); clreol;
            gotoxy(1, i+23); clreol;
            gotoxy(1, i+24); clreol;
            write(File_Pasien, Temp);

            { Memasukan Data Selanjutnya }
            i := i + 1;
            gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
            { Keterangan }
            gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(1, i+21); write('³ Keterangan :                                  ³');
            gotoxy(1, i+22); write('³ 1. ketik STOP di kode pasien untuk berhenti   ³');
            gotoxy(1, i+23); write('³ 2. Jenis Kelamin hanya diisi L atau P         ³');
            gotoxy(1, i+24); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            gotoxy(3, i+5); readln(Temp.Kode);
         end;
      gotoxy(1, i+5); writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ');
      close(File_Pasien);
      readln;
   end; { EndProcedure }

{ Procedure Tambah Data Pasien }
procedure TambahPasien(var File_Pasien : File of DT_Pasien);
{I.S. : }
{F.S. : }
   var
      Temp : DT_Pasien;
      i : integer;

   begin
      assign(File_Pasien, 'pasien.dat');
      {$I-}
      reset(File_Pasien);
      {$I+};
      if ioresult<>0 then rewrite(File_Pasien);

      clrscr;
      writeln('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, 2); write('³');
      gotoxy(31, 2); write('TAMBAH DATA PASIEN');
      gotoxy(79, 2); writeln('³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄ´');
      writeln('³    Kode    ³        Nama         ³          Alamat          ³  JK  ³  Usia  ³');
      writeln('ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´');
      i := 1;
      while not eof (File_Pasien) do
         begin
            read(File_Pasien, Temp);
            gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
            gotoxy(3, i+5); writeln(Temp.Kode);
            gotoxy(16, i+5); writeln(Temp.Nama);
            gotoxy(38, i+5); writeln(Temp.Alamat);
            gotoxy(66, i+5); writeln(Temp.JK);
            gotoxy(74, i+5); writeln(Temp.Usia);
            i := i + 1;
         end; { EndWhile }

      seek(File_Pasien, filesize(File_Pasien));
      { Memasukan Data Pertama }
      gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
      { Keterangan }
      gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, i+21); write('³ Keterangan :                                  ³');
      gotoxy(1, i+22); write('³ 1. ketik STOP di kode pasien untuk berhenti   ³');
      gotoxy(1, i+23); write('³ 2. Jenis Kelamin hanya diisi L atau P         ³');
      gotoxy(1, i+24); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(3, i+5); readln(Temp.Kode);

      while(upcase(Temp.Kode) <> 'STOP') do
         begin
            gotoxy(16, i+5); readln(Temp.Nama);
            gotoxy(38, i+5); readln(Temp.Alamat);
            gotoxy(66, i+5); readln(Temp.JK);
            gotoxy(74, i+5); readln(Temp.Usia);
            { Bersihkan Keterangan }
            gotoxy(1, i+20); clreol;
            gotoxy(1, i+21); clreol;
            gotoxy(1, i+22); clreol;
            gotoxy(1, i+23); clreol;
            gotoxy(1, i+24); clreol;
            write(File_Pasien, Temp);

            { Memasukan Data Selanjutnya }
            i := i + 1;
            gotoxy(1, i+5); write('³            ³                     ³                          ³      ³        ³');
            { Keterangan }
            gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(1, i+21); write('³ Keterangan :                                  ³');
            gotoxy(1, i+22); write('³ 1. ketik STOP di kode pasien untuk berhenti   ³');
            gotoxy(1, i+23); write('³ 2. Jenis Kelamin hanya diisi L atau P         ³');
            gotoxy(1, i+24); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            gotoxy(3, i+5); readln(Temp.Kode);
         end;
      gotoxy(1, i+5); writeln('ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÙ');
      close(File_Pasien);
      readln;
   end; { EndProcedure }

procedure isiKamar(var File_Kamar : File of DT_Kamar);
{I.S. : User memasukkan data kamar }
{F.S. : Menghasilkan file kamar.dat }
   var
      Temp : DT_Kamar;
      i : integer;

   begin
      assign(File_Kamar, 'kamar.dat');
      rewrite(File_Kamar);

      clrscr;
      gotoxy(10, 1); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(10, 2); write('³                     INPUT DATA KAMAR                     ³');
      gotoxy(10, 3); write('ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(10, 4); write('³   Kode   ³             Kelas             ³     Harga     ³');
      gotoxy(10, 5); write('ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');

      { Memasukan Data Pertama }
      i := 1;
      gotoxy(10, i+5); write('³          ³                               ³ Rp.           ³');
      { Keterangan }
      gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, i+21); write('³ Keterangan :                                  ³');
      gotoxy(1, i+22); write('³ 1. ketik STOP di kode kamar untuk berhenti    ³');
      gotoxy(1, i+23); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(12, i+5); readln(Temp.Kode);
      while(upcase(Temp.Kode) <> 'STOP') do
         begin
            gotoxy(23, i+5); readln(Temp.Kelas);
            gotoxy(59, i+5); readln(Temp.Harga);
            { Bersihkan Keterangan }
            gotoxy(1, i+20); clreol;
            gotoxy(1, i+21); clreol;
            gotoxy(1, i+22); clreol;
            gotoxy(1, i+23); clreol;
            gotoxy(1, i+24); clreol;
            write(File_Kamar, Temp);

            { Memasukan Data Selanjutnya }
            i := i + 1;
            gotoxy(10, i+5); write('³          ³                               ³ Rp.           ³');
            { Keterangan }
            gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(1, i+21); write('³ Keterangan :                                  ³');
            gotoxy(1, i+22); write('³ 1. ketik STOP di kode kamar untuk berhenti    ³');
            gotoxy(1, i+23); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            gotoxy(12, i+5); readln(Temp.Kode);
         end;
      gotoxy(10, i+5); writeln('ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      close(File_Kamar);
      readln;
   end; { EndProcedure }

procedure tambahKamar(var File_Kamar : File of DT_Kamar);
{I.S. : User memasukkan data kamar }
{F.S. : Menghasilkan file kamar.dat }
   var
      Temp : DT_Kamar;
      i : integer;

   begin
      assign(File_Kamar, 'kamar.dat');
      {$I-}
      reset(File_Kamar);
      {$I+};
      if ioresult<>0 then rewrite(File_Kamar);

      clrscr;
      gotoxy(10, 1); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(10, 2); write('³                    TAMBAH DATA KAMAR                     ³');
      gotoxy(10, 3); write('ÃÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(10, 4); write('³   Kode   ³             Kelas             ³     Harga     ³');
      gotoxy(10, 5); write('ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      i := 1;
      while not eof (File_Kamar) do
         begin
            read(File_Kamar, Temp);
            gotoxy(10, i+5); write('³          ³                               ³ Rp.           ³');
            gotoxy(12, i+5); writeln(Temp.Kode);
            gotoxy(23, i+5); writeln(Temp.Kelas);
            gotoxy(59, i+5); writeln(Temp.Harga);
            i := i + 1;
         end; { EndWhile }
      seek(File_Kamar, filesize(File_Kamar));
      { Memasukan Data Pertama }
      gotoxy(10, i+5); write('³          ³                               ³ Rp.           ³');
      { Keterangan }
      gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, i+21); write('³ Keterangan :                                  ³');
      gotoxy(1, i+22); write('³ 1. ketik STOP di kode kamar untuk berhenti    ³');
      gotoxy(1, i+23); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(12, i+5); readln(Temp.Kode);
      while(upcase(Temp.Kode) <> 'STOP') do
         begin
            gotoxy(23, i+5); readln(Temp.Kelas);
            gotoxy(59, i+5); readln(Temp.Harga);
            { Bersihkan Keterangan }
            gotoxy(1, i+20); clreol;
            gotoxy(1, i+21); clreol;
            gotoxy(1, i+22); clreol;
            gotoxy(1, i+23); clreol;
            gotoxy(1, i+24); clreol;
            write(File_Kamar, Temp);

            { Memasukan Data Selanjutnya }
            i := i + 1;
            gotoxy(10, i+5); write('³          ³                               ³ Rp.           ³');
            { Keterangan }
            gotoxy(1, i+20); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(1, i+21); write('³ Keterangan :                                  ³');
            gotoxy(1, i+22); write('³ 1. ketik STOP di kode kamar untuk berhenti    ³');
            gotoxy(1, i+23); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            gotoxy(12, i+5); readln(Temp.Kode);
         end;
      gotoxy(10, i+5); writeln('ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      close(File_Kamar);
      readln;
   end; { EndProcedure }

{ Procedure Input Data Rawat }
procedure isiDataRawat(var File_Rawat : File of DT_Rawat);
{I.S. : }
{F.S. : }
   var
      DataPasien: DT_Pasien;
      DataKamar : DT_Kamar;
      Temp : DT_Rawat;

   begin
      assign(File_Rawat, 'rawat.dat');
      rewrite(File_Rawat);

      clrscr;
      gotoxy(14, 7); write('ÚÄ DATA PASIEN RAWAT INAP ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(14, 8); write('³ Kode Rawat    :                                  ³');
      gotoxy(14, 9); write('³ Kode Pasien   :                                  ³');
      gotoxy(14, 10); write('³ Nama Pasien   :                                  ³');
      gotoxy(14, 11); write('³ Usia Pasien   :                                  ³');
      gotoxy(14, 12); write('³ Kode Kamar    :                                  ³');
      gotoxy(14, 13); write('³ Kelas Kamar   :                                  ³');
      gotoxy(14, 14); write('³ Harga Kamar   :                                  ³');
      gotoxy(14, 15); write('³ No Kamar      :                                  ³');
      gotoxy(14, 16); write('³ Tanggal Masuk : dd / mm / yyyy                   ³');
      gotoxy(14, 17); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(32, 8); readln(Temp.Kode);
      gotoxy(32, 9); readln(Temp.Pasien);
      DataPasien := CariDataPasien(Temp.Pasien);
      while(DataPasien.Kode = 'error') do
         begin
            gotoxy(16, 18); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(16, 19); write('³  ');
            textcolor(yellow); write('Pasien Tidak Ditemukan, Ulangi Tekan Enter!');
            textcolor(white); write('  ³');
            gotoxy(16, 20); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(16, 18); clreol;
            gotoxy(16, 19); clreol;
            gotoxy(15, 20); clreol;
            gotoxy(32, 9); clreol;
            gotoxy(65, 9); write('³');
            gotoxy(32, 9); readln(Temp.Pasien);
            DataPasien := CariDataPasien(Temp.Pasien);
         end; { EndWhile }
      gotoxy(32, 10); write(DataPasien.Nama);
      gotoxy(32, 11); write(DataPasien.Usia, ' tahun');
      gotoxy(32, 12); readln(Temp.Kamar);
      DataKamar := CariDataKamar(Temp.Kamar);
      while(DataKamar.Kode = 'error') do
         begin
            gotoxy(16, 18); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(16, 19); write('³  ');
            textcolor(yellow); write('Kamar Tidak Ditemukan, Ulangi Tekan Enter!');
            textcolor(white); write('   ³');
            gotoxy(16, 20); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(16, 18); clreol;
            gotoxy(16, 19); clreol;
            gotoxy(15, 20); clreol;
            gotoxy(32, 12); clreol;
            gotoxy(65, 12); write('³');
            gotoxy(32, 12); readln(Temp.Kamar);
            DataKamar := CariDataKamar(Temp.Kamar);
         end; { EndWhile }
      gotoxy(32, 13); write(DataKamar.Kelas);
      gotoxy(32, 14); write('Rp. ', DataKamar.Harga);
      gotoxy(32, 15); readln(Temp.NoKamar);
      gotoxy(32, 16); readln(Temp.TglMasuk);
      gotoxy(37, 16); readln(Temp.BlnMasuk);
      gotoxy(42, 16); readln(Temp.ThnMasuk);
      Temp.TglKeluar := 0;
      Temp.BlnKeluar := 0;
      Temp.ThnKeluar := 0;
      write(File_Rawat, Temp);
      gotoxy(14, 18); write('Data Berhaasil ditambahkan, Tekan enter untuk kembali!');
      close(File_Rawat);
      readln;
   end; { EndProcedure }

{ Procedure Input Data Rawat }
procedure tambahDataRawat(var File_Rawat : File of DT_Rawat);
{I.S. : }
{F.S. : }
   var
      DataPasien: DT_Pasien;
      DataKamar : DT_Kamar;
      Temp : DT_Rawat;

   begin
      assign(File_Rawat, 'rawat.dat');
      reset(File_Rawat);
      if ioresult<>0 then rewrite(File_Rawat);

      clrscr;
      gotoxy(14, 7); write('ÚÄ DATA PASIEN RAWAT INAP ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(14, 8); write('³ Kode Rawat    :                                  ³');
      gotoxy(14, 9); write('³ Kode Pasien   :                                  ³');
      gotoxy(14, 10); write('³ Nama Pasien   :                                  ³');
      gotoxy(14, 11); write('³ Usia Pasien   :                                  ³');
      gotoxy(14, 12); write('³ Kode Kamar    :                                  ³');
      gotoxy(14, 13); write('³ Kelas Kamar   :                                  ³');
      gotoxy(14, 14); write('³ Harga Kamar   :                                  ³');
      gotoxy(14, 15); write('³ No Kamar      :                                  ³');
      gotoxy(14, 16); write('³ Tanggal Masuk : dd / mm / yyyy                   ³');
      gotoxy(14, 17); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(32, 8); readln(Temp.Kode);
      gotoxy(32, 9); readln(Temp.Pasien);
      DataPasien := CariDataPasien(Temp.Pasien);
      while(DataPasien.Kode = 'error') do
         begin
            gotoxy(16, 18); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(16, 19); write('³  ');
            textcolor(yellow); write('Pasien Tidak Ditemukan, Ulangi Tekan Enter!');
            textcolor(white); write('  ³');
            gotoxy(16, 20); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(16, 18); clreol;
            gotoxy(16, 19); clreol;
            gotoxy(15, 20); clreol;
            gotoxy(32, 9); clreol;
            gotoxy(65, 9); write('³');
            gotoxy(32, 9); readln(Temp.Pasien);
            DataPasien := CariDataPasien(Temp.Pasien);
         end; { EndWhile }
      gotoxy(32, 10); write(DataPasien.Nama);
      gotoxy(32, 11); write(DataPasien.Usia, ' tahun');
      gotoxy(32, 12); readln(Temp.Kamar);
      DataKamar := CariDataKamar(Temp.Kamar);
      while(DataKamar.Kode = 'error') do
         begin
            gotoxy(16, 18); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(16, 19); write('³  ');
            textcolor(yellow); write('Kamar Tidak Ditemukan, Ulangi Tekan Enter!');
            textcolor(white); write('   ³');
            gotoxy(16, 20); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(16, 18); clreol;
            gotoxy(16, 19); clreol;
            gotoxy(15, 20); clreol;
            gotoxy(32, 12); clreol;
            gotoxy(65, 12); write('³');
            gotoxy(32, 12); readln(Temp.Kamar);
            DataKamar := CariDataKamar(Temp.Kamar);
         end; { EndWhile }
      gotoxy(32, 13); write(DataKamar.Kelas);
      gotoxy(32, 14); write('Rp. ', DataKamar.Harga);
      gotoxy(32, 15); readln(Temp.NoKamar);
      gotoxy(32, 16); readln(Temp.TglMasuk);
      gotoxy(37, 16); readln(Temp.BlnMasuk);
      gotoxy(42, 16); readln(Temp.ThnMasuk);
      Temp.TglKeluar := 0;
      Temp.BlnKeluar := 0;
      Temp.ThnKeluar := 0;
      seek(File_Rawat, filesize(File_Rawat));
      write(File_Rawat, Temp);
      gotoxy(14, 18); write('Data Berhaasil ditambahkan, Tekan enter untuk kembali!');
      close(File_Rawat);
      readln;
   end; { EndProcedure }

{ Procedure Pembayaran }
procedure Pembayaran(var File_Rawat : File of DT_Rawat);
{I.S. : data array rawat sudah terdefisini }
{F.S. : menampilkan jumlah yang harus dibayar pasien }
   var
      DataPasien : DT_Pasien;
      DataKamar : DT_Kamar;
      DataRawat : DT_Rawat;
      JmlHariMasuk, JmlHariKeluar, JumlahBiaya, IndeksFile : integer;

   begin
      clrscr;
      gotoxy(14, 6); write('ÚÄ PEMBAYARAN ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(14, 7); write('³ Kode Rawat    :                                  ³');
      gotoxy(14, 8); write('³ Nama Pasien   :                                  ³');
      gotoxy(14, 9); write('³ Usia Pasien   :                                  ³');
      gotoxy(14, 10); write('³ Jenis Kelamin :                                  ³');
      gotoxy(14, 11); write('³ No Kamar      :                                  ³');
      gotoxy(14, 11); write('³ Kelas Kamar   :                                  ³');
      gotoxy(14, 12); write('³ Harga Kamar   : Rp.                              ³');
      gotoxy(14, 13); write('³ Tanggal Masuk :    /    /       (dd / mm / yyyy) ³');
      gotoxy(14, 14); write('³ Tanggal Keluar:    /    /       (dd / mm / yyyy) ³');
      gotoxy(14, 15); write('³ Biaya Tambahan: Rp.                              ³');
      gotoxy(14, 16); write('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(14, 17); write('³ Total         : Rp.                              ³');
      gotoxy(14, 18); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(32, 7); readln(DataRawat.Kode);
      DataRawat := CariDataRawat(DataRawat.Kode);
      IndeksFile := CariDataRawatIndeks(DataRawat.Kode);
      while(DataRawat.Kode = 'error') do
         begin
            gotoxy(16, 19); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(16, 20); write('³  ');
            textcolor(yellow); write('Pasien Tidak Ditemukan, Ulangi Tekan Enter!');
            textcolor(white); write('  ³');
            gotoxy(16, 21); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(16, 19); clreol;
            gotoxy(16, 20); clreol;
            gotoxy(15, 21); clreol;
            gotoxy(32, 7); clreol;
            gotoxy(65, 7); write('³');
            gotoxy(32, 7); readln(DataRawat.Kode);
            DataRawat := CariDataRawat(DataRawat.Kode);
         end; { EndWhile }
      DataPasien := CariDataPasien(DataRawat.Pasien);
      gotoxy(32, 8); write(DataPasien.Nama);
      gotoxy(32, 9); write(DataPasien.Usia);
      gotoxy(32, 10); write(DataPasien.JK);
      DataKamar := CariDataKamar(DataRawat.Kamar);
      gotoxy(32, 11); write(DataKamar.Kelas);
      gotoxy(32, 12); write('Rp. ', DataKamar.Harga);
      gotoxy(32, 13); write(DataRawat.TglMasuk);
      gotoxy(37, 13); write(DataRawat.BlnMasuk);
      gotoxy(42, 13); write(DataRawat.ThnMasuk);
      gotoxy(32, 14); readln(DataRawat.TglKeluar);
      gotoxy(37, 14); readln(DataRawat.BlnKeluar);
      gotoxy(42, 14); readln(DataRawat.ThnKeluar);
      gotoxy(36, 15); readln(DataRawat.BiayaTambahan);

      { Konversi Hari }
      JmlHariMasuk := DataRawat.TglMasuk + (DataRawat.BlnMasuk * 30) + (DataRawat.ThnMasuk * 365);
      JmlHariKeluar := DataRawat.TglKeluar + (DataRawat.BlnKeluar * 30) + (DataRawat.ThnKeluar * 365);

      { Perhitungan Biaya }
      JumlahBiaya := ((JmlHariKeluar - JmlHariMasuk) * DataKamar.Harga) + DataRawat.BiayaTambahan;
      DataRawat.Total := JumlahBiaya;
      gotoxy(32, 17); write('Rp. ', JumlahBiaya);
      assign(File_Rawat, 'rawat.dat');
      reset(File_Rawat);
      seek(File_Rawat, IndeksFile - 1);
      write(File_Rawat, DataRawat);
      close(File_Rawat);
      readln;
   end; { EndProcedure }

procedure Menu1(Pilihan : integer);
{I.S. : User memasukkan pilihan menu }
{F.S. : Menampilkan menu yang dipilih }
   begin
      clrscr;
      gotoxy(18, 6); write('ÚÄ MENU ISI DATA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(18, 7); write('³ 1. Isi Data Pasien                         ³');
      gotoxy(18, 8); write('³ 2. Isi Data Kamar                          ³');
      gotoxy(18, 9); write('³ 3. Isi Data Rawat                          ³');
      gotoxy(18, 10); write('³ 0. Keluar                                  ³');
      gotoxy(18, 11); write('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(18, 12); write('³ Pilihan :                                  ³');
      gotoxy(18, 13); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      { Keterangan }
      gotoxy(1, 21); write('ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(1, 22); write('³ Keterangan :                                  ³');
      gotoxy(1, 23); write('³ Menggunakan menu ini kemungkinan akan         ³');
      gotoxy(1, 24); write('³ me-reset data yang sudah ada!!                ³');
      gotoxy(1, 25); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(30, 12); readln(Pilihan);
      while(Pilihan < 0) or (Pilihan > 3) do
         begin
            gotoxy(19, 14); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(19, 15); write('³  ');
            textcolor(yellow); write('Pilihan hanya 0-3, Ulangi tekan enter!');
            textcolor(white); write('  ³');
            gotoxy(19, 16); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(30, 12); clreol;
            gotoxy(63, 12); write('³');
            gotoxy(19, 14); clreol;
            gotoxy(19, 15); clreol;
            gotoxy(19, 16); clreol;
            gotoxy(30, 12); readln(Pilihan);
         end;
      case Pilihan of
         1 : begin
                isiPasien(File_Pasien);
             end;
         2 : begin
                isiKamar(File_Kamar);
             end;
         3 : begin
                isiDataRawat(File_Rawat);
             end;
      end; { EndDepend }
   end; { EndProcedure }

procedure Menu2(Pilihan : integer);
{I.S. : User memasukkan pilihan menu }
{F.S. : Menampilkan menu yang dipilih }
   begin
      clrscr;
      gotoxy(18, 6); write('ÚÄ MENU TAMBAH DATA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(18, 7); write('³ 1. Tambah Data Pasien                      ³');
      gotoxy(18, 8); write('³ 2. Tambah Data Kamar                       ³');
      gotoxy(18, 9); write('³ 3. Tambah Data Rawat                       ³');
      gotoxy(18, 10); write('³ 0. Keluar                                  ³');
      gotoxy(18, 11); write('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(18, 12); write('³ Pilihan :                                  ³');
      gotoxy(18, 13); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(30, 12); readln(Pilihan);
      while(Pilihan < 0) or (Pilihan > 3) do
         begin
            gotoxy(19, 14); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(19, 15); write('³  ');
            textcolor(yellow); write('Pilihan hanya 0-3, Ulangi tekan enter!');
            textcolor(white); write('  ³');
            gotoxy(19, 16); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(30, 12); clreol;
            gotoxy(63, 12); write('³');
            gotoxy(19, 14); clreol;
            gotoxy(19, 15); clreol;
            gotoxy(19, 16); clreol;
            gotoxy(30, 12); readln(Pilihan);
         end; { EndWhile }
       case Pilihan of
         1 : begin
                tambahPasien(File_Pasien);
             end;
         2 : begin
                tambahKamar(File_Kamar);
             end;
         3 : begin
                tambahDataRawat(File_Rawat);
             end;
      end; { EndDepend }
   end; { EndProcedure }

procedure Menu3(Pilihan : integer);
{I.S. : User memasukkan pilihan menu }
{F.S. : Menampilkan menu yang dipilih }
   begin
      clrscr;
      gotoxy(18, 6); write('ÚÄ MENU LIHAT DATA ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
      gotoxy(18, 7); write('³ 1. Lihat Data Pasien                       ³');
      gotoxy(18, 8); write('³ 2. Lihat Data Kamar                        ³');
      gotoxy(18, 9); write('³ 3. Lihat Data Rawat                        ³');
      gotoxy(18, 10); write('³ 0. Kembali                                 ³');
      gotoxy(18, 11); write('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
      gotoxy(18, 12); write('³ Pilihan :                                  ³');
      gotoxy(18, 13); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
      gotoxy(30, 12); readln(Pilihan);
      while(Pilihan < 0) or (Pilihan > 3) do
         begin
            gotoxy(19, 14); write('ÚÄ ');
            textcolor(red); write('ERROR');
            textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(19, 15); write('³  ');
            textcolor(yellow); write('Pilihan hanya 0-3, Ulangi tekan enter!');
            textcolor(white); write('  ³');
            gotoxy(19, 16); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            readln;
            gotoxy(30, 12); clreol;
            gotoxy(63, 12); write('³');
            gotoxy(19, 14); clreol;
            gotoxy(19, 15); clreol;
            gotoxy(19, 16); clreol;
            gotoxy(30, 12); readln(Pilihan);
         end; { EndWhile }
       case Pilihan of
         1 : begin
                BacaDataPasien(Pasien, Total_Pasien);
                UrutNama(Pasien, Total_Pasien);
                LihatDataPasien(Pasien, Total_Pasien);
                readln;
             end;
         2 : begin
                BacaDataKamar(Kamar, Total_Kamar);
                UrutHarga(Kamar, Total_Kamar);
                LihatDataKamar(Kamar, Total_Kamar);
                readln;
             end;
         3 : begin
                BacaDataRawat(Rawat, Total_Rawat);
                UrutKodeRawat(Rawat, Total_Rawat);
                LihatDataRawat(Rawat, Total_Rawat);
                readln;
             end;
      end; { EndDepend }
   end; { EndProcedure }

{ Procedure Menu }
procedure Menu(Pilihan : integer);
{I.S. : User memasukkan pilihan menu }
{F.S. : Menampilkan menu yang dipilih }
   begin
      repeat
         clrscr;
         gotoxy(18, 6); write('ÚÄ MENU ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
         gotoxy(18, 7); write('³ 1. Isi Data (Awal)                         ³');
         gotoxy(18, 8); write('³ 2. Tambah Data                             ³');
         gotoxy(18, 9); write('³ 3. Lihat Data Terurut                      ³');
         gotoxy(18, 10); write('³ 4. Cari Pasien Berdasarkan Kode            ³');
         gotoxy(18, 11); write('³ 5. Cari Pasien Berdasarkan Nama            ³');
         gotoxy(18, 12); write('³ 6. Cari Kisaran Harga Kamar                ³');
         gotoxy(18, 13); write('³ 7. Cari Data Rawat Inap Berdasarkan Kode   ³');
         gotoxy(18, 14); write('³ 8. Pembayaran                              ³');
         gotoxy(18, 15); write('³ 0. Keluar                                  ³');
         gotoxy(18, 16); write('ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´');
         gotoxy(18, 17); write('³ Pilihan :                                  ³');
         gotoxy(18, 18); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
         gotoxy(30, 17); readln(Pilihan);
         while(Pilihan < 0) or (Pilihan > 8) do
            begin
               gotoxy(19, 19); write('ÚÄ ');
               textcolor(red); write('ERROR');
               textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
               gotoxy(19, 20); write('³  ');
               textcolor(yellow); write('Pilihan hanya 0-8, Ulangi tekan enter!');
               textcolor(white); write('  ³');
               gotoxy(19, 21); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
               readln;
               gotoxy(30, 17); clreol;
               gotoxy(63, 17); write('³');
               gotoxy(19, 19); clreol;
               gotoxy(19, 20); clreol;
               gotoxy(19, 21); clreol;
               gotoxy(30, 17); readln(Pilihan);
            end;
         case Pilihan of
            1 : begin
                   Menu1(Pilihan);
                end;
            2 : begin
                   Menu2(Pilihan);
                end;
            3 : begin
                   Menu3(Pilihan);
                end;
            4 : begin
                   CariKodePasien(Pasien);
                end;
            5 : begin
                   CariNama(Pasien);
                end;
            6 : begin
                   CariHarga(Kamar);
                end;
            7 : begin
                   CariKodeRawatInap(Rawat);
                end;
            8 : begin
                   Pembayaran(File_Rawat);
                end;
         end; { EndDepend }
      until(Pilihan = 0);
   end; { EndProcedure }

{ Procedure Login }
procedure Login(username, password : string);
{I.S. : }
{F.S. : }
   var
      salah : integer;
      berhasil : boolean;
      inputusername, inputpassword : string;

   begin
      clrscr;
      salah := 0;
      berhasil := false;
      while(not berhasil) and (salah < 3) do
         begin
            gotoxy(28, 10); write('ÚÄ LOGIN ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
            gotoxy(28, 11); write('³ Username :           ³');
            gotoxy(28, 12); write('³ Password :           ³');
            gotoxy(28, 13); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
            gotoxy(41, 11); readln(inputusername);
            gotoxy(41, 12); readln(inputpassword);
            if(inputusername = username) and (inputpassword = username) then
               berhasil := true
            else
               begin
                  salah := salah + 1;
                  gotoxy(22, 14); write('ÚÄ ');
                  textcolor(red); write('ERROR');
                  textcolor(white); write(' ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿');
                  gotoxy(22, 15); write('³  ');
                  textcolor(yellow); write('Username Atau Password Salah!');
                  textcolor(white); write('  ³');
                  gotoxy(22, 16); write('ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ');
                  readln;
                  gotoxy(22, 14); clreol;
                  gotoxy(22, 15); clreol;
                  gotoxy(22, 16); clreol;
               end; { EndIF }
         end; { EndWhile }
      if(berhasil) then
         Menu(Pilihan);
   end; { EndProcedure }

begin
   TextBackground(LightCyan);
   TextColor(White);
   username := 'admin';
   password := 'admin';
   Login(username, password);
   readln;
end.
