# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
system_type=$(uname -s)
system_arch=$(uname -m)

function is_osx() {
    [ "$system_type" = "Darwin" ] && return 0 || return 1
}
function is_wsl() {
    [ -n "$WSL_DISTRO_NAME" ] && return 0 || return 1
}

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.zsh-custom


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(composer dirhistory docker docker-compose dotenv gem git github golang grunt gulp kubectl npm per-directory-history rbenv svn virtualenv vscode wp-cli xcode yarn zsh-syntax-highlighting zsh-history-substring-search zsh-autosuggestions)

setopt HIST_IGNORE_ALL_DUPS

# User configuration

DEFAULT_USER=dani

export COMPOSER_HOME="$HOME/.composer"

if is_osx; then
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/homebrew/bin/brew ]; then
        eval "$(/usr/local/homebrew/bin/brew shellenv)"
    fi

    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

    export HAXE_STD_PATH="$(brew --prefix)/lib/haxe/std"
    export NEKOPATH="$(brew --prefix)/lib/neko"

    if [ -f "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc" ]; then
        source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
    fi
fi

# export MANPATH="/usr/local/man:$MANPATH"
export GOPATH="$HOME/Development/go/gopath"

if [ ! -d "$HOME/.wsl-cmds" ]; then
    mkdir -p "$HOME/.wsl-cmds"
fi

if is_wsl; then
    for sock in "$HOME/.gnupg/S.gpg-agent" "/run/user/$UID/gnupg/S.gpg-agent"; do
        rm -f "$sock"
    done
    unset sock
    rm -f "$HOME/.ssh/agent.sock"

    if command -v wslpath >/dev/null && command -v wslvar >/dev/null; then
        [ -x "$HOME/.wsl-cmds/gpg" ] || ln -sf "$(wslpath "$(wslvar 'ProgramFiles(x86)')/GnuPG/bin/gpg.exe")" "$HOME/.wsl-cmds/gpg"

        [ -x "$HOME/.wsl-cmds/scp" ] || ln -sf "$(wslpath "$(wslvar 'SystemRoot')/System32/OpenSSH/scp.exe")" "$HOME/.wsl-cmds/scp"
        [ -x "$HOME/.wsl-cmds/sftp" ] || ln -sf "$(wslpath "$(wslvar 'SystemRoot')/System32/OpenSSH/sftp.exe")" "$HOME/.wsl-cmds/sftp"
        [ -x "$HOME/.wsl-cmds/ssh" ] || ln -sf "$(wslpath "$(wslvar 'SystemRoot')/System32/OpenSSH/ssh.exe")" "$HOME/.wsl-cmds/ssh"
        [ -x "$HOME/.wsl-cmds/ssh-add" ] || ln -sf "$(wslpath "$(wslvar 'SystemRoot')/System32/OpenSSH/ssh-add.exe")" "$HOME/.wsl-cmds/ssh-add"
    fi
fi

path+=("$COMPOSER_HOME/vendor/bin")
path+=("$HOME/.npm-packages/bin")
path+=("$HOME/.pub-cache/bin")
path+=("$GOPATH/bin")
path+=("$HOME/bin")
path+=("$HOME/bin/flutter/bin")
path+=(/usr/local/sbin)
path+=(/usr/bin/watcom/binl64)

path=("$HOME/.wsl-cmds" $path)

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export DEBFULLNAME="Dani Llewellyn"
export DEBEMAIL="diddledani@ubuntu.com"

# export the new PATH
export PATH

if [ -f $HOME/Development/herctest/herc4x/hyperion-init-bash.sh ]; then
    . $HOME/Development/herctest/herc4x/hyperion-init-bash.sh
fi

export WATCOM=/usr/bin/watcom

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias srb="snapcraft remote-build --launchpad-accept-public-upload"

eval "$(direnv hook zsh)"
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  prompt_context
  prompt_dir
  prompt_git
#  prompt_bzr
  prompt_hg
  prompt_end
}

source $ZSH/oh-my-zsh.sh

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^ ' autosuggest-accept

