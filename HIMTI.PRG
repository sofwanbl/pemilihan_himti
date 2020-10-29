///////////////////////
//  Akhmad Sofwan    //
//   (9711500292)    //
// STMIK Budi Luhur  //
//       2000        //
//   PROGRAM UTAMA   //
///////////////////////

#include "inkey.ch"
local mnim,mnama,mnim1,mnama1,mlayar:=savescreen(),mwarna:=setcolor()
local ingat1,ingat2,ingat3,ingat4,ingat5,i,mjam,mtanggal,bil:=0,mpil:=0
public jumlah,frame,mno:=0,mnum:=0,mnum1:=space(3),mpersen:=0,jumti:=0

set talk off
set score off
set century on
set date to british
set mess to 24 center
set deli on
set deli to "[]"
set wrap on
set conf on

password()
setcolor()

///Tampilan
setcolor("b/w")
inkey(1)
siap()
logo()
set cursor on
tampilan()
setcolor("b/w")

@24,0 say space(80)
@24,55 say ""+tanggal()
clock(.t.,0,71,"1/7")
setcolor("n/bg")
@24,0 say  " F2->Start"
setcolor("b/w")

set key K_F2 to menu()

**********Aktifkan file DBF dan buat file indexnya
select 1
use master
if ! file("master.ntx")
   index on nim to master
else
   set index to master
endif

do while .not. eof()
  if substr(nim,3,2)=="11"
     jumti++
  endif
  skip
enddo

select 2
use pemilih
if !file ("pemilih.ntx")
   index on nim to pemilih
 else
   set index to pemilih
endif

select 3
use pemilih1
if !file ("pemilih1.ntx")
   index on tanggal to pemilih1
   index on jam to pemilih1
else
   set index to pemilih1
endif

select 2
jumlah:=lastrec()
mno:=jumlah
mpersen:=(jumlah/jumti)*100

do while .t.
  mjam:=0
  @9,30 clear to 12,56
  @14,19 clear to 14,57
  setcolor("b/w")

  @19,28 say "    Jumlah Pemilih :"
  @20,20 say ""+str(jumlah)+" Dari "+alltrim(str(jumti))+" mhs TI aktif"
  @21,28 say "Prosentase pemilih : "+alltrim(str(mpersen))+" %"

  select 1
  set cursor on
  mnim:=space(len(field->nim))
  mnama:=space(len(field->nama))
   @9,30 get mnim pict "9999999999" valid !empty(mnim) .and. len(alltrim(mnim))==10
  read

  if lastkey()==27
     loop
  endif

***************Cek ,apakah ada di master atau tidak**************************
 select 1
 seek mnim
 if found()
    //Cek apakah TI atau tidak
      if substr(mnim,3,2)<>'11'
         tone(850,2)
         ingat5:=alert("Bukan jurusan TI !!",{"OK"})
         if ingat5==1
            loop
         endif
      endif
  //Cek apakah sudah nyoblos atau belum
    select 2
    seek mnim
   if ! found()
       select 1
       mnama:=nama
       mjam:=time()
       mtanggal:=date()
       @10,30 say mnama
       @11,30 say mtanggal
       @12,30 say mjam
   else
       tone(870,1)
       ingat4:=alert("Pemilih Sudah Mencoblos !",{"OK"})
       if ingat4==1
          loop
       endif
   endif
 else
   tone(800,1)
   ingat1:=alert("NIM tidak ada di master !",{"OK"})
   if ingat1==1
      loop
   endif
 endif

  @14,19 say "NIM sudah benar ?"
  @14,40 prompt "YA"
  @14,43 prompt "Ulang"
   menu to mpil
     if mpil==2
        loop
     else
        select 2
        jumlah:=jumlah+1
        mno++
        mpersen:=(jumlah/jumti)*100
    endif

  select 2
  append blank
  replace no with mno
  replace nim with mnim
  replace nama with mnama
  replace tanggal with mtanggal
  replace jam with mjam
  commit

  select 3
  append blank
  replace no with mno
  replace nim with mnim
  replace nama with mnama
  replace tanggal with mtanggal
  replace jam with mjam
  commit
enddo

clock(.f.,0,71,"n/70")

set color to n/n
for i=1 to 23
  scroll(0,0,25,79,1)
  inkey(0.1)
next

restscreen(,,,,mlayar)
setcolor(mwarna)
tengah(0,'Thanks for using this program. (c) Akhmad Sofwan - LITBANG HIMTI Des 2000',"14+/1")
return

***************************procedure tampilan*********************************
proc tampilan
 local layar:=savescreen()
 setcolor("b/w")
 boxopen(1,17,4,62,"w")
 @2,20 say "PEMILIHAN KETUA HIMTI PERIODE 2000/2001"
 @3,27 say "STMIK BUDI LUHUR JAKARTA"

 setcolor("b/w,b/g,,,b/w")
 do sbox with 8,18,15,60
 boxopen(18,18,22,60,"w")
 @9,20 say  "NIM     :"
 @10,20 say "NAMA    :"
 @11,20 say "TANGGAL :"
 @12,20 say "JAM     :"
 restscreen(,,,layar)
return

***************************procedure logo*************************************
proc logo
 local warna:=setcolor(),layar:=savescreen()
 local mlogo[19],mlogoa[19],mlogob[19]
 local i,j

 setcolor("w/b")
 frame:=repl(chr(178),9)
 @0,0,23,79 box frame

 set cursor off
// do sbox with 7,2,18,78,"gr+*/b"
 do kotak3d with 7,2,18,78,0
 setcolor("gr+/w")
 **
 **            012345678901234567890123456789012345678901
 **            1         2         3         4         5
 mlogo[1] := " --    --  --  ----     ---- ----------  -- "
 mlogo[2] := " --    --  --  -- --   -- -- ----------  -- "
 mlogo[3] := " --    --  --  --  -- --  --     --      -- "
 mlogo[4] := " --------  --  --   --    --     --      -- "
 mlogo[5] := " --------  --  --   --    --     --      -- "
 mlogo[6] := " --    --  --  --         --     --      -- "
 mlogo[7] := " --    --  --  --         --     --      -- "
 mlogo[8] := " --    --  --  --         --     --      -- "
 mlogo[9] := " ------------------------------------------ "

 for i=1 to 50
    for j=2 to 9 step 2
        mlogoa[j]:=right(mlogo[j],i)+space(49-i)
        mlogob[j+1]:=space(49-i)+left(mlogo[j],i)
        @ 8+j,17 say mlogoa[j]
        @ 9+j,17 say mlogob[j+1]
    next j
    if .not. lastkey()=K_F10
       inkey(0.1)
    endif
 next i
setcolor("w/b")
for k=1 to 40
  @7,2,19,k box frame
  @7,79,19,79-k box frame
  inkey(0.05)
next
tone(1500,2)
tone(980,1)
set cursor on
tampilan()
restscreen(layar)
setcolor(warna)
return

*************************PROCEDURE BANTU*************************************
proc bantu
 local mlayar1:=savescreen(),mcolor1:=setcolor(),frame
 setcolor("b/w")
 frame:=repl(chr(178),9)
 @0,0,24,80 box frame
 setcursor(0)
 for i=1 to 5
   tone(600,0.001)
   boxopen(12-i,14-i,15+i,64+i,"w")
 next
// boxopen(5,4,22,74,"w")
 @8,10  say  "                         BANTUAN                        "
 @10,10 say  " - Tekan F2 untuk melihat menu."
 @11,10 say  " - Untuk menghapus seluruh data (ada password),setelah"
 @12,10 say  "   muncul entrian password,perlu di tekan ESC."
 @13,10 say  " - Matikan Screen Saver Windows,karena program ini telah"
 @14,10 say  "   ada Screen Saver sendiri, gunakan jika perlu."
 @15,10 say  " - Nomor pada 'database berdasarkan nim' adalah nomor urut"
 @16,10 say  "   'Database berdasarkan waktu.'"
 @17,10 say  " - Pencetakan daftar pemilih,berdasarkan urut waktu."
 inkey(0)
 setcursor(1)
 restscreen(,,,,mlayar1)
 setcolor(mcolor1)
return

*****************************PROCEDURE KETERANGAN******************************
proc ket
 local mlayar:=savescreen(),mwarna:=setcolor()
 cSiap:=z_explode(5,11,23,65,'s','n/w','n/w','d',.t.)
 set talk off
 setcursor(0)
   @6,16 say "                Tentang Program                "
   @7,16 say "          Program Pemungutan suara TI          "
   @8,16 say "                   versi 1.1                   "
   @9,16 say "            Di Kembangkan untuk  :             "
   @10,16 say " Himpunan Mahasiswa Teknik Informatika (HIMTI)"
   @11,16 say "              STMIK Budi Luhur                "
   @12,16 say "  Oleh : Bidang Penelitian dan Pengembangan   "
   @13,16 say "                  HIMTI BL                    "
   @15,16 say " Terima kasih kepada :                        "
   @16,16 say " - Yusuf Awaludin (LPK Dunia Informatika)     "
   @17,16 say " - Orang rumah tercinta                       "
   @18,16 say " Compiler  : CA.Clipper 5.20                  "
   do kotak3d with 20,35,22,40,0
 @21,37 say "OK"
do while .t.
  inkey(0)
  if lastkey()<>K_ENTER
    loop
  else
     do kotak3d with 20,35,22,40,1
     setcolor("n/w")
     @21,37 say "OK"
     inkey(0.1)
     z_implode(5,11,23,65,'s','n/w','n/w','d',.t.,cSiap)
     setcursor(1)
     exit
   endif
enddo
restscreen(,,,,mlayar)
setcolor(mwarna)
return

***************************PROCEDURE LIHAT DATABASE****************************
 proc lihat
 local mlayar1:=savescreen(),mcolor1:=setcolor(),mpil,frame1
 set key K_F2 to
 setcolor("")
 setcolor("w/b")
 frame1:=repl(chr(178),9)
 @0,0,24,80 box frame
 setcolor("b/w,b/bg")
 boxopen(9,26,12,50,"w")
 @10,30 say "URUT BERDASARKAN:"
 @11,32 prompt "Waktu"
 @11,40 prompt "NIM"
 menu to mpil
 if mpil=1
   select 3
   tengah (2,"DATABASE PEMILIH ,URUT BERDASARKAN WAKTU","gr/w")
   do while .t.
      do sbox with 4,4,22,76,"b/w"
      dbgotop()
      dbedit(5,5,21,75)
    if lastkey()=K_ESC
       exit
    endif
   enddo
 else
   select 2
   tengah (2,"DATABASE PEMILIH ,URUT BERDASARKAN NIM","gr/w")
   do while .t.
     do sbox with 4,4,22,76,"b/w"
     dbgotop()
     dbedit(5,5,21,75)
     if lastkey()=K_ESC
        exit
     endif
   enddo
 endif
 restscreen(,,,,mlayar1)
 setcolor(mcolor1)
 set key K_F2 to menu()
 return

 **************************PROCEDURE MENCETAK DATABASE**************************
proc cetak
  local mlayar2:=savescreen(),mcolor2:=setcolor()
  local hal:=nomor:=0,baris
  local mjudul:="DAFTAR PEMILIH PEMILIHAN KETUA HIMTI PERIODE 2000/2001"
  local mjudul1:="STMIK BUDI LUHUR",garis:=repl("-",78)

  select 3

if isprinter()==.f.
    do sbox with 10,20,15,65,"w+/b*"
    setcursor(0)
    @11,35say "PRINTER ERROR!"
    setcolor("w/b")
    @12,30 say "Printer nya betulin dulu. "
    @13,30 say "ESC untuk kembaliin         "
    @14,30 say "ENTER untuk melanjutkan   "

do while ! (isprinter() .and. lastkey()=K_ENTER)
   tone(700,1)
   tone(500,2)
   x:=inkey(2)
   if x=K_ESC
      set device to screen
      restscreen(,,,,mlayar2)
      setcolor(mcolor2)
      setcursor(1)
      return
   endif
enddo
restscreen(,,,,mlayar2)
setcolor(mcolor2)
setcursor(1)
endif

set printer to
set device to print

@1,39-len(mjudul)/2 say mjudul
@2,39-len(mjudul1)/2 say mjudul1

go top
do while .not. eof()
  hal++
  @4,70 say "Hal :"+tran(hal,"999")
  @prow()+1,1 say garis
  @prow()+1,2 say "NO. "
  @prow(),15  say "NIM "
  @prow(),28  say "NAMA"
  @prow(),55  say "Tanggal"
  @prow(),70  say "Waktu"
  @prow()+1,1 say garis

  baris:=8
  do while .not. eof() .and. baris<=53
    nomor++
    @baris,1  say no pict "999"
    @baris,10 say nim pict "9999999999"
    @baris,22 say nama pict "@!"
    @baris,53 say tanggal
    @baris,68 say jam
    baris++
    skip
  enddo
  @baris,0 say garis
  eject
enddo
set device to screen
setcursor(1)
restscreen(,,,,mlayar2)
setcolor(mcolor2)
return

************************PROCEDURE PASSWORD MASUK******************************
proc password
 local passwd,hitung:=0
 clear
 setcolor("b/w")
 @10,22 clear to 15,57
 @10,22 to 15,57 double
 @11,23 say "Password :"

 do while .t.
   passwd:=space(10)
   setcolor("w/w,w/w,,,w/w")
   set cursor on
   @11,33 get passwd pict "@!"
   @11,33 clear to 11,56
   read
   setcolor("b")
   if left(passwd,10)=="MANCHESTER" .and. len(alltrim(passwd))==10
      clear
      return
   else
      tone(1000,1)
      ingat:=alert("Incorrect Password !!")
      hitung++
      if hitung=4
        setcolor("b/w*")
        @18,23 say "The Intruder is trying to enter !!"
         break
      else
        loop
      endif
   endif
 enddo
return

*****************PROCEDURE MENGHAPUS SEMUA ISI DATABASE***********************
proc hapus
local passwd1:=space(15),hitung:=0,mlayar:=savescreen(),mcolor:=setcolor()
set key K_F2 to
setcursor(0)
setcolor("b/w")
@20,22 clear to 24,57
@20,22 to 24,57 double
@21,23 say "Password :"

do while .t.
  setcolor("w/w,w/w,,,w/w")
  passwd1:=space(15)
  @21,33 get passwd1 pict "@!"
  read
  setcolor("b")
  if left(passwd1,15)="TRAFFORD"
     restscreen(,,,,mlayar)
     setcolor(mcolor)
     tone(1200,2)
     ingat1:=alert("Yakin ingin di hapus SEMUA ??",{"OK","BATAL"})
     if ingat1=1
        tone(900,1)
        ingat2:=alert("Anda akan kehilangan data !!",{"OK","BATAL"})
        if ingat2==1
           select 3
           zap
           mno:=0
           mpersen:=0.00
           select 2
           zap
           jumlah:=0
           @19,28 clear to 21,60
           @19,28 say "    Jumlah Pemilih :"
           @20,20 say ""+str(jumlah)+" Dari "+alltrim(str(jumti))+" mhs TI aktif"
           @21,28 say "Prosentase pemilih : "+alltrim(str(mpersen))+" %"
           setcursor(1)
           return
        else
           setcursor(1)
           return
       endif
     else
       setcursor(1)
       return
   endif
  else
     tone(1000,1)
     ingat:=alert("Incorrect Password !!")
     hitung++
     if hitung=4
        setcursor(1)
        restscreen(,,,,mlayar)
        setcolor(mcolor)
        return
     else
       loop
     endif
  endif
enddo
restscreen(,,,,mlayar)
setcolor(mcolor)
set key K_F2 to menu()
return 

**************************FUNGSI TANGGAL***************************************
func tanggal()
hari:={"minggu","senin","selasa","rabu","kamis","jum'at","sabtu"}
bulan:={"Februari","Maret","April","Mei","Juni","Juli","Juli","Agustus","September","Oktober","Nopember","Desember","Januari"}
tanggalan:=hari[dow(date())]+","+str(day(date()))+" "+bulan[month((date()))]+""+str(year(date()))
return tanggalan

function tengah
 parameters baris,teks,warna
 setcolor(warna)
 @baris,40-(len(teks)/2) say teks
return .t.

***************************procedure siap************************************
proc siap
cSiap:=z_explode(11,20,17,60,'s','0/7','2/7','d',.t.)
do kotak3d with 11,20,17,60,0

tengah(13,'Preparing Program...',"0/7")
set color to B/n
@14,22 say repl(chr(176),37)
setcolor('0/7')
@15,22 say "0%"
for i=22 to 39
        setcolor("9/0")
	@14,i say '²'
	tone(400,.1)
next i
setcolor("0/7")
@15,39 say "50%"
for i=39 to 58
        setcolor("9/0")
	@14,i say '²'
	tone(400,.1)
next i
setcolor("0/7")
@15,55 say "100%"
tone(600,.1);tone(700,.1);tone(800,.1)
tengah(16,'This Program is ready to use',"14/7")
t:=1
do while t<25000
t=t+1
enddo
z_implode(11,20,17,60,'s','0/7','2/7','d',.t.,cSiap)
return

*****************************Screen Saver**************************************

proc snake
// "Snake" - A screen Saver for Clipper V5.
//
// This is approximetely the same snake that we can see on a Netware 386
// console file server, I think for such kind of network, users are used
// to see the "Snake" on the file server, so it's a good idea to get the
// same thing on each user screen.
// You've only to modify getsys for calling snake after x seconds and
// to modify also prompt and menu design system (I'll give you all that
// stuff if you need it...)
//
//      Patrick Imbault
//      6 Rue de l'Ecluse
//      77000 MELUN
//      FRANCE
//      CIS:100012,1450
//
//  call SNAKE() to use it, it returns always .T.
//  compile CLIPPER snake /N /W
//
//

#Define SPEED   .1
#Define LMAX   15
#Define FRAC(x)  (x-INT(x))
#Define S_SNAKE(x) (SUBSTR(CHR(176)+CHR(177)+CHR(178)+CHR(219),x,1))
#Define SIGN(x) IIF(x>0,1,IIF(x<0,-1,0))

STATIC seed

SET COLOR TO b/n
lRet:=snakeR()
Set color to b/n
set cursor on
set color to b/w
Return

FUNC SNAKER()
    LOCAL i,nXd:=0,nYd:=0,nLon,nDiff,nAvis,nForm,nLon2,nP,nP2
    LOCAL cSc,nrow:=row(),ncol:=col(),anc_cu
    seed:=FRAC(seconds()/1000)
    nP:=ARRAY(LMAX,2)
    nP[1,1]:=40
    nP[1,2]:=12
    nAvis:=MAX(5,alea(LMAX))
    nForm:=MAX(5,alea(LMAX))
    cDir(@nXd,@nYd)
    nLon:=MAX(4,alea(10))
    nLon2:=nLon
	

    FOR i:=2 TO nLon
      nP[i,1]:=nP[1,1]
      nP[i,2]:=nP[1,2]-(i-1)
    NEXT i

    cSc:=savescreen(0,0,maxrow(),maxcol())
    CLEAR SCREEN
    anc_cu:=setcursor(0)
    sdisp(nP,nLon)
    DO WHILE inkey(SPEED)==0

	setcolor("1/n")
	@11,28 to 13,58 double
	setcolor("14/n")
	@12,30 say 'Uler-uleran screen saver...'
	setcolor("3/0")

      if nAvis--<0
         nAvis:=MAX(5,alea(LMAX))
         cdir(@nXd,@nYd)
      endif

      if nForm--<0
         nForm:=MAX(5,alea(LMAX))
         nLon2:=MAX(4,alea(10))
      ENDIF
      sundisp(nP,nLon)
      nDiff:=nLon2-nLon
      cPos(@nP,@nXd,@nYd,nLon,nDiff>0)
      nLon+=SIGN(nDiff)
      sdisp(nP,nLon)
    ENDDO
    restscreen(0,0,maxrow(),maxcol(),cSc)
    setcursor(anc_cu)
    setpos(nrow,ncol)
RETURN .T.

FUNCTION sundisp(nP,nLon)
    LOCAL j

    FOR j:=1 TO nLon
      @ nP[j,2],nP[j,1] say "  "
    NEXT j

RETURN NIL

FUNCTION sdisp(nP,nLon)
    LOCAL i:=1,j

    FOR j:=nLon TO 1 STEP -1
      @ nP[j,2],nP[j,1] say REPLICATE(S_SNAKE(INT(i)),2)
      i+=(4/nLon)
    NEXT j

RETURN NIL


FUNCTION cpos(nPa,nXd,nYd,nLon,inc)
    LOCAL i,x,y
    x:=nPa[1,1]+nXd
    y:=nPa[1,2]+nYd
    DO WHILE x<0 .OR. x> MAXCOL() .OR. y<0 .OR. y>MAXROW()
      cdir(@nXd,@nYd)
      x:=nPa[1,1]+nXd
      y:=nPa[1,2]+nYd
    ENDDO
    FOR i:=nLon+IIF(inc<>NIL .AND. inc,1,0) TO 2 STEP -1
       nPa[i,1]:=nPa[i-1,1]
       nPa[i,2]:=nPa[i-1,2]
    NEXT i
    nPa[1,1]:=x
    nPa[1,2]:=y
RETURN NIL

FUNCTION cdir(x,y)
    x:=alea(3)-1
    y:=alea(3)-1
    DO WHILE x=0 .AND. y=0
      x:=alea(3)-1
      y:=alea(3)-1
    ENDDO
RETURN NIL

FUNCTION alea(nX)
    seed:=FRAC(seed*9821+.211327)
RETURN INT(seed*nX)
Set color to b/w
//@1,64 say "Jam : "
set cursor on
//clock(.t.,1,70,"n/7")

****************************** PROCEDURE MENU ********************************
proc menu
 local mscreen:=savescreen(),mcolor:=setcolor(),mpil
 boxopen(14,1,23,17,"w")
 @21,2 to 21,16
 @15,2 prompt "bantu" mess "Tampilkan layar bantu"
 @16,2 prompt "Ket Program" mess "Keterangan program"
 @17,2 prompt "Lihat Pemilih" mess "Melihat daftar pemilih"
 @18,2 prompt "Cetak Data" mess "Mencetak Data pemilih "
 @19,2 prompt "Hapus Data" mess "Menghapus seluruh Data"
 @20,2 prompt "Screen Saver" mess "Menampilkan Screen Saver"
 @22,2 prompt "Keluar" mess "Keluar dari Program"
 menu to mpil
   do case
      case mpil=1
           bantu()
      case mpil=2
           restscreen(,,,,mscreen)
           setcolor(mcolor)
           ket()
      case mpil=3
           lihat()
      case mpil=4
           restscreen(,,,,mscreen)
           setcolor(mcolor)
           cetak()
      case mpil=5
           restscreen(,,,,mscreen)
           setcolor(mcolor)
           hapus()
           set key K_F2 to menu()
      case mpil=6
           snake()
      case mpil=7
           restscreen(,,,,mscreen)
           setcolor(mcolor)
           exit()
 endcase
 restscreen(,,,,mscreen)
 setcolor(mcolor)
return

*************************** PROCEDURE EXIT ********************************
Procedure exit
 local MScreen, Mcolor
 save screen to MScreen
 MColor:=setcolor()
 tone(800,.1);tone(800,1)
 cExit:=z_explode(12,30,15,49,'d','14/7','1/7','ds',.t.)
 kotak3d(12,30,15,49,1)
 do while .t.
     tengah(13,'Keluar ?',"14/7,14/1")
     @14,33 prompt ' Ya '
     @14,40 prompt ' Tidak '
     menu to yesno
     do case
		case yesno=0
                        exit
		case yesno=1
                        clock(.f.,1,70,"n/7")
                        setcolor("7/n")
			for i:=0 to 23
	   			scroll(0,0,24,79,1)
	   			inkey(.01)
            next i
			setcolor("1/1")
                        @0,0 say repl(chr(219),80)
                        tengah(0,'Thanks for using this program. (c) Akhmad Sofwan - LITBANG HIMTI Des 2000',"14+/1")
			setcolor("7/n")
			@21,0
			quit
		case yesno=2
                        exit

	endcase
enddo
z_implode(12,30,15,49,'s','14/7','1/10','ds',.t.,cExit)

rest screen from MScreen
setcolor(Mcolor)
return
*---- End of procedure exit




































