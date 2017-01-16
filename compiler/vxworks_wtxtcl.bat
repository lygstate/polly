@echo off
set "CMAKE_NM=%~1"
set "TARGET=%~2"
set "CMAKE_WTXTCL_VXWORKS=%~3"
set "CMAKE_WTXTCL_VXWORKS_MUNCH_TCL=%~4"
set "CMAKE_VXWORKS_ARCH_NAME=%~5"
"%CMAKE_NM%" -g %TARGET%.partialImage.o @%TARGET%.lst | "%CMAKE_WTXTCL_VXWORKS%" "%CMAKE_WTXTCL_VXWORKS_MUNCH_TCL%" -c %CMAKE_VXWORKS_ARCH_NAME% > %TARGET%.ctdt.c

::ccpentium -r -nostdlib -Wl,-X -Wl,@..\prjObjs.lst  -o partialImage.o 
::nmpentium -g partialImage.o @..\prjObjs.lst | wtxtcl C:\Tornado2.2\host\src\hutils\munch.tcl -c pentium > ctdt.c
::ccpentium -c -fdollars-in-identifiers -g -mcpu=pentium -march=pentium -nostdlib -fno-builtin -fno-defer-pop -I. -IC:\Tornado2.2\target\h\ -I..\include -I..\src\vxworks -DCPU=PENTIUM -DTOOL_FAMILY=gnu -DTOOL=gnu ctdt.c -o ctdt.o
::ccpentium -r -nostdlib -Wl,-X -T C:\Tornado2.2\target\h\tool\gnu\ldscripts\link.OUT partialImage.o ctdt.o -o ARINC653.out
