
#!/bin/bash 

#This script creates the LaunchAgent for the updateMe script
# The default time is 12 hours, or 43200 seconds, this can be changed if desired

function get_user {
	/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'
}
currentuser=$(get_user)
echo $currentuser

echo "<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="1.0">
	<dict>
	<key>Label</key>
	<string>com.checkincheckerprompt</string>
	<key>ProgramArguments</key>
	<array>
	<string>/bin/sh</string> 
	<string>/private/var/tmp/updateMe/updateMe.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>StartInterval</key>
	<integer>43200</integer> 
	</dict>
	</plist>" > ~/Library/LaunchAgents/com.updateMe.plist

sudo chown root:wheel /Users/$currentuser/Library/LaunchAgents/com.updateMe.plist
sudo chmod 755 /Users/$currentuser/Library/LaunchAgents/com.updateMe.plist

uid=$(echo $UID)
launchctl load /Users/$currentuser/Library/LaunchAgents/com.updateMe.plist
launchctl enable gui/$uid/com.updateMe.plist
launchctl kickstart -kp gui/com.updateMe.plist
