#!/bin/bash +x
# 


if [[ -z "$1" || -z "$2" || ! -f "$1" ]];
  then
    echo "htmlformat.sh [file to format] [file to write output]";
    exit 1
fi





while read -r line; do 
   line2=`echo $line | sed  '/\(.*\)<\([a-zA-Z\.\-\_\:\*\@\#\$\/]*\)>\(.*\)/\1<\2\>a\
\3/'`
   n=0
   echo "LINE2 : $line2"
   printf %s "$line2" | while IFS= read -r line3;  do
      echo "LIBE 3 $line3"
   done 
#  while read -r line3; do
#      line4=echo $line3 | sed 's/^\(\s*\)<\([a-zA-Z\.\-\_\:\*\@\#\$\/]*\)>\(.*\)/\s{(( n*3 ))}<\2>\3/g'
#      echo $line4
#      echo $line4 >> $2

#      (( n++ ))
#   done < <(line2) 
done < $1
