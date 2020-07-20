#!/bin/bash
FILES=./img/*
aframeversion="-v0.7.1"
#aframeversion="-v0.9.2"
LIST_FILE="imglist.html"
LIST_FILE="index.html"
AUDIO_BOOL="no"
AUDIO_FILE="audio/ocean_waves.mp3"

echo "----------------------------------"
echo "  CREATE AFrame 360 Degree Image"
echo "----------------------------------"
echo "  search image files that match '${FILES}' "
echo " "
echo "<!DOCTYPE html>" > $LIST_FILE
echo "<HTML>" >> $LIST_FILE
echo "\t<HEAD>" >> $LIST_FILE
echo "\t\t<meta charset='utf-8'>" >> $LIST_FILE
echo "\t\t<TITLE>360 Aframe Panorama</TITLE>"  >> $LIST_FILE
echo "\t</HEAD>" >> $LIST_FILE
echo '\t<BODY>' >> $LIST_FILE
echo '\t\t<H3>' >> $LIST_FILE
echo '\t\t\tPanorama Image List' >> $LIST_FILE
echo '\t\t</H3>' >> $LIST_FILE
echo '\t\t<UL>' >> $LIST_FILE

for f in $FILES
do
  file=`basename "$f"`
  extension="${file##*.}"
  filename="${file%.*}"
  JSFILE="img64lib/${filename}.img64.js"
  echo "// Aframe Sky 360 Degree - equirectangular" > $JSFILE
  echo "// Base64 encoded file '${file}" >> $JSFILE
  echo "vDataJSON.aframe.sky = \"" >> $JSFILE
  echo "------------------"
  echo "Processing '$file' file..."
  echo "Extension '$extension' with basename '$filename' "
  OUTPUT="./${filename}_${extension}_base64.html"

  echo "\t\t\t<LI><a href='${OUTPUT}'>$OUTPUT</a></LI>" >> $LIST_FILE

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
  echo "\t\t<script language='JavaScript'>" >> $OUTPUT
  echo "\t\t\tvar vDataJSON = {\n\t\t\t\t\t\"aframe\" : {}\n\t\t\t\t\"};" >> $OUTPUT
  echo "\t\t</script>" >> $OUTPUT
  echo "\t\t<script src='$JSFILE'></script>" >> $OUTPUT
  echo "\t</HEAD>" >> $OUTPUT
  echo '\t<BODY>' >> $OUTPUT
  echo '\t\t<a-scene>' >> $OUTPUT
  echo '\t\t\t<a-assets>' >> $OUTPUT
  # BASE64_IMG=$($(cat ${f} | base64))
  BASE64_IMG=$( base64 ${f} )
  echo "${BASE64_IMG}\";\n" >> $JSFILE

  # echo "BASE64_IMG=$BASE64_IMG"
  # echo "data:image/jpeg;base64,$(base64 -w 0 DSC_0251.JPG)"
  #echo "\t\t\t\t<img id=\"panorama\" src=\"${f}\" crossorigin=\"anonymous\" />"  >> $OUTPUT
  #echo "\t\t\t\t<img id=\"base64panorama\" src=\"data:image/jpeg;base64,${BASE64_IMG}\"  />"  >> $OUTPUT
  echo '\t\t\t</a-assets>' >> $OUTPUT
  #echo '\t\t\t<a-sky src=\"#panorama\" rotation="0 -90 0"></a-sky>' >> $OUTPUT
  #echo '\t\t\t<a-sky src=\"${f}\" rotation="0 -90 0"  crossorigin=\"anonymous\"></a-sky>' >> $OUTPUT
  echo "\t\t\t<a-sky src=\"data:image/jpeg;base64,${BASE64_IMG}\" rotation="90 90 90"  crossorigin=\"anonymous\"></a-sky>" >> $OUTPUT
  if [ "$AUDIO_BOOL" = "yes" ]; then
      echo "USE AUDIO: $AUDIO_BOOL with audio file '${AUDIO_FILE}'"
  	  echo "\t\t<a-sound src=\"src: url(${AUDIO_FILE})\" autoplay=\"true\" position=\"0 2 5\"></a-sound>" >> $OUTPUT
  else
  	echo "Sound file '${AUDIO_FILE}' was not used"
  fi
  echo '\t\t</a-scene>' >> $OUTPUT
  echo "\t\t<script src='js/aframe${aframeversion}.js'></script>" >> $OUTPUT
  echo '\t</BODY>' >> $OUTPUT
  echo '\t</HTML>' >> $OUTPUT
done
echo '\t\t</UL>' >> $LIST_FILE
echo '\t</BODY>' >> $LIST_FILE
echo "<HTML>" >> $LIST_FILE


echo "------------------\n"
echo "----------------------------------------------"
echo "AFrame Version:     aframe${aframeversion}.js "
echo "Generated:          ${NOW} "
echo "Source Image Files: ${FILES} "
echo "----------------------------------------------"
