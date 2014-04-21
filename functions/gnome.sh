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

# INSTALL GNOME COMPONENTS
function gnome {
echo ''
echo '1. Add GNOME3 PPA?'
echo '2. Add GNOME3 Staging PPA?'
echo '3. Add GNOME3 Next PPA?'
echo '4. Install GNOME Shell?'
echo '5. Install extra GNOME components?'
echo '6. Configure GNOME Shell Specific Settings?'
echo 'r. Return.'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Add GNOME3 PPA
1)
    # Add repository
    echo 'Adding GNOME3 PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3
    # Update repository information
    echo 'Updating repository information...'
    sudo apt-get update
    # Upgrade system
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    echo ''
    gnome
    ;;
# Add GNOME3 Staging PPA
2)
    # Add repository
    echo 'Adding GNOME3 Staging PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3-staging
    # Update repository information
    echo 'Updating repository information...'
    sudo apt-get update
    # Upgrade system
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    echo ''
    gnome
    ;;
# Add GNOME3 Next PPA
3)
    # Add repository
    echo 'Adding GNOME3 Next PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3-next
    # Update repository information
    echo 'Updating repository information...'
    sudo apt-get update
    # Upgrade system
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    echo ''
    gnome
    ;;
# Install GNOME Shell
4)
    echo 'Installing GNOME Shell...'
    echo 'Requires root privileges:'
    sudo apt-get install -y gnome-shell gnome-shell-extensions gnome-session
    echo 'Done.'
    echo ''
    gnome
    ;;
# Install extra GNOME components
5)
    echo 'Installing extra GNOME components...'
    echo 'Requires the "gnome3-staging" and "gnome3-next" PPAs to be in the repositories.'
    echo ''
    echo 'Current package list:
    cheese
    gnome-boxes
    gnome-maps
    gnome-online-accounts
    gnome-weather'
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        # Feel free to change to whatever suits your preferences.
        sudo apt-get install -y cheese gnome-boxes gnome-maps gnome-online-accounts gnome-weather
        echo 'Done.'
        clear && gnome
        ;;
    # Negative action
    [Nn]* )
        clear && gnome
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        gnome
        ;;
    esac
    ;;
# Configure Shell Specific Settings
6)
    # Font Settings
    echo 'Setting font preferences...'
    echo 'Requires the "Cantarell" font.'
    # Check if "fonts-cantarell" package is installed
    PACKAGE=$(dpkg-query -W --showformat='${Status}\n' fonts-cantarell | grep "install ok installed")
    echo "Checking if installed..."
    if [ "" == "$PACKAGE" ]; then
        echo 'Cantarell is not installed.'
        echo 'Installing... '
        echo 'Requires root privileges:'
        sudo apt-get install -y fonts-cantarell
        echo 'Done. '
    else
        echo 'Cantarell is installed, proceeding... '
    fi
    # Settings font settings
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'
    gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'
    gsettings set org.gnome.nautilus.desktop font 'Cantarell 10'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 10'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    echo 'Done. '
    # GNOME Shell Settings
    echo 'Setting GNOME Shell window button preferences...'
    gsettings set org.gnome.shell.overrides button-layout ':close'
    echo 'Done. '
    echo ''
    gnome
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && gnome;;
esac
}

