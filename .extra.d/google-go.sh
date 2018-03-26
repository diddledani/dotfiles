if [ -x "/usr/bin/snap" ]; then
  if [ -z "$(snap list | grep '^go\s')" ]; then
    snap install go --classic
  fi
else
  get_install go
fi

if [ ! $(which go) -a ! -d "$HOME/bin/go" ]; then
  if [ "$(uname)" == "Linux" ]; then
    fetch_extract "https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz" "$HOME/bin"
  elif [ "$(uname)" == "Darwin" ]; then
    fetch_extract "https://dl.google.com/go/go1.9.4.darwin-amd64.tar.gz" "$HOME/bin"
  fi
fi

if [ -d "$HOME/bin/go/bin" ]; then
  export PATH="$HOME/bin/go/bin:$PATH"
fi

if [ -d "$HOME/Documents/go" ]; then
  export GOPATH="$HOME/Documents/go"
elif [ -d "$HOME/Development/go" ]; then
  export GOPATH="$HOME/Development/go"
fi

if [ -n "$GOPATH" ]; then
  export PATH="$GOPATH/bin:$PATH"
fi
