if [ -x "/usr/bin/snap" ]; then
    if [ -z "$(snap list | grep '^heroku\s')" ]; then
        snap install heroku --classic
    fi
elif [ -x "/usr/local/bin/brew" ]; then
    if [ -z "$(brew list | grep '^heroku$')" ]; then
        brew install heroku/brew/heroku
    fi
fi
