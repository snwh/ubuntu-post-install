#!/bin/bash
# -*- Mode: sh; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
#
# Authors:
#   Sam Hewitt <hewittsamuel@gmail.com>
#
# Description:
#   A post-installation bash script for Ubuntu (13.04)
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
echo '#     Ubuntu 13.04 Post-Install Script      #'
echo '#-------------------------------------------#'

#----- FUNCTIONS -----#

# SYSTEM UPGRADE
function sysupgrade {
# Update Repository Information
echo 'Updating repository information...'
echo 'Requires root privileges:'
sudo apt-get update -qq
# Dist-Upgrade
echo 'Performing system upgrade...'
sudo apt-get dist-upgrade -y
echo 'Done.'
main
}

# INSTALL APPLICATIONS
function appinstall {
# Install Favourite Applications
echo 'Installing selected favourite applications...'
echo 'Requires root privileges:'
# Feel free to change to whatever suits your preferences.
sudo apt-get install -y --no-install-recommends darktable easytag filezilla gimp gimp-plugin-registry grsync imagemagick inkscape mypaint nautilus-dropbox nautilus-open-terminal pyrenamer sparkleshare xchat vlc
echo 'Done.'
main
}

# INSTALL SYSTEM TOOLS
function toolinstall {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Install favourite system tools?'
echo '2. Install fingerprint reader software?'
echo '3. Return.'
echo ''
read INPUT
# Install Favourite System Tools
if [ $INPUT -eq 1 ]; then
    echo 'Installing system tools...'
    echo 'Requires root privileges:'
    sudo apt-get install -y --no-install-recommends aptitude dconf-tools openjdk-7-jdk openssh-server p7zip-full ppa-purge samba ssh synaptic virt-manager zsync
    echo 'Done.'
# Install Fingerprint Reader Software
elif [ $INPUT -eq 2 ]; then
    echo 'Adding Fingerprint Reader Team PPA to software sources...'
    echo 'Requires root privileges:'
    sudo apt-add-repository -y ppa:fingerprint/fingerprint-gui
    echo 'Updating repository information...'
    sudo apt-get update -qq
    echo 'Installing fingerprint reader software...'
    sudo apt-get install -y libbsapi policykit-1-fingerprint-gui fingerprint-gui
    echo 'Done.'
# Return
elif [ $INPUT -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    gnomeextra
fi
done
}


# INSTALL GNOME SHELL
function gnomeextra {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Add GNOME3 PPA?'
echo '2. Add GNOME3 Staging PPA?'
echo '3. Install GNOME Shell?'
echo '4. Install extra GNOME applications?'
echo '5. Configure GNOME Shell Specific Settings?'
echo '6. Return.'
echo ''
read INPUT
# Add GNOME3 PPA
if [ $INPUT -eq 1 ]; then
    echo 'Adding GNOME3 PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3
    echo 'Updating repository information...'
    sudo apt-get update -qq
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    gnomeextra
# Add GNOME3 Staging PPA
elif [ $INPUT -eq 2 ]; then
    echo 'Adding GNOME3 Staging PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:gnome3-team/gnome3-staging
    echo 'Updating repository information...'
    sudo apt-get update -qq
    echo 'Performing system upgrade...'
    sudo apt-get dist-upgrade -y
    echo 'Done.'
    gnomeextra
# Install GNOME Shell
elif [ $INPUT -eq 3 ]; then
    echo 'Installing GNOME Shell...'
    echo 'Requires root privileges:'
    sudo apt-get install -y gnome-shell
    echo 'Done.'
    gnomeextra
# Install Extra GNOME 3 Apps
elif [ $INPUT -eq 4 ]; then
    echo 'Installing extra GNOME 3 applications...'
    echo 'Requires root privileges:'
    sudo apt-get install -y gnome-sushi gnome-tweak-tool
    echo 'Done.'
    gnomeextra
# Configure Shell Specific Settings
elif [ $INPUT -eq 5 ]; then
    # Font Sizes
    echo 'Setting font preferences...'
    echo 'Requires the "Cantarell" font.'
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
    gsettings set org.gnome.shell.overrides button-layout 'close:'
    echo 'Done. '
# Return
elif [ $INPUT -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    gnomeextra
fi
done
}

# INSTALL UBUNTU RESTRICTED EXTRAS
function codecinstall {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Install Ubuntu Restricted Extras?'
echo '2. Return'
echo ''
read INPUT
# Install Ubuntu Restricted Extras Applications
if [ $INPUT -eq 1 ]; then
    echo 'Installing Ubuntu Restricted Extras...'
    echo 'Requires root privileges:'
    sudo apt-get install -y ubuntu-restricted-extras
    echo 'Done.'
    codecinstall
# Return
elif [ $INPUT -eq 2 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    devinstall
fi
done
}

# INSTALL DEVELOPMENT TOOLS
function devinstall {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Install development tools?'
echo '2. Install Ubuntu SDK?'
echo '3. Install Ubuntu Phablet Tools?'
echo '4. Install IRC bot tools?'
echo '5. Return'
echo ''
read INPUT
# Install Development Tools
if [ $INPUT -eq 1 ]; then
    echo 'Installing development tools...'
    echo 'Requires root privileges:'
    sudo apt-get install -y bzr devscripts git glade icontool python-launchpadlib python3-distutils-extra qtcreator ruby
    echo 'Done.'
    devinstall
# Install Ubuntu SDK
elif [ $INPUT -eq 2 ]; then
    echo 'Adding QT5 Edgers PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:canonical-qt5-edgers/qt5-proper
    echo 'Adding Ubuntu SDK Team PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:ubuntu-sdk-team/ppa
    echo 'Updating repository information...'
    sudo apt-get update -qq
    echo 'Installing Ubuntu SDK...'
    sudo apt-get install -y ubuntu-sdk
    echo 'Done.'
    devinstall
# Install Ubuntu Phablet Tools
elif [ $INPUT -eq 3 ]; then
    echo 'Adding Phablet Team PPA to software sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:phablet-team/tools
    echo 'Updating repository information...'
    sudo apt-get update -qq
    echo 'Installing Ubuntu SDK...'
    sudo apt-get install -y phablet-tools
    echo 'Done.'
    devinstall
# Install IRC Bot Tools
elif [ $INPUT -eq 4 ]; then
    echo 'Installing IRC bot tools...'
    echo 'Requires root privileges:'
    sudo apt-get install -y python-soappy supybot
    echo 'Done.'
    devinstall
# Return
elif [ $INPUT -eq 5 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    devinstall
fi
done
}


# THIRD PARTY APPLICATIONS
function thirdparty {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Install Google Chrome?'
echo '2. Install Google Talk Plugin?'
echo '3. Install Google Music Manager?'
echo '4. Install Steam?'
echo '5. Install Unity Tweak Tool?'
echo '6. Return'
echo ''
read INPUT
# Google Chrome
if [ $INPUT -eq 1 ]; then
    echo 'Downloading Google Chrome...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    # Install the package
    echo 'Installing Google Chrome...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-chrome-stable_current_*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Google Talk Plugin
elif [ $INPUT -eq 2 ]; then
    echo 'Downloading Google Talk Plugin...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    # Install the package
    echo 'Installing Google Talk Plugin...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-talkplugin_current*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Google Talk Plugin
elif [ $INPUT -eq 3 ]; then
    echo 'Downloading Google Music Manager...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_i386.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb
    fi
    # Install the package
    echo 'Installing Google Music Manager...'
    echo 'Requires root privileges:'
    sudo dpkg -i google-musicmanager-*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Steam
elif [ $INPUT -eq 4 ]; then
    echo 'Downloading Steam...'
    # Download Debian file that matches system architecture
    if [ $(uname -i) = 'i386' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    elif [ $(uname -i) = 'x86_64' ]; then
        wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    fi
    # Install the package
    echo 'Installing Steam...'
    echo 'Requires root privileges:'
    sudo dpkg -i steam*.deb
    sudo apt-get install -fy
    # Cleanup and finish
    rm *.deb
    cd
    echo 'Done.'
    thirdparty
# Unity Tweak Tool
elif [ $INPUT -eq 5 ]; then
    # Add repository
    echo 'Adding Unity Tweak Tool repository to sources...'
    echo 'Requires root privileges:'
    sudo add-apt-repository -y ppa:freyja-dev/unity-tweak-tool-daily
    # Update Repository Information
    echo 'Updating repository information...'
    sudo apt-get update -qq
    # Install the package
    echo 'Installing Unity Tweak Tool...'
    sudo apt-get install -y unity-tweak-tool
    echo 'Done.'
    thirdparty
# Return
elif [ $INPUT -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    thirdparty
fi
done
}

# CONFIG
function config {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Set preferred application-specific settings?'
echo '2. Show all startup applications?'
echo '3. Return'
echo ''
read INPUT
# GSettings
if [ $INPUT -eq 1 ]; then
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
    # Gedit Preferences
    echo 'Setting Gedit preferences...'
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 4
    # Rhythmbox Preferences
    echo 'Setting Rhythmbox preferences...'
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views 'artists-albums'
    gsettings set org.gnome.rhythmbox.sources visible-columns '['post-time', 'artist', 'duration', 'genre', 'album']'
    # Totem Preferences
    echo 'Setting Totem preferences...'
    gsettings set org.gnome.totem active-plugins '['save-file', 'media_player_keys', 'screenshot', 'chapters', 'ontop', 'screensaver', 'movie-properties', 'skipto']'
    config
# Startup Applications
elif [ $INPUT -eq 2 ]; then
    echo 'Changing display of startup applications.'
    echo 'Requires root privileges:'    
    cd /etc/xdg/autostart/ && sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo 'Done.'
    config
# Return
elif [ $INPUT -eq 3 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    config
fi
done
}

# CLEANUP SYSTEM
function cleanup {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo ''
echo '1. Remove unused pre-installed packages?'
echo '2. Remove old kernel(s)?'
echo '3. Remove orphaned packages?'
echo '4. Remove leftover configuration files?'
echo '5. Clean package cache?'
echo '6. Return?'
echo ''
read INPUT
# Remove Unused Pre-installed Packages
if [ $INPUT -eq 1 ]; then
    echo 'Removing selected pre-installed applications...'
    echo 'Requires root privileges:'
    sudo apt-get purge 
    echo 'Done.'
    cleanup
# Remove Old Kernel
elif [ $INPUT -eq 2 ]; then
    echo 'Removing old Kernel(s)...'
    echo 'Requires root privileges:'
    sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | grep -v linux-libc-dev | xargs sudo apt-get -y purge
    echo 'Done.'
    cleanup
# Remove Orphaned Packages
elif [ $INPUT -eq 3 ]; then
    echo 'Removing orphaned packages...'
    echo 'Requires root privileges:'
    sudo apt-get autoremove -y
    echo 'Done.'
    cleanup
# Remove residual config files?
elif [ $INPUT -eq 4 ]; then
    echo 'Removing leftover configuration files...'
    echo 'Requires root privileges:'
    sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep '^rc' | tr -s ' ' | cut -d ' ' -f 2)
    echo 'Done.'
# Clean Package Cache
elif [ $INPUT -eq 5 ]; then
    echo 'Cleaning package cache...'
    echo 'Requires root privileges:'
    sudo apt-get clean
    echo 'Done.'
    cleanup
# Return
elif [ $INPUT -eq 6 ]; then
    clear && main
else
# Invalid Choice
    echo 'Invalid, choose again.'
    cleanup
fi
done
}

# END
function end {
echo ''
read -p 'Are you sure you want to quit? (Y)es/(n)o '
if [ '$REPLY' == 'n' ]; then
    clear && main
else
    exit
fi
}

#----- MAIN FUNCTION -----#
function main {
INPUT=0
echo ''
echo 'What would you like to do? (Enter the number of your choice)'
echo ''
while [ true ]
do
echo '1. Perform system update & upgrade?'
echo '2. Install favourite applications?'
echo '3. Install favourite system tools?'
echo '4. Install extra GNOME components?'
echo '5. Install development tools?'
echo '6. Install Ubuntu Restricted Extras?'
echo '7. Install third-party applications?'
echo '8. Configure system?'
echo '9. Cleanup the system?'
echo '10. Quit?'
echo ''
read INPUT
# System Upgrade
if [ $INPUT -eq 1 ]; then
    clear && sysupgrade
# Install Favourite Applications
elif [ $INPUT -eq 2 ]; then
    clear && appinstall
# Install Favourite Tools
elif [ $INPUT -eq 3 ]; then
    clear && toolinstall
# Install GNOME components
elif [ $INPUT -eq 4 ]; then
    clear && gnomeextra
# Install Dev Tools
elif [ $INPUT -eq 5 ]; then
    clear && devinstall
# Install Ubuntu Restricted Extras
elif [ $INPUT -eq 6 ]; then
    clear && codecinstall
# Install Third-Party Applications
elif [ $INPUT -eq 7 ]; then
    clear && thirdparty
# Configure System
elif [ $INPUT -eq 8 ]; then
    clear && config
# Cleanup System
elif [ $INPUT -eq 9 ]; then
    clear && cleanup
# End
elif [ $INPUT -eq 10 ]; then
    end
else
# Invalid Choice
    echo 'Invalid, choose again.'
    main
fi
done
}

#----- RUN MAIN FUNCTION -----#
main

#END
