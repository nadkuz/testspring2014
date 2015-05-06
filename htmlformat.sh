#!/bin/bash +cx
# 


if [[ -z "$1" || -z "$2" || ! -f "$1" ]];
  then
    
    echo "htmlformat.sh [file to format] [file to write output]";
    exit 1
fi

echo "Start processing.."

echo "Add new lines"
n=0
while read -r line; do 
#   echo "Got line $line"
   IFS=$'\n';line2=$(echo "$line" | sed -e 's/\(.*\)\<\(.*\)\>\(.*\)/\1\\\n<\2>\\\n\3/g'|sed -e  's/\\\n\\\n/\\\n/g')
#   echo "   add indents"
cr='
'
indent=""
for line3 in ${line2//\\\n/$cr}
do
#        echo "$(( ++c )) |$line3|"
#       indent=""
       if [[ "$line3" =~ ^"<".*">"$ ]]; then
#          echo "got tag"
          if [[ "$line3" == \<\/* ]]; then
            indent=$(printf "%$(((n-1)*3))s")
             (( --n ))
          else
             (( ++n ))
             indent=$(printf "%$(((n-1)*3))s")
          fi
           
       fi
       echo "$indent$line3" >> $2
           
       
	
    done
done  < $1

cat $2
