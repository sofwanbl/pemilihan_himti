para b1,k1,b2,k2,l
priv b,i,sw
 sw:=setcolor()
 b:='ÚÄ¿³ÙÄÀ³'
 if l=1
   setcolor("n/w")
 else
   setcolor("w+/w")
 endif
 @b1,k1,b2,k2 box b+chr(32)
 if l=1
   setcolor("w+/w")
 else
   setcolor("n/w")
 endif
 @b1,k2 say substr(b,3,1)
 for i := b1+1 to b2-1
  @i,k2 say substr(b,4,1)
 next i
 @b2,k2 say substr(b,5,1)
 for i = k1+1 to k2-1
  @b2,i say substr(b,6,1)
 next i
return


