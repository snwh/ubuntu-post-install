#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for Ubuntu (14.04)
#
# Legal Stuff:
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

SYSTEM_APPS_LIST=( $SYSTEM_APPS )

# INSTALL SYSTEM TOOLS
function system {
echo ''
echo '1. Install favourite system utilities?'
echo '2. Install fingerprint reader software?'
echo 'r. Return.'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Install Favourite System utilities
1)
    echo 'Installing favourite system utilities...'
    echo ''
    echo 'Current package list:'
    printf "%s\n"  "${SYSTEM_APPS_LIST[@]}"
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        # Feel free to change to whatever suits your preferences.
        sudo apt-get install -y --no-install-recommends $SYSTEM_APPS
        echo 'Done.'
        clear && system
        ;;
    # Negative action
    [Nn]* )
        clear && system
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        system
        ;;
    esac
    ;;
# Install Fingerprint Reader Software
2)
    # Add repository
    echo 'Adding Fingerprint Reader Team PPA to software sources...'
    echo 'Requires root privileges:'
    sudo apt-add-repository -y ppa:fingerprint/fingerprint-gui
    # Update repository information
    echo 'Updating repository information...'
    sudo apt-get update
    # Install package(s)
    echo 'Installing fingerprint reader software...'
    sudo apt-get install -y libbsapi policykit-1-fingerprint-gui fingerprint-gui
    echo 'Done.'
    system
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && development;;
esac
}

