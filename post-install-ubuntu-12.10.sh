#!/bin/bash

#----------------------------------#
# UBUNTU 12.10 POST-INSTALL SCRIPT #
#----------------------------------#

echo ""
echo "#-------------------------------------------#"
echo "#     Ubuntu 12.10 Post-Install Script      #"
echo "#-------------------------------------------#"

#SYSTEM UPGRADE
function sysupgrade {
#Update Repository Information
echo "Updating repository information..."
echo "Requires root privileges:"
sudo apt-get update
#Dist-Upgrade
echo "Performing system upgrade..."
sudo apt-get dist-upgrade -y
echo "Done."
main
}

#INSTALL FAVOURITE APPLICATIONS
function appinstall {
#Install Favourite Applications
echo "Installing selected favourite applications..."
echo "Requires root privileges:"
sudo apt-get install -y bleachbit bzr cifs-utils cheese conky cups-pdf darktable dconf-tools easytag gimp gimp-plugin-registry grsync ia32-libs indicator-sync inkscape mtp-tools mtpfs mypaint nautilus-dropbox nautilus-open-terminal openjdk-7-jdk openssh-server p7zip-full ppa-purge pyrenamer quickly synaptic ubuntu-dev-tools ubuntu-restricted-extras xchat zsync
echo "Done."
main
}

#EXTRA INSTALLATION
function thirdparty {
INPUT=0
echo ""
echo "What would you like to do? (Enter the number of your choice)"
echo ""
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo "1. Install Google Chrome?"
echo "2. Install Google Talk Plugin?"
echo "3. Install latest graphics drivers?"
echo "4. Return"
echo ""
read INPUT
#Google Chrome
if [ $INPUT -eq 1 ]; then
    echo "Downloading Google Chrome..."
    mkdir -p $HOME/tmp
    cd $HOME/tmp
    if [ $(uname -i) = "i386" ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
    elif [ $(uname -i) = "x86_64" ]; then
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    fi
    echo "Requires root privileges:"
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    rm *.deb
    cd
    echo "Done."
    thirdparty
#Google Talk Plugin
elif [ $INPUT -eq 2 ]; then
    echo "Downloading Google Talk Plugin..."
    mkdir -p $HOME/tmp
    cd $HOME/tmp
    if [ $(uname -i) = "i386" ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_i386.deb
    elif [ $(uname -i) = "x86_64" ]; then
        wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
    fi
    echo "Requires root privileges:"
    sudo dpkg -i google*.deb
    sudo apt-get install -fy
    rm *.deb
    cd
    echo "Done."
    thirdparty
#X.org Edgers
elif [ $INPUT -eq 3 ]; then
    echo "Adding X.org git builds PPA to repositories..."
    echo "Requires root privileges:"
    sudo add-apt-repository ppa:xorg-edgers/ppa
    echo "Updating repository information..."
    sudo apt-get update 
    echo "Performing upgrade..."
    sudo apt-get dist-upgrade -y
    echo "Done."
    thirdparty
#Return
elif [ $INPUT -eq 4 ]; then
    clear && main
else
#Invalid Choice
    echo "Invalid choice. "
    thirdparty
fi
done
}

#CONFIG
function config {
INPUT=0
echo ""
echo "What would you like to do? (Enter the number of your choice)"
echo ""
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo "1. Show manual options at login?"
echo "2. Set preferred application-specific settings?"
echo "3. Show all startup applications?"
echo "4. Return"
echo ""
read INPUT
#Root Password
if [ $INPUT -eq 1 ]; then
    echo "Configuring LightDM to show manual login..."
    echo "Requires root privileges:"
    sudo sh -c 'echo "greeter-show-manual-login=true" >> /etc/lightdm/lightdm.conf'
    echo "Done."
    fi
    config
#GSettings
elif [ $INPUT -eq 2 ]; then
    #Font Sizes
    echo "Setting font preferences..."
    gsettings set org.gnome.desktop.interface text-scaling-factor "1.0"
    gsettings set org.gnome.desktop.interface document-font-name "Ubuntu 10"
    gsettings set org.gnome.desktop.interface font-name "Ubuntu 10"
    gsettings set org.gnome.desktop.interface monospace-font-name "Ubuntu Mono 11"
    gsettings set org.gnome.nautilus.desktop font "Ubuntu 10"
    gsettings set org.gnome.desktop.wm.preferences titlebar-font "Ubuntu Bold 10"
    gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing "rgba"
    gsettings set org.gnome.settings-daemon.plugins.xsettings hinting "slight"
    #Unity Settings
    echo "Setting Unity preferences..."
    gsettings set com.canonical.Unity.ApplicationsLens display-available-apps false
    gsettings set com.canonical.unity-greeter draw-user-backgrounds true 
    gsettings set com.canonical.indicator.power icon-policy "charge"
    gsettings set com.canonical.Unity.Lenses remote-content-search "none"
    #Nautilus Preferences
    echo "Setting Nautilus preferences..."
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    #Gedit Preferences
    echo "Setting Gedit preferences..."
    gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false
    gsettings set org.gnome.gedit.preferences.editor auto-save true
    gsettings set org.gnome.gedit.preferences.editor insert-spaces true
    gsettings set org.gnome.gedit.preferences.editor tabs-size 4
    #Rhythmbox Preferences
    echo "Setting Rhythmbox preferences..."
    gsettings set org.gnome.rhythmbox.rhythmdb monitor-library true
    gsettings set org.gnome.rhythmbox.sources browser-views "artists-albums"
    gsettings set org.gnome.rhythmbox.sources visible-columns "['post-time', 'artist', 'duration', 'genre', 'album']"
    #Totem Preferences
    echo "Setting Totem preferences..."
    gsettings set org.gnome.totem active-plugins "['save-file', 'media_player_keys', 'screenshot', 'chapters', 'ontop', 'screensaver', 'movie-properties', 'skipto']"
    #Gwibber Preferences
    echo "Setting Gwibber preferences..."
    gsettings set org.gwibber.preferences autostart true
    gsettings set org.gwibber.preferences interval "5"
    gsettings set org.gwibber.preferences notify-mentions-only false
    gsettings set org.gwibber.preferences show-notifications true
    echo "Done."
    config
#Startup Applications
elif [ $INPUT -eq 3 ]; then
    echo "Changing display of startup applications."
    cd /etc/xdg/autostart/
    echo "Requires root privileges:"
    sudo sed --in-place 's/NoDisplay=true/NoDisplay=false/g' *.desktop
    cd
    echo "Done."
    config
#Return
elif [ $INPUT -eq 4 ]; then
    clear && main
else
#Invalid Choice
    echo "Invalid choice."
    config
fi
done
}

#CLEANUP SYSTEM
function cleanup {
INPUT=0
echo ""
echo "What would you like to do? (Enter the number of your choice)"
echo ""
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo ""
echo "1. Remove unused pre-installed packages?"
echo "2. Remove old kernel(s)?"
echo "3. Remove orphaned packages?"
echo "4. Clean package cache?"
echo "5. Return?"
echo ""
read INPUT
#Remove Unused Pre-installed Packages
if [ $INPUT -eq 1 ]; then
    echo "Removing selected pre-installed applications..."
    echo "Requires root privileges:"
    sudo apt-get purge
    echo "Done."
    cleanup
#Remove Old Kernel
elif [ $INPUT -eq 2 ]; then
    echo "Removing old Kernel(s)..."
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
    echo "Done."
    cleanup
#Remove Orphaned Packages
elif [ $INPUT -eq 3 ]; then
    echo "Removing orphaned packages..."
    sudo apt-get autoremove -y
    echo "Done."
    cleanup
#Clean Package Cache
elif [ $INPUT -eq 4 ]; then
    echo "Cleaning package cache..."
    sudo apt-get clean
    echo "Done."
    cleanup
#Return
elif [ $INPUT -eq 5 ]; then
    clear && main
else
#Invalid Choice
    echo "Invalid choice. "
    cleanup
fi
done
}

#END
function end {
echo ""
read -p "Are you sure you want to quit? (Y/n) "
if [ "$REPLY" == "n" ]; then
    clear && main
else
    exit
fi
}

#MAIN FUNCTION
function main {
INPUT=0
echo ""
echo "What would you like to do? (Enter the number of your choice)"
echo ""
while [ $INPUT != 1 ] && [ $INPUT != 2 ] && [ $INPUT != 3 ]
do
echo "1. Perform system update & upgrade?"
echo "2. Install favourite applications?"
echo "3. Install third-party applications?"
echo "4. Configure system?"
echo "5. Cleanup the system?"
echo "6. Quit?"
echo ""
read INPUT
#System Upgrade
if [ $INPUT -eq 1 ]; then
    clear && sysupgrade
#Install Favourite Applications
elif [ $INPUT -eq 2 ]; then
    clear && appinstall
#Install Third-Party Applications
elif [ $INPUT -eq 3 ]; then
    clear && thirdparty
#Configure System
elif [ $INPUT -eq 4 ]; then
    clear && config
#Cleanup System
elif [ $INPUT -eq 5 ]; then
    clear && cleanup
#End
elif [ $INPUT -eq 6 ]; then
    end
else
#Invalid Choice
    echo "Invalid choice."
    main
fi
done
}

#CALL MAIN FUNCTION
main

#-----------------------------------------#
# END OF UBUNTU 12.10 POST-INSTALL SCRIPT #
#-----------------------------------------#
