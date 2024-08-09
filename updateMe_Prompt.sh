#!/bin/bash
# this script is a simple prompt to tell users to update
# it is paired with a Launch Agent to run every 12 hours

#!/bin/bash

#this function can be used to check if any application is running before launching the pop-up. 
#replace "Zoom" with the app name
#zoomCheck=$(
#if (ps aux | grep Zoom | grep -v grep > /dev/null)
#then
#	echo RUNNING
#else
#	echo STOPPED
#fi
#)

#First, check if Zoom is running, if it is running, abort. 
zoomCheck=$(
if (ps aux | grep Zoom | grep -v grep > /dev/null)
then
	echo RUNNING
else
	echo STOPPED
fi
)

#If zoom is not running, continue with the pop-up
if [[ $zoomCheck = "STOPPED" ]]; then
	echo "Zoom not running... Proceed."

	result=$(osascript <<EOD
	set result to button returned of (display dialog "Your Mac is out of date. \n\nPlease update now!" with title "Your Mac is out of date!" with icon posix file "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/GenericNetworkIcon.icns" buttons {"Update Now","Later"} default button 1)
EOD
)

	echo $result
	if [[ $result = "Update Now" ]]; then
		echo "User Chose Update. Opening System Preferences."
		open x-apple.systempreferences:com.apple.Software-Update-Settings.extension
		
	else	
		echo "User chose to defer. Will try again in 12 hours."
		
	fi	
	
	exit 0
else 
	echo "Zoom running, exiting"

fi

