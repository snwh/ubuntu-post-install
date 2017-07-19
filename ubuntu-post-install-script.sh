#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <sam@snwh.org>
#
# Description:
#   A set of post-installation script for Ubuntu and Ubuntu-based distributions
#
# Legal Preamble:
#
# This project is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This project is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
tabs 4
clear

# Import functions

dir=$(dirname "$0")

. $dir/functions/check
. $dir/functions/cleanup
. $dir/functions/codecs
. $dir/functions/configure
. $dir/functions/development
. $dir/functions/favs
. $dir/functions/fonts
. $dir/functions/gnome
. $dir/functions/password
. $dir/functions/thirdparty
. $dir/functions/update
. $dir/functions/utilities


# Fancy colorful messages

# grey titles
display_title(){
echo -e "\033[1;30m$@\033[0m"
}
# red error messages
display_error(){
echo -e "\033[1;31m$@\033[0m" 1>&2
}
# green info messages
display_info(){
echo -e "\033[1;32m$@\033[0m"
}
# yellow warning messages
display_warning(){
echo -e "\033[1;33m$@\033[0m"
}
# blue questions
display_question(){
echo -e "\033[1;34m$@\033[0m"
}
# pink success messages
display_success(){
echo -e "\033[1;35m$@\033[0m"
}
# cyan header messages
display_header(){
echo -e "\033[1;36m$@\033[0m"
}

# Main
function main {
	# Draw window
	MAIN=$(eval `resize` && whiptail \
		--notags \
		--title "Ubuntu Post-Install Script" \
		--menu "\nWhat would you like to do?" \
		--cancel-button "Quit" \
		32 96 16 \
		update		'Perform system update' \
		favs		'Install preferred applications' \
		utilities	'Install preferred system utilities' \
		development	'Install preferred development tools' \
		codecs		'Install non-free codecs' \
		fonts		'Install additional fonts' \
		thirdparty	'Install third-party applications' \
		gnome		'Install latest GNOME software' \
		configure	'Configure system' \
		cleanup		'Cleanup the system' \
		3>&1 1>&2 2>&3)

	# check exit status
	exitstatus=$?
	if [ $exitstatus = 0 ]; then
		$MAIN
	else
		quit
	fi
}

# Quit
function quit {
	display_title "Starting 'quit' function..."
	if (whiptail --title "Quit" --yesno "Are you sure you want quit?" 8 64) then
		echo "Exiting..."
		display_success 'Thanks for using!'
		exit 99
	else
		main
	fi
}

# Welcome message
display_header "Ubuntu Post-Install Script"
# Check
display_title "Starting 'check' function..."
check

# Main
while :
do
	main
done

#END OF SCRIPT
