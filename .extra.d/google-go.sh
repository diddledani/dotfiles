if [ -x "/usr/bin/snap" ]; then
  if [ -z "$(snap list | grep '^go\s')" ]; then
    snap install go --classic
  fi
elif [ -x "/usr/local/bin/brew" ]; then
  if [ -z "$(brew list | grep '^go$')" ]; then
    brew install go
  fi
elif [ ! -d "$HOME/bin/go" -a "$(uname)" == "Linux" ]; then
  curl -L -s -o /tmp/golang.tgz "https://dl.google.com/go/go1.9.4.linux-amd64.tar.gz"
  tar zxf /tmp/golang.tgz -C "$HOME/bin"
  rm /tmp/golang.tgz
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
