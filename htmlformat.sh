#!/bin/bash 
#

if [[ -z "$1" || -z "$2" || ! -f "$1" ]];
  then
    echo "htmlformat.sh [file to format] [file to write output]";
    return 1
fi

echo "Start processing.."
rm $2
echo "Add new lines"
n=0
indent=""
curline=""
cr='
'

while read -r line; do
   IFS=$'\n';line2=$(echo "$line" | sed -e 's/<\([\/a-zA-Z]*\)>/\n\<\1\>\n/g' |sed -e  's/\n\n/\n/g')
for line3 in ${line2//\\\n/$cr};
do
#       echo "$(( ++c )) |$line3|$curline|"
       if [[ "$line3" =~ ^"<".*">"$ ]]; then
          if [[ "$line3" == \<\/* ]]; then
            indent=$(printf "%$(((n-1)*3))s")
             (( --n ))
             if [[ -z "$curline" ]]; then
                curline="$indent$line3"
             else
                curline="$curline$line3"
             fi
             echo "$curline" >> $2
             curline=""
          else
             if [[ ! -z "$curline" ]]; then
                echo "$curline" >> $2
             fi
             (( ++n ))
             indent=$(printf "%$(((n-1)*3))s")
             curline="$indent$line3"
          fi
       else
          curline="$curline$line3"
       fi

    done
done  < $1

cat $2
