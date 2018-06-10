Functions
=========

Instead of being consolidated into one huge file, this script set is modular and these functions are called through the project so they can be easily excluded or removed.

### General Functions

Contains frequently used functions.

 * [`add_repositories`](functions/add_repositories) is used for adding apt, flatpak and Launchpad PPA repositories.
 * [`check_functions`](functions/check_functions): contains the various functions that check the project prerequisites but also functions to check if packages are installed or if repositories have been added to the system.
 * [`echo_messages`](functions/echo_messages) is used for fancy coloured `echo` messages.
 * [`superuser_do`](functions/superuser_do) is used to prompt the user for their password and pass it to `sudo` to run commands as an admin user.

### Install Functions

Pretty self-explanatory, all the installation functions.

 * [`install_favs`](functions/install_favs) is used to install packages from the lists in [data](data). 
 * [`install_flatpak_apps`](functions/install_flatpak_apps) is used for installing flatpak apps.
 * [`install_fonts`](functions/install_fonts) is used for installing fonts.
 * [`install_functions`](functions/install_functions) contains generic functions for installing a single package, installing a remote package, installing a list of packages, or installing Snap or Flatpak packages, used throughout the other install scripts. 
 * [`install_gnome`](functions/install_gnome) is used for installing the GNOME desktop and various related software.
 * [`install_snap_apps`](functions/install_snap_apps) is used for installing Snap apps.
 * [`install_thirdparty`](functions/install_thirdparty) checks the [apps](functions/apps) folder for additional installation scripts for third-party apps.

### System Functions

A few basic maintenance and setup functions

 * [`system_cleanup`](functions/system_cleanup) has a few functions for basic cleanup of the system's package management.
 * [`system_configure`](functions/system_configure) contains functions used to a set your preferred settings.
 * [`system_update`](functions/system_update) is used to check for system and app updates.
