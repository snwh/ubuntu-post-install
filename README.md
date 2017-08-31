Ubuntu Post Install Scripts
===========================

An interactive set of post-installation and maintenance scripts for Ubuntu. They're designed to install your favourite applications, set your preferred settings, etc. mostly automatically.

This project is free software; you can redistribute it and/or modify it under the terms of the [GNU General Public License](/LICENSE).

Do feel free to contribute back to this original, potential improvements are appreciated.

 > This project's settings adjustments, app lists and functions are tuned to the [original author's](https://github.com/snwh) preferences, I suggest maintaining a fork of this project with changes to those to adjust it to your liking. 


## Structure

This project is coded and organized in a modular fashion so you can easily delete or exclude parts that you don't want to use.

 * [`data`](/data): this folder contains files which are lists of packages read by various functions. *You should to update these lists to suit your preferences*.
 * [`functions`](/functions): this folder contains the main functions of this scriptset. They should require little user-preference modification.
 * [`apps`](/functions/apps): this sub-directory contains all functions for the installation of third-party applications &ndash;those that aren't necessarily in the main repositories. You can add/remove these as you like.

## Adding Functions

You can add more functions to install additional third-party apps by easily editing one of the many already included functions, as they are written pretty generically, you need only change the variables. Though there is a generic [template](/functions/apps/function_template_ppa) readily available for adding PPA functions.

When you do add (or remove) functions be sure to update the main [`thirdparty`](/functions/thirdparty) function to reflect those changes, else the script will fail.

## Usage

You use these scripts, you can just run the main script from the root of the source folder:

    ./ubuntu-post-install-script.sh

Or you can add the location of this project to your custom shell paths to run it on-demand. For example, adding it as the following line to your `.bashrc` (editing the path appropriately):

    export PATH=${PATH}:~/ubuntu-post-install/
