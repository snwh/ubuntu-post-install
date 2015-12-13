#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for Ubuntu
#
# Legal Preamble:
#
# This script is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; version 3.
#
# This script is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, see <https://www.gnu.org/licenses/gpl-3.0.txt>

# tab width
# tabs 4
clear
echo ''
echo '#------------------------------------#'
echo '#     Ubuntu Post-Install Script     #'
echo '#------------------------------------#'

#----- FUNCTIONS -----#

dir="$(dirname "$0")"

. $dir/functions/cleanup
. $dir/functions/codecs
. $dir/functions/config
. $dir/functions/customize
. $dir/functions/design
. $dir/functions/development
. $dir/functions/favourites
. $dir/functions/gnome
. $dir/functions/system
. $dir/functions/upgrade
. $dir/functions/thirdparty

#----- MESSAGE FUNCTIONS -----#

show_listitem() {
echo -e "\033[0;37m$@\033[0m"
}

show_error() {
echo -e "\033[1;31m$@\033[m" 1>&2
}

show_success() {
echo -e "\033[1;32m$@\033[0m"
}

show_warning() {
echo -e "\033[1;33m$@\033[0m"
}

show_question() {
echo -e "\033[1;34m$@\033[0m"
}

show_info() {
echo -e "\033[1;35m$@\033[0m"
}

#----- MAIN FUNCTIONS -----#

# Main
function main {
echo ''
show_question 'What would you like to do? '
echo ''
show_listitem '\t1. Perform system update & upgrade?'
show_listitem '\t2. Install favourite applications?'
show_listitem '\t3. Install favourite system utilities?'
show_listitem '\t4. Install favourite development tools?'
show_listitem '\t5. Install favourite design tools?'
show_listitem '\t7. Install Ubuntu Restricted Extras?'
show_listitem '\t8. Install third-party applications?'
show_listitem '\t9. Customize system?'
show_listitem '\t10. Cleanup the system?'
show_listitem '\tq. Quit?'
echo ''
show_question 'Enter your choice :' && read REPLY
case $REPLY in
    1) upgrade;; # System Upgrade
    2) clear && favourites;; # Install Favourite Applications
    3) clear && system;; # Install Favourite Tools
    4) clear && development;; # Install Dev Tools
    5) clear && design;; # Install Design Tools
    7) clear && codecs;; # Install Ubuntu Restricted Extras
    8) clear && thirdparty;; # Install Third-Party Applications
    9) clear && customize;; # Customize system
    10) clear && cleanup;; # Cleanup System
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && show_error '\aNot an option, try again.' && main;;
esac
}

# Quit
function quit {
show_question 'Are you sure you want quit? (Y)es, (N)o : ' && read REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && show_error 'Sorry, try again.' && quit;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT