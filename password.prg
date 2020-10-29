
************************PROCEDURE PASSWORD MASUK******************************
 #include "inkey.ch"
 local passwd,hitung:=0
 set talk off
 set score off
 clear
 setcolor("b/w")
 @10,22 clear to 15,57
 @10,22 to 15,57 double
 @11,23 say "Password :"
 do while .t.
   passwd:=space(10)
   setcolor("w/w,w/w,,,w/w")
   set cursor on
   if lastkey()=K_CTRL_Q
      alert("CTRL A nih yee..",{"OK"})
   endif
   @11,33 get passwd pict "@!"
   @11,33 clear to 11,56
   read
   setcolor("b")
   if left(passwd,10)=="OPANNAMAKU" .and. len(alltrim(passwd))==10
      clear
      return
   else
      tone(1000,1)
      ingat:=alert("Incorrect Password !!")
      loop
    endif
 enddo
return

















