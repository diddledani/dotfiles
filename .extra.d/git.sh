if [ -x "/usr/local/bin/hub" ]; then
	alias git=/usr/local/bin/hub
	if [ -f "/usr/local/etc/hub.bash_completion.sh" ]; then
		. /usr/local/etc/hub.bash_completion.sh
	fi
fi
