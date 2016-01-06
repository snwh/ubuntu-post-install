Ubuntu Post Install Script
==========================

This project provides a set of shell scripts to be run after a fresh install of an Ubuntu(-based) OS. It will install your favourite applications, set your preferred settings, etc.

Feel free to copy, improve and distribute.

You can get the latest version from the original git repository:

    git clone https://github.com/snwh/ubuntu-post-install.git

##Usage:

Run from source folder:

    ./ubuntu-post-install-script.sh

Or if you like, add the script's location to your custom shell paths to run on-demand.

	export PATH=${PATH}:$HOME/whereever/ubuntu-post-install/

Note: The included [preferences](functions/configure) and [lists of packages](data) are those of the original author, you will have to change them to suit yourself.