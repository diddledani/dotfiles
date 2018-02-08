if [ -x "/usr/local/bin/hub" ]; then
	eval "$(/usr/local/bin/hub alias -s)"
	if [ -f "/usr/local/etc/hub.bash_completion.sh" ]; then
		. /usr/local/etc/hub.bash_completion.sh
	fi
fi
