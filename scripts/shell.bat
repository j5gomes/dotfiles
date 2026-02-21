:: This is everything that I need for my shell to do c code
@echo off
call "C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvarsall.bat" x64
set path=w:\handmade\misc;%path%

:: Alias vim -> neovide
doskey vim=neovide $*
