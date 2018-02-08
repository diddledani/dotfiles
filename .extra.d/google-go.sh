if [ -x /usr/local/go/bin/go ]; then
  export PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME/Documents/go" ]; then
  export GOPATH="$HOME/Documents/go"
elif [ -d "$HOME/Development/go" ]; then
  export GOPATH="$HOME/Development/go"
fi

[ -n "$GOPATH" ] && export PATH="$GOPATH/bin:$PATH"
