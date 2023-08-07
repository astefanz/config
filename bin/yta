#!/bin/sh
# Download given URL and convert it to audio
# Requires yt-dlp and ffmpeg to be installed

EXT="m4a"
if [ $# -eq 1 ]; then
	yt-dlp -x -f $EXT $1
elif [ $# -eq 2 ]; then
	yt-dlp -x -f $EXT $1 --output "$2.$EXT"
else
	echo "$0: Download videos as audio files ($EXT)"
	echo "Usage: $0 URL [OUTPUTNAME]" >&2
	exit 1
fi
