#!/bin/bash
#
# accept user passwords and pass them to another command that requires superuser privilege

function superuser_do() {
	echo_message header "Starting 'superuser_do' function"
	# check if current user is root
	if [[ $EUID = 0 ]]; then
		echo_message warning "You are logged in as the root user. Again, this is not recommended. :/"
		# Running command without sudo
		$@
	else
		# check sudo uptime to see if a password is needed
		if [ $(sudo -n uptime 2>&1 | grep 'a password is required' | wc -l) != 0 ]; then
			echo_message warning 'Admin privileges required.'
			# Draw window
			PASSWORD=$(whiptail --title "Password Required" --passwordbox "\nRequires admin privileges to continue. \n\nPlease enter your password:\n" 12 48 3>&1 1>&2 2>&3)
			if [ $? = 0 ]; then
				# while loop for sudo attempts
				COUNT=0
				MAXCOUNT=3
				while [ $COUNT -lt $MAXCOUNT ]; do
					# check if sudo command fails
					if [[ $(sudo -S <<< "$PASSWORD" echo) -ne 0 ]]; then
						echo_message warning "Incorrect password."
						# Prompt for password again
						PASSWORD=$(whiptail --title "Password Error" --passwordbox "\nThe password you provided was not correct.\n\nPlease enter your password again:\n" 12 48 3>&1 1>&2 2>&3)
						# Abort if user cancels
						if [ $? = 1 ]; then
							# Error message if user cancels
							echo_message error "Password prompt cancelled. Aborting..."
							main
						fi
						# Increase the count
						let COUNT=COUNT+1
						# Error message if too many attempts
						if [[ "$COUNT" -eq "$MAXCOUNT" ]]; then
							echo_message error "Too many failed password attempts. Aborting..."
							whiptail --msgbox "Too many failed password attempts. Please try again." --title "Oops" 8 56
							main
						fi
					else
						# pass the command to sudo
						sudo ${@}
						break
					fi
				done
			else
				# Error message if user cancels
				echo_message error "Password prompt cancelled. Aborting..."
				whiptail --msgbox "Password is required to proceed. Please try again." --title "Oops" 8 56
				main
			fi
		else
			echo_message info "Admin privileges not required at this time."
			# pass the command to sudo
			sudo $@
		fi
	fi
}