@echo off
ECHO XSPF TO M3U CONVERTER
ECHO CREATED BY Z.B.A
echo.
setlocal EnableDelayedExpansion
:beg
if exist "MYM3U.M3U" (
echo Overwrite existing MYM3U.M3U?
set /p ow=Enter y to continue or n to exit:
if /i "!ow:~,1!"=="y" (
del MYM3U.M3U
) else if /i "!ow:~,1!"=="n" (
exit
) else goto beg
)
ECHO WORKING......
ECHO #EXTM3U>>MYM3U.M3U 
set cnta=0
set cntb=0
set total=0
for /F "delims=" %%a in ('findstr /I /L "<location> <title> </tracklist>" *.xspf') do (
set "vra=%%a"
if not "!vra!"=="!vra:<location>=!" (
set /a cnta=!cnta!+1
set /a  buf=!cntb!+2
if !cnta! equ !buf! (
set /a cntb=!cntb!+1
set Var=!loc!
call :LoopLastToken !Var!
set tit=!Var!
set "grp=No Title"
call:m3uc
)
set "vra=!vra:*<location>=!"
for /F "delims=<" %%b in ("!vra!") do set loc=%%b
) else if not "!vra!"=="!vra:<title>=!" (
if !cnta! gtr !cntb! (
set "vra=!vra:*<title>=!"
for /F "delims=<" %%c in ("!vra!") do set tit=%%c
call:grpc
set /a cntb=!cntb!+1
) else (
for /F "delims=:" %%d in ("!vra!") do set fname=%%d
)
) else (
if  !cnta! gtr !cntb! (
set Var=!loc!
call :LoopLastToken !Var!
set tit=!Var!
set "grp=No Title"
call:m3uc
)
echo.
echo !fname! contained !cnta! titles
set /a total=!total!+!cnta!
set cnta=0
set cntb=0
)
if !cnta! equ !cntb! (if !cnta! gtr 0 (call:m3uc))
)
echo.
echo.
echo OPERATION COMPLETE
echo Total !total! TRACKS ADDED FROM ALL FILES
PAUSE
exit /b

:m3uc
if not "!tit!"=="!tit:-=!" (if not "!tit!"=="!tit: =!" (set "tit=!tit:-= !"))
echo #EXTINF:-1,!tit!>>MYM3U.M3U
echo #EXTGRP:!grp!>>MYM3U.M3U
echo !loc!>>MYM3U.M3U
exit /b

:grpc
if "!tit:~0,3!"=="***" (
set "grp=***"
) else if "!tit:~0,2!"=="**" (
set "grp=**"
) else if "!tit:~0,1!"=="*" (
set "grp=*"
) else if "!tit:~3,1!"=="-" (
set "grp=!tit:~0,3!"
) else if "!tit:~2,1!"=="-" (
set "grp=!tit:~0,2!"
) else (
set "grp=Z.B.A"
)
exit /b
:LoopLastToken
    set "Var=%~1"
    if not "%Var:*/=%"=="%~1" (
    call :LoopLastToken "%Var:*/=%")
exit /b