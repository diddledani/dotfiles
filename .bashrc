source "$HOME/.bash_profile"

# For SDL-Hyperion
if [ -f $HOME/Development/herctest/herc4x/hyperion-init-bash.sh ]; then
    . $HOME/Development/herctest/herc4x/hyperion-init-bash.sh
fi

. "$HOME/.cargo/env"
