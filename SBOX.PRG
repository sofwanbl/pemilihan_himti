parameters t,l,b,r,clr
local v,h,i
v=savescreen(t+1,r+1,b+1,r+2)
h=savescreen(b+1,l+2,b+1,r+2)
for i=2 to len(h) step 2
    h=stuff(h,i,1,chr(7))
next
for i=2 to len(v) step 2
    v=stuff(v,i,1,chr(7))
next
set color to(Clr)
@t,l clear to b,r
@t,l to b,r
restscreen(t+1,r+1,b+1,r+2,v)
restscreen(b+1,l+2,b+1,r+2,h)
return
