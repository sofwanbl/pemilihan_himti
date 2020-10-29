local frame
set talk off
set score off
use pemilih
setcolor("w/b","w/bg")
frame:=repl(chr(179),9)
@0,0,24,80 box frame
setcolor("b/w","bg/w")
dispbox(4,4,22,51)
dbedit(5,5,22,50)
return
