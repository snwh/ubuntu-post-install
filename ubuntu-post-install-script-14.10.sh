#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for Ubuntu (v14.04)
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

echo ''
echo '#-------------------------------------------#'
echo '#     Ubuntu Post-Install Script v14.10     #'
echo '#-------------------------------------------#'

#----- DECLARATIONS -----#

FAVS="favourites.txt"
UTILS="utilities.txt"
EXTRAS="gnome-extras.txt"
DEVTOOLS="dev-tools.txt"
DESTOOLS="design-tools.txt"
PURGED="purged.txt"

#----- FUNCTIONS -----#

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

# INSTALL APPLICATIONS
function favourites {
# Install Favourite Applications
echo ''
echo 'Installing selected favourite applications...'
echo ''
echo 'Current package list:'
for fav in `cat $FAVS`
do 
echo $fav
done
echo ''
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Feel free to change the contents of 'favourites.txt' to whatever suits your preferences.
    sudo apt-get install -y --no-install-recommends $(cat $FAVS)
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
    favourites
    ;;
esac
}

# INSTALL SYSTEM TOOLS
function system {
# Install Favourite System Utilities
echo 'Installing favourite system utilities...'
echo ''
echo 'Current package list:'
for util in `cat $UTILS`
do 
echo $util
done
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* )
    echo 'Requires root privileges:'
    # Feel free to change the contents of "utilities.txt" to whatever suits your preferences.
    sudo apt-get install -y --no-install-recommends $(cat $UTILS)
    echo 'Done.'
    system
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
}


# INSTALL GNOME COMPONENTS
function gnome {
echo ''
echo '1. Add GNOME3 PPA?'
echo '2. Add GNOME3 Staging PPA?'
echo '3. Install GNOME Shell?'
echo '4. Install extra GNOME components?'
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
    echo 'Done.'
    # Upgrade system?
    read -p 'Perform system upgrade? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        sudo apt-get dist-upgrade -y
        echo 'Done.'
        gnome
        ;;
    # Negative action
    [Nn]* )
        clear && gnome
        echo 'Done.'
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        gnome
        ;;
    esac
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
    echo 'Done.'
    echo ''
    # Upgrade system?
    read -p 'Perform system upgrade? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        sudo apt-get dist-upgrade -y
        echo 'Done.'
        gnome
        ;;
    # Negative action
    [Nn]* )
        clear && gnome
        echo 'Done.'
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        gnome
        ;;
    esac
    ;;
    gnome
    ;;
# Install GNOME Shell
3)
    echo 'Installing GNOME Shell...'
    echo 'Requires root privileges:'
    sudo apt-get install -y fonts-cantarell gdm gnome-shell gnome-shell-extensions gnome-session
    echo 'Done.'
    echo ''
    gnome
    ;;
# Install extra GNOME components
4)
    echo 'Installing extra GNOME components...'
    echo ''
    echo 'Current package list:'
    for extra in `cat $EXTRAS`
    do 
    echo $extra
    done
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        # Feel free to change the contents of "gnome-extras.txt" to whatever suits your preferences.
        sudo apt-get install -y $(cat $EXTRAS)
        echo 'Done.'
        gnome
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
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && gnome;;
esac
}


# INSTALL UBUNTU RESTRICTED EXTRAS
function codecinstall {
echo ''
read -p 'Install Ubuntu Restricted Extras? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Installing...'
    echo 'Requires root privileges:'
    sudo apt-get install -y ubuntu-restricted-extras
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* )
    clear && main;;
# Error
* )
    clear && echo 'Sorry, try again.' 
    codecinstall
    ;;
esac
}

# INSTALL DEVELOPMENT TOOLS
function development {
echo ''
echo '1. Install development tools?'
echo '2. Install Ubuntu SDK?'
echo '3. Install Ubuntu Phablet Tools?'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Install Development Tools
1)
    echo 'Installing development tools...'
    echo ''
    echo 'Current package list:'
    for devtool in `cat $DEVTOOLS`
    do 
    echo $devtool
    done
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* ) 
        echo 'Requires root privileges:'
        # Feel free to change the contents of "dev-tools.txt" to whatever suits your preferences.
        sudo apt-get install -y $(cat $DEVTOOLS)
        echo 'Done.'
        development
        ;;
    # Negative action
    [Nn]* )
        clear && development
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        development
        ;;
    esac
    ;;
# Install Ubuntu SDK
2)
    # Add repository
    echo 'Adding Ubuntu SDK Team PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:ubuntu-sdk-team/ppa
    # Update repository information
    echo 'Updating repository information...'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Ubuntu SDK...'
    sudo apt-get install -y ubuntu-sdk
    echo 'Done.'
    development
    ;;
# Install Ubuntu Phablet Tools
3)
    echo 'Installing Phablet Tools...'
    sudo apt-get install -y phablet-tools
    echo 'Done.'
    development
    ;;
# Return
[Rr]*) 
    clear && main;;
# Error
* )
    clear && echo 'Sorry, try again.' && development
    ;;
esac
}


#INSTALL DESIGN TOOLS
function design {
echo ''
echo 'Installing design tools...'
echo ''
echo 'Current package list:'
for destool in `cat $DESTOOLS`
do 
echo $destool
echo ''
done
read -p 'Proceed? (Y)es, (N)o : ' REPLY
case $REPLY in
# Positive action
[Yy]* ) 
    echo 'Requires root privileges:'
    # Feel free to change the contents of "design-tools.txt" to whatever suits your preferences.
    sudo apt-get install -y $(cat $DESTOOLS)
    echo 'Done.'
    main
    ;;
# Negative action
[Nn]* ) 
    clear && main
    ;;
# Error
* )
    clear && echo 'Sorry, try again.' && design
    ;;
esac
}

# THIRD PARTY THEMES
function themes {
echo 'What would you like to install? '
echo ''
echo '1. Moka Project'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Moka Icon Theme
1)
    # Add repository
    echo 'Adding Moka Icon Theme repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:moka/stable
    # Update repository information
    echo 'Updating repository information...'
    echo 'Requires root privileges:'
    sudo apt-get update
    # Install package(s)
    echo 'Installing Moka icon themes...'
    echo 'Requires root privileges:'
    sudo apt-get install -y moka-desktop
    echo 'Done.'
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

# THIRD PARTY APPLICATIONS
function thirdparty {
echo 'What would you like to install? '
echo ''
echo '1. Google Chrome?'
echo '2. Google Talk Plugin?'
echo '3. Google Music Manager?'
echo '4. Steam?'
echo '5. Sublime Text 3 (build 3059)?'
echo '6. Spotify client'
echo 'r. Return'
echo ''
read -p 'Enter your choice: ' REPLY
case $REPLY in
# Google Chrome
1) 
    echo 'Downloading Google Chrome...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Google Chrome...'
    echo 'Requires root privileges:'b
    sudo dpkg -i google-chrome*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm google-chrome*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Google Talk Plugin
2)
    echo 'Downloading Google Talk Plugin...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Google Talk Plugin...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-talkplugin_current*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm google-talkplugin_current*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Google Music Manager
3)
    echo 'Downloading Google Music Manager...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Google Music Manager...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-musicmanager-*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm google-musicmanager*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Steam
4)
    echo 'Downloading Steam...'
    cd $HOME/Downloads
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    fi
    # Install package(s)
    echo 'Installing Steam...'
    echo 'Requires root privileges:'
    sudo dpkg -i steam*.deb
    sudo apt-get install -fy
    echo 'Installing Steam dependencies...'
    echo 'Requires root privileges:'
    sudo apt-get install -y libgl1-mesa-glx libgl1-mesa-dev
    # Cleanup and finish
    rm steam*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Sublime Text 3 (build 3059)
5)
    echo 'Downloading Sublime Text 3 (build 3059)...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_amd64.deb
    fi
    # Install package(s)
    echo 'Installing Sublime Text 3 (build 3059)...'
    echo 'Requires root privileges:'
    sudo dpkg -i sublime-text_build-3059*.deb
    sudo apt-get install -fy
    # Create symbolic link
    echo 'Creating symbolic link...'
    echo 'Requires root privileges:'
    sudo ln -sf /opt/sublime_text/sublime_text /usr/bin/sublime
    echo 'Done.'
    # Cleanup and finish
    rm sublime-text_build-3059*.deb
    cd
    echo 'Done.'
    thirdparty
    ;;
# Spotify
6)
    # Add repository
    echo 'Adding Spotify repository to sources...'
    echo 'Creating apt list file...'
    touch spotify.list
    echo "deb http://repository.spotify.com stable non-free" >> spotify.list
    echo 'Requires root privileges:'
    sudo mv -f spotify.list /etc/apt/sources.list.d/
    echo 'Done.'
    # Update repository information
    echo 'Adding repository key and updating repository information...'
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
    sudo apt-get update
    # Install package(s)
    echo 'Installing Spotify client...'
    sudo apt-get install -y spotify-client
    echo 'Done.'
    thirdparty
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && thirdparty;;
esac
}

# CONFIG
function config {
echo ''
echo '1. Set preferred application-specific settings?'
echo '2. Show all startup applications?'
echo 'r. Return'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# GSettings
1)
    # Font Sizes
    echo 'Setting font preferences...'
    gsettings set org.gnome.desktop.interface text-scaling-factor '1.0'
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu 10'
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu 10'
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Mono 11'
    gsettings set org.gnome.nautilus.desktop font 'Ubuntu 10'
    gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Ubuntu Bold 9'
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing 'rgba'
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting 'slight'
    # Unity Settings
    echo 'Setting Unity preferences...'
    gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds true 
    gsettings set com.canonical.indicator.power icon-policy 'charge'
    gsettings set com.canonical.Unity.Lenses remote-content-search 'none'
    # Nautilus Preferences
    echo 'Setting Nautilus preferences...'
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    # Rhythmbox Preferences
    echo 'Setting Rhythmbox preferences...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    # Done
    echo "Done."
    config
    ;;
# Startup Applications
2)
    echo 'Changing display of startup applications.'
    echo 'Requires root privileges:'    
    cd /etc/xdg/autostart/ && sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Done.'
    config
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && config;;
esac
}

# CLEANUP SYSTEM
function cleanup {
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove leftover configuration files?'
echo '5. Clean package cache?'
echo 'r. Return?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
# Remove Unused Pre-installed Packages
1)
    echo 'Removing selected pre-installed applications...'
    echo ''
    echo 'Current package list:'
    for purge in `cat $PURGED`
    do 
    echo $purge
    done
    echo ''
    read -p 'Proceed? (Y)es, (N)o : ' REPLY
    case $REPLY in
    # Positive action
    [Yy]* )
        echo 'Requires root privileges:'
        sudo apt-get purge -y $(cat $PURGED)
        echo 'Done.'
        cleanup
        ;;
    # Negative action
    [Nn]* )
        clear && cleanup
        ;;
    # Error
    * )
        clear && echo 'Sorry, try again.'
        cleanup
        ;;
    esac
    ;;
# Remove Old Kernel
2)
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
    ;;
# Remove Orphaned Packages
3)
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
    ;;
# Remove residual config files?
4)
    echo 'Removing leftover configuration files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
    cleanup
    ;;
# Clean Package Cache
5)
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
    ;;
# Return
[Rr]*) 
    clear && main;;
# Invalid choice
* ) 
    clear && echo 'Not an option, try again.' && cleanup;;
esac
}

# Quit
function quit {
read -p "Are you sure you want to quit? (Y)es, (N)o " REPLY
case $REPLY in
    [Yy]* ) exit 99;;
    [Nn]* ) clear && main;;
    * ) clear && echo 'Sorry, try again.' && quit;;
esac
}

#----- MAIN FUNCTION -----#
function main {
echo ''
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install favourite system utilities?'
echo '4. Install development tools?'
echo '5. Install design tools?'
echo '6. Install extra GNOME components?'
echo '7. Install Ubuntu Restricted Extras?'
echo '8. Install third-party applications?'
echo '9. Customize system?'
echo '10. Cleanup the system?'
echo 'q. Quit?'
echo ''
read -p 'What would you like to do? (Enter your choice) : ' REPLY
case $REPLY in
    1) sysupgrade;; # System Upgrade
    2) clear && favourites;; # Install Favourite Applications
    3) clear && system;; # Install Favourite Tools
    4) clear && development;; # Install Dev Tools
    5) clear && design;; # Install Design Tools
    6) clear && gnome;; # Install GNOME components
    7) clear && codecinstall;; # Install Ubuntu Restricted Extras
    8) clear && thirdparty;; # Install Third-Party Applications
    9) clear && customize;; # Customize system
    10) clear && cleanup;; # Cleanup System
    [Qq]* ) echo '' && quit;; # Quit
    * ) clear && echo 'Not an option, try again.' && main;;
esac
}

#----- RUN MAIN FUNCTION -----#
main

#END OF SCRIPT