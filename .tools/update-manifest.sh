#!/usr/bin/env sh
cd "$(dirname "$0")"

LESSONLIST="lesson-plans.manifest"
LESSONPLANROOT="https://wptrainingteam.github.io/lesson-plan/"
MANIFEST="../manifest.json"

printf "{\n" > $MANIFEST

while read in;
do
  rawtitle=$(echo $in | sed 's/https:\/\/github\.com\/wptrainingteam\///g');
  rawtitle=$(echo $rawtitle | sed 's/\.git//g');
  #echo $rawtitle;
  friendly_title=$(echo $rawtitle | sed 's/-/ /g');
  friendly_title=$(echo $friendly_title | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1');
  #echo $friendly_title;
  markdown_source="$LESSONPLANROOT$rawtitle/README.md";
  #echo $markdown_source;
  printf "\t\"$rawtitle\": {\n" >> $MANIFEST;
  printf "\t\t\"title\": \"$friendly_title\",\n" >> $MANIFEST;
  printf "\t\t\"slug\": \"$rawtitle\",\n" >> $MANIFEST;
  printf "\t\t\"markdown_source\": \"$markdown_source\",\n" >> $MANIFEST;
  printf "\t\t\"parent\": null\n" >> $MANIFEST;
  printf "\t},\n" >> $MANIFEST;
done < $LESSONLIST
sed -i '$ d' $MANIFEST;
printf "\t}\n}" >> $MANIFEST;
