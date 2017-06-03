Ubuntu Post Install Scripts
===========================

Original Author: [Sam Hewitt](https://github.com/snwh)

> This project is my set of post-installation and maintenance scripts for Ubuntu, to run on a fresh install. It's designed to install your favourite applications, set your preferred settings, etc. mostly automatically. 

Feel free to fork this project, modify to suit your preference, and distribute.

## Structure

This project is coded and organized in a modular fashion so you can easily delete or exclude parts that you don't want to use.

 * [`data`](/data): this folder contains files which are lists of packages read by various functions. It's recommended to update these to suit your preferences.
 * [`functions`](/functions): this folder contains bash files which are the main functions of this scriptset. They should require little modification.
 * [`third-party`](/functions/third-party): this sub-directory contains further bash files that are functions for the installation of third-party applications &ndash;i.e. those that aren't necessarily in the main repositories.

## Usage

Simple, you just run the main script from the root of the source folder:

    ./ubuntu-post-install-script.sh

Or you can store this scriptset in some directory, and add that location to your custom shell paths to run on-demand. For example, adding it as the following line to your `.bashrc` (editing the path appropriately):

    export PATH=${PATH}:$HOME/scripts/ubuntu-post-install/
