#!/bin/bash
FILES=./img/*
aframeversion="-v0.7.1"
#aframeversion="-v0.9.2"

echo "----------------------------------"
echo "  CREATE AFrame 360 Degree Image"
echo "----------------------------------"
echo "  search image files that match '${FILES}' "
for f in $FILES
do
  file=`basename "$f"`
  extension="${file##*.}"
  filename="${file%.*}"
  echo "------------------"
  echo "Processing '$file' file..."
  echo "Extension '$extension' with basename '$filename' "
  OUTPUT="./${filename}_${extension}_360.html"
  echo "Output File: ${OUTPUT} "
  NOW=$(date +"%d.%m.%Y")
  echo "<!DOCTYPE html>" > $OUTPUT
  echo "<HTML>" >> $OUTPUT
  echo "\t<HEAD>" >> $OUTPUT
  echo "\t\t<meta charset='utf-8'>" >> $OUTPUT
  echo "\t\t<meta script='create_html4image.sh' created='${NOW}'>" >> $OUTPUT
  echo "\t\t<meta repository='https://www.gitlab.com/niehausbert/aframe360' created='${NOW}'>" >> $OUTPUT
  echo "\t\t<TITLE>360 Aframe Panorama</TITLE>"  >> $OUTPUT
  echo '\t\t<meta name="description" content="360&deg; Image - A-Frame">' >> $OUTPUT
  echo "\t\t<script src='js/aframe${aframeversion}.min.js'></script>" >> $OUTPUT
  echo "\t</HEAD>" >> $OUTPUT
  echo '\t<BODY>' >> $OUTPUT
  echo '\t\t<a-scene>' >> $OUTPUT
  echo "\t\t\t<a-sky src='$f' rotation='0 -130 0'></a-sky>" >> $OUTPUT
  echo '\t\t<a-sound src="src: url(audio/ocean_waves.mp3)" autoplay="true" position="0 2 5"></a-sound>' >> $OUTPUT
  echo '\t\t</a-scene>' >> $OUTPUT
  echo '\t</BODY>' >> $OUTPUT
  echo '\t</HTML>' >> $OUTPUT

done
echo "------------------\n"
echo "----------------------------------------------"
echo "AFrame Version:     aframe${aframeversion}.min.js "
echo "Generated:          ${NOW} "
echo "Source Image Files: ${FILES} "
echo "----------------------------------------------"
