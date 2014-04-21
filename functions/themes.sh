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

# THIRD PARTY THEMES
function themes {
echo 'What would you like to install? '
echo ''
echo '1. Moka Icon Theme'
echo '2. Faba Icon Theme'
echo '3. Moka GTK Theme'
echo '4. Moka GNOME Shell Theme'
echo '5. Orchis GTK Theme'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Moka Icon Theme
1)
    # Add repository
    echo 'Adding Moka Icon Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/moka-icon-theme
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Moka icon themes...'
    echo 'Requires root privileges:'
    sudo apt-get install -y moka-icon-theme
    echo 'Done.'
    # Set Theme
    read -p "Do you want to set Moka as desktop theme? (Y)es, (N)o : " INPUT
    case $INPUT in
        [Yy]* ) 
            echo "Setting Moka as desktop Icon theme..."
            gsettings set org.gnome.desktop.interface icon-theme "Moka"
            echo "Done."
            themes
            ;;
        [Nn]* ) echo 'Done.'; themes;;
        * ) echo; echo "Uh oh, invalid response. Continuing without changes."; themes;;
    esac
    themes
    ;;
# Faba Icon Theme
2)
    # Add repository
    echo 'Adding Faba Icon Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/faba-icon-theme
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Faba icon themes...'
    echo 'Requires root privileges:'
    sudo apt-get install -y faba-icon-theme faba-mono-icons faba-icon-theme-symbolic
    echo 'Done.'
    themes
    ;;
# Moka GTK Theme
3)
    # Add repository
    echo 'Adding Moka GTK Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/moka-gtk-theme
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Moka GTK theme...'
    echo 'Requires root privileges:'
    sudo apt-get install -y moka-gtk-theme
    echo 'Done.'
    # Set Theme
    read -p "Do you want to set Moka as desktop theme? (Y)es, (N)o : " INPUT
    case $INPUT in
        [Yy]* )
            echo "Setting Moka as GTK window theme..."
            gsettings set org.gnome.desktop.wm.preferences theme "Moka"
            echo "Done."
            echo "Setting Moka as desktop GTK theme..."
            gsettings set org.gnome.desktop.interface gtk-theme "Moka"
            echo "Done."
            themes
            ;;
        [Nn]* ) echo 'Done.'; themes;;
        * ) echo; echo "Uh oh, invalid response. Continuing without changes."; themes;;
    esac
    themes
    ;;
# Moka GNOME Shell Theme
4)
    # Add repository
    echo 'Adding Moka GNOME Shell Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/moka-gnome-shell-theme
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Moka GNOME Shell theme...'
    echo 'Requires root privileges:'
    sudo apt-get install -y moka-gnome-shell-theme
    echo 'Done.'
    themes
    ;;
# Orchis GTK Theme
5)
    # Add repository
    echo 'Adding Orchis GTK Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/orchis-gtk-theme
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Orchis GTK theme...'
    echo 'Requires root privileges:'
    sudo apt-get install -y orchis-gtk-theme
    echo 'Done.'
    # Set Theme
    read -p "Do you want to set Orchis as desktop theme? (Y)es, (N)o : " INPUT
    case $INPUT in
        [Yy]* )
            echo "Setting Orchis as GTK window theme..."
            gsettings set org.gnome.desktop.wm.preferences theme "Orchis"
            echo "Done."
            echo "Setting Orchis as desktop GTK theme..."
            gsettings set org.gnome.desktop.interface gtk-theme "Orchis"
            echo "Done."
            themes
            ;;
        [Nn]* ) echo 'Done.'; themes;;
        * ) echo; echo "Uh oh, invalid response. Continuing without changes."; themes;;
    esac
    themes
    ;;
# Return
[Rr]*) 
    clear && customize;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && themes;;
esac
}

