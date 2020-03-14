#!/bin/bash

filePath=$3
relativePath=${filepath#./downloads/}
topPath=./downloads/${relativePath%%/*} # It will be the path of folder when it has multiple files, otherwise it will be the same as file path.

LIGHT_GREEN_FONT_PREFIX="\033[1;32m"
FONT_COLOR_SUFFIX="\033[0m"
INFO="[${LIGHT_GREEN_FONT_PREFIX}INFO${FONT_COLOR_SUFFIX}]"

echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Delete .aria2 file ..."

if [ $2 -eq 0 ]; then
    exit 0
elif [ -e "${filepath}.aria2" ]; then
    rm -vf "${filepath}.aria2"
elif [ -e "${topPath}.aria2" ]; then
    rm -vf "${topPath}.aria2"
fi
echo -e "$(date +"%m/%d %H:%M:%S") ${INFO} Delete .aria2 file finish"
echo "$(($(cat numUpload)+1))" > numUpload # Plus 1

echo "RCLONEEEEEEEEEEEEE"
#if [[ $2 -eq 1 ]]; then # single file
#	rclone -v --config="rclone.conf" copy "$3" "$RCLONE_1ST_REMOTE:$RCLONE_1ST_DESTINATION" 2>&1	
#	rclone -v --config="rclone.conf" copy "$3" "$RCLONE_2ND_REMOTE:$RCLONE_2ND_DESTINATION" 2>&1	
#elif [[ $2 -gt 1 ]]; then # multiple file
#	SIZE=$(du -B 1 "$topPath" -s | cut --delimiter='	' -f 1)    
	# 2GB = 2147483648 bytes
	# 10GB = 10737418240 bytes
	#if [[ $SIZE -gt 104857600 ]]; then
	#	echo 'Zipping file....'
	#	dirname="$topPath"
	#	echo $dirname
	#	echo $topPath
	#	echo $relativePath
	#	echo $filePath
	#	cd "$dirname"
	#	result="${dirname%"${dirname##*[!/]}"}" # extglob-free multi-trailing-/ trim
	#	result="${result##*/}"
	#	filename="$result.zip"
	#	zip -r "$filename" "."
	#	filename=$(realpath "$filename")
	#	echo "$filename"
	#	cd
	#	rclone -v --config="rclone.conf" copy "$filename" "$RCLONE_1ST_REMOTE:$RCLONE_1ST_DESTINATION" 2>&1	
	#	rclone -v --config="rclone.conf" copy "$filename" "$RCLONE_2ND_REMOTE:$RCLONE_2ND_DESTINATION" 2>&1
	#	echo "FINITO" 
	#else
		rclone -v --config="rclone.conf" copy "$topPath" "$RCLONE_1ST_REMOTE:$RCLONE_1ST_DESTINATION/${relativePath%%/*}"
#		rclone -v --config="rclone.conf" copy "$topPath" "$RCLONE_2ND_REMOTE:$RCLONE_2ND_DESTINATION/${relativePath%%/*}"
	#fi
#fi


echo "$(($(cat numUpload)-1))" > numUpload # Minus 1
