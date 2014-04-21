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

#----- FUNCTIONS -----#
. $FUNCTIONS_DIR/config.sh
. $FUNCTIONS_DIR/themes.sh

# CUSTOMIZATION
function customize {
echo ''
echo '1. Configure system?'
echo '2. Install Third-Party themes?'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) clear && config;; # System Configuration
    2) clear && themes;; # Install Third-Party Themes
    [Rr]*) clear && main;; # Return
    * ) clear && echo 'Not an option, try again.' && customize;; # Invalid choice
esac
}

