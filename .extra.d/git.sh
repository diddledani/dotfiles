if [ ! -x "$HOME/bin/hub" ]; then
	HUBURL=""
	if [ "$(uname)" == "Linux" ]; then
		HUBURL="https://github.com/github/hub/releases/download/v2.2.9/hub-linux-amd64-2.2.9.tgz"
	fi

	if [ -n "$HUBURL" ]; then
		curl -L -s -o /tmp/hub.tgz "$HUBURL"
		mkdir /tmp/hub
		tar zxf /tmp/hub.tgz -C /tmp/hub --strip-components=1
		install -m755 -D -t "$HOME/bin" /tmp/hub/bin/hub /tmp/hub/etc/*.sh
		install -m644 -D -t "$HOME/.man/man1" /tmp/hub/share/man/man1/hub.1
		rm -rf /tmp/hub.tgz /tmp/hub
	fi
fi

if [ -x "$HOME/bin/hub" ]; then
	eval "$($HOME/bin/hub alias -s)"
	if [ -f "$HOME/bin/hub.bash_completion.sh" ]; then
		. $HOME/bin/hub.bash_completion.sh
	fi
fi
