[ ! -d "$HOME/Development/go" ] && mkdir -p "$HOME/Development/go/gopath"

export GOPATH="$HOME/Development/go/gopath"
export PATH="$GOPATH/bin:$PATH"

