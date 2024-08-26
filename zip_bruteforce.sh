#!/bin/bash

# ======
# COLORS
# ======

WHITE="\033[1;37m"
GREEN="\033[0;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
END="\e[0m"

# ======
# BANNER
# ======

echo -e "\n
███████╗██╗██████╗     ██████╗ ██████╗ ██╗   ██╗████████╗███████╗███████╗ ██████╗ ██████╗  ██████╗███████╗
╚══███╔╝██║██╔══██╗    ██╔══██╗██╔══██╗██║   ██║╚══██╔══╝██╔════╝██╔════╝██╔═══██╗██╔══██╗██╔════╝██╔════╝
  ███╔╝ ██║██████╔╝    ██████╔╝██████╔╝██║   ██║   ██║   █████╗  █████╗  ██║   ██║██████╔╝██║     █████╗  
 ███╔╝  ██║██╔═══╝     ██╔══██╗██╔══██╗██║   ██║   ██║   ██╔══╝  ██╔══╝  ██║   ██║██╔══██╗██║     ██╔══╝  
███████╗██║██║         ██████╔╝██║  ██║╚██████╔╝   ██║   ███████╗██║     ╚██████╔╝██║  ██║╚██████╗███████╗
╚══════╝╚═╝╚═╝         ╚═════╝ ╚═╝  ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝
                                                                                                          "

echo -e "\n${YELLOW}[?]${END} ${BLUE}USAGE:${END} ${WHITE}zip_bruteforce.sh <wordlist> <zip_file>${END}\n"

# ================
# GLOBAL VARIABLES
# ================

wordlist=$1
zip_file=$2

error=0

# ==============
# ERROR HANDLING
# ==============

# wordlist check

if [ ! $1 ]; then

	echo -e "${RED}[!]${END} ${BLUE}ERROR:${END} ${WHITE}No wordlist specified${END}\n"
	error=1

fi

# zip file check

if [ ! $2 ]; then

	echo -e "${RED}[!]${END} ${BLUE}ERROR:${END} ${WHITE}No zip file specified${END}\n"
	error=1

fi

# error check

if [ $error -eq 1 ]; then

	exit 1

fi

# =============
# BRUTE FORCING
# =============

while read -r line
do
	echo -e "${GREEN}[+]${END} ${WHITE}Trying password ${END}${line}"

	# try password
	
	unzip -t -P $line $zip_file &>/dev/null
	
	# check if its valid
	
	if [ $? -eq 0 ]; then
		echo -e "\n${GREEN}[*] PASSWORD FOUND --> ${END}${line}\n"
		break
	fi
done < "$wordlist"
