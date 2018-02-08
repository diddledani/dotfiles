if [ ! -d "$HOME/bin/emsdk-portable" ]; then
    if [ ! $(which cmake) ]; then
        if [ "$(uname)" == "Linux" ]; then
            true
        elif [ -x "/usr/local/bin/brew" ]; then
            if [ ! $(brew list | grep '^cmake$') ]; then
                brew install cmake
            fi
        fi
    fi

    if [ ! $(which node) ]; then
        if [ "$(uname)" == "Linux" ]; then
            true
        elif [ -x "/usr/local/bin/brew" ]; then
            if [ ! "$(brew list | grep '^cmake$')" ]; then
                brew install node
            fi
        fi
    fi

    curl -L -s -o /tmp/emscripten.tgz "https://s3.amazonaws.com/mozilla-games/emscripten/releases/emsdk-portable.tar.gz"
    tar zxf /tmp/emscripten.tgz -C "$HOME/bin"
    pushd "$HOME/bin/emsdk-portable"
    ./emsdk update
    ./emsdk install latest
    ./emsdk update latest
    popd
fi

if [ -d "$HOME/bin/emsdk-portable" ]; then
    . "$HOME/bin/emsdk-portable/emsdk_env.sh" > /dev/null
fi
