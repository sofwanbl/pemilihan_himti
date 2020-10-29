//procedure snake
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

SET COLOR TO 3/0
lRet:=snakeR()
Set color to r+/w+
@1,64 say "Jam : "
clock(.t.,1,70,"n/7")
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
Set color to r+/w+
@1,64 say "Jam : "
clock(.t.,1,70,"n/7")

