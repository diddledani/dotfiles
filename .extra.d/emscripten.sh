if [ ! -d "$HOME/bin/emsdk-portable" ]; then
  get_install cmake
  get_install node nodejs
  get_install curl

  curl -L -s -o /tmp/emscripten.tgz "https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz"

  if [ ! -d "$HOME/bin/emsdk-portable" -a -f /tmp/emscripten.tgz ]; then
    tar zxf /tmp/emscripten.tgz -C "$HOME/bin"
  fi

  if [ -d "$HOME/bin/emsdk-portable" ]; then
    pushd "$HOME/bin/emsdk-portable"
    ./emsdk update
    ./emsdk install latest
    ./emsdk update latest
    popd
  fi
fi

if [ -f "$HOME/bin/emsdk-portable/emsdk_env.sh" ]; then
    . "$HOME/bin/emsdk-portable/emsdk_env.sh" > /dev/null
fi
