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

# SYSTEM UPGRADE
function sysupgrade {
# Perform system upgrade
echo ''
read -p 'Proceed with system upgrade? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Dist-Upgrade
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.'
    sysupgrade
    ;;
esac
}

