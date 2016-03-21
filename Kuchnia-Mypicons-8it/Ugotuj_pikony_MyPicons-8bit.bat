@echo off
setlocal enabledelayedexpansion
chcp 1250 1> nul

:: Œcie¿ka do ImageMagick
set MAGICK_PATH="c:\Program Files\ImageMagick-6.8.9-Q16"

:: Utwórz katalogi
mkdir MyPicons-transparent-8bit 2> nul

echo ===================================
echo \\\ Gotujê pikony przeŸroczyste ///
echo ===================================

:: Przytnij, zmieñ rozmiar i konwertuj do PNG
for %%i in (do_ugotowania\*.*) do (
	echo Gotujê "%%~ni"...
	:: Dodaj przeŸroczyst¹ ramkê na wypadek gdyby logo by³o by³o prostokatne i wype³ni³o ca³¹ powierzchniê robocz¹...
	convert "%%i" -bordercolor none -compose Copy -border 10 "MyPicons-transparent-8bit\%%~ni.png"
	:: ...a teraz przytnij
	convert -background none "MyPicons-transparent-8bit\%%~ni.png" -trim +repage "MyPicons-transparent-8bit\%%~ni.png"
	:: SprawdŸ rozmiar i dopasuj do 220x130px
	for /f %%x in ('identify -ping -format "%%w" "%%i"') do set S=%%x
	for /f %%y in ('identify -ping -format "%%h" "%%i"') do set W=%%y
	set RES=false
	if !S! gtr 220 if !W! gtr 132 set RES=true
	if "!RES!"=="true" %MAGICK_PATH%\convert -background none "MyPicons-transparent-8bit\%%~ni.png" -resize 220x132 -gravity center -extent 220x132 PNG32:"MyPicons-transparent-8bit\%%~ni.png"
	if "!RES!"=="false" %MAGICK_PATH%\convert -background none "MyPicons-transparent-8bit\%%~ni.png" -gravity center -extent 220x132 PNG32:"MyPicons-transparent-8bit\%%~ni.png"
)
:: Optymalizacja pngquant
for %%i in (MyPicons-transparent-8bit\*.png) do ("tools\pngquant2.exe" --force --ext .png 256 "%%i")

echo.
echo ========================
echo \\\ Pikony ugotowane ///
echo ========================

:: Zatrzymaj konsolê
pause