if [ -x "/usr/local/bin/brew" ]; then
#	if [ ! $(brew list | grep '^rbenv$') ]; then
#		brew install rbenv
#	fi
    true
elif [ ! -d "$HOME/.rbenv/bin" ]; then
	git clone https://github.com/rbenv/rbenv.git "$HOME/.rbenv"
	pushd "$HOME/.rbenv"
	src/configure && make -C src
	popd
fi

if [ -d "$HOME/.rbenv" ]; then
	export PATH="$HOME/.rbenv/bin:$PATH"
fi

eval "$(rbenv init -)"
