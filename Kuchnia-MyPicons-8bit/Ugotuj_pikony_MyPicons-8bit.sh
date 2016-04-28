#!/bin/sh

mkdir MyPicons-transparent-8bit
mkdir temp
cd do_ugotowania

echo "==================================="
echo "/// Gotuję pikony przeźroczyste ///"
echo "==================================="

# Przytnij, zmień rozmiar i konwertuj do PNG
for f in ./*
do	
	echo Przygotowuję $f
	convert `echo $f` -bordercolor none -compose Copy -border 10 ../temp/`echo $f`
done

cd ../temp
for f in ./*
do
	echo "Zmieniam rozmiar "$f
	convert -background none `echo $f` -trim +repage -resize 200x120 -gravity center -extent 220x132 ../MyPicons-transparent-8bit/`echo $f`
done

cd ../MyPicons-transparent-8bit

for f in ./*
do
	echo "Optymalizuję do 8 bit "$f
	pngquant --force --ext .png 256 `echo $f`
done

cd ..
rm -rf temp

