for FILE in  ./*.png
do
convert -resize "1400>" ${FILE} ${FILE}_resized.jpg
done
