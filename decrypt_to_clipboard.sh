#!/bin/sh
if [ $# -eq 0 ] || [ "$1" = "--help" ] ; then 
	echo "Usage:" && echo "$0 [FILENAME]"
else 
	#Checking for adequate prerequisites
	if ! command -v gpg > /dev/null; then echo "gnupg is not installed"; exit 127; fi
	
	# File name and temporary folder location variables
	fileName=$(awk 'BEGIN { srand(); print int(rand()*32768) }' /dev/null | md5sum | head -c 32)
	[ -z "$TEMP" ] && TEMP="/tmp"
	if [ -w "$TEMP" ]; then directory="$TEMP"
	elif [ -w "$XDG_CACHE_HOME" ]; then directory="$XDG_CACHE_HOME"
	elif [ -w "$HOME/.cache"  ]; then directory="$HOME/.cache"
	elif [ -w "$HOME" ]; then directory="$HOME"
	elif [ -w "." ]; then directory=.
	else echo "You don't have any writable directories"; exit 1; fi
	
	# Decryption
	gpg --no-symkey-cache --output "$directory/$fileName" "$1"
	success=$?
	
	# Clipboards by OS'
	command -v xclip > /dev/null && clipboard="xclip -selection clip"
	command -v pbcopy > /dev/null && clipboard="pbcopy"
	[ -d "/c/Windows/" ] && command -v clip.exe > /dev/null && clipboard="clip.exe"
	
	# Copies the decrypted text file to the system clipboard
	[ $success -eq 0 ] && [ -n "$clipboard" ] && \
	head -n 1 "$directory/$fileName" | $clipboard &&\
	echo Copied to clipboard sucessfully && \
	rm "$directory/$fileName" && \
	echo "Clearing the clipboard in 15 seconds" && \
	sleep 15 && $clipboard < /dev/null && echo &

	# If the script doesn't detect any clipboard programs
	[ $success -eq 0 ] && [ -z "$clipboard" ] && \
	echo "xclip is not installed" && \
	trap  'rm "$directory/$fileName" ; exit' INT && \
	printf "Do you want to read the file here? [y/N]: " && read -r prompt && \
	case $prompt in
		[Yy]*) clear && head -n 1 "$directory"/"$fileName" ;;
	esac && \
	rm "$directory/$fileName" && echo
fi	
