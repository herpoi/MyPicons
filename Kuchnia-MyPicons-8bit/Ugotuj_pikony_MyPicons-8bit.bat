@echo off
setlocal enabledelayedexpansion
chcp 1250 1> nul

:: �cie�ka do ImageMagick
set MAGICK_PATH="c:\Program Files\ImageMagick-6.8.9-Q16"

:: Utw�rz katalogi
mkdir MyPicons-transparent-8bit 2> nul

echo ===================================
echo \\\ Gotuj� pikony prze�roczyste ///
echo ===================================

:: Przytnij, zmie� rozmiar i konwertuj do PNG
for %%i in (do_ugotowania\*.*) do (
	echo Gotuj� "%%~ni"...
	:: Dodaj prze�roczyst� ramk� na wypadek gdyby logo by�o by�o prostokatne i wype�ni�o ca�� powierzchni� robocz�...
	%MAGICK_PATH%\convert "%%i" -bordercolor none -compose Copy -border 10 "MyPicons-transparent-8bit\%%~ni.png"
	:: ...a teraz przytnij i zmie� rozmiar
	%MAGICK_PATH%\convert -background none "MyPicons-transparent-8bit\%%~ni.png" -trim +repage -resize 200x120^> -gravity center -extent 220x132 "MyPicons-transparent-8bit\%%~ni.png"
)
:: Optymalizacja pngquant
for %%i in (MyPicons-transparent-8bit\*.png) do ("tools\pngquant2.exe" --force --ext .png 256 "%%i")

echo.
echo ========================
echo \\\ Pikony ugotowane ///
echo ========================

:: Zatrzymaj konsol�
pause