#include "inkey.ch"
local mlayar2:=savescreen(),mcolor2:=setcolor()
local hal:=no:=0,baris
local mjudul:="DAFTAR PEMILIH PEMILIHAN KETUA HIMTI PERIODE 1999/2000"
local mjudul1:="STMIK BUDI LUHUR",garis:=repl("-",78)

use pemilih index pemilih new
cekprint()

set printer to
set device to print

@1,39-len(mjudul)/2 say mjudul
@2,39-len(mjudul1)/2 say mjudul1

do while .not. eof()
  hal++
  @prow()+1,1 say garis
  @prow()+1,2 say "NO. "
  @prow(),5   say "NIM "
  @prow(),20  say "NAMA"
  @prow()+1,1 say garis

  baris:=6
  do while .not. eof() .and. baris<=50
    no++
    @baris,2 say no pict "999"
    @baris,5 say nim pict "9999999999"
    @baris,20 say nama pict "@!"
    baris++
    skip
  enddo
  @baris,0 say garis
  eject
enddo
restscreen(mlayar2)
setcolor(mcolor2)
set device to screen
return

func cekprint
local mscreen:=savescreen(),mcolor:=setcolor(),X
do sbox with 10,20,15,60,"w+/b*"
@11,35say "PRINTER ERROR!"
setcolor("w/b")
@12,30 say "Printer nya betulin dulu."
@13,30 say "   ESC untuk kembali     "
@14,30 say "ENTER untuk melanjutkan  "

do while ! (isprinter() .and. lastkey()=K_ENTER)
   tone(700,1)
   tone(500,2)
   x:=inkey(2)
   if x=K_ESC
      break
   endif
enddo

restscreen(,,,,mscreen)
setcolor(mcolor)
return
