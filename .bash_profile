function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] && return 0 || return 1
}
function is_wsl() {
    [ -n "$WSL_DISTRO_NAME" ] && return 0 || return 1
}

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
#source ~/bin/git-completion.bash
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/bin/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

export PS1='\n🎳🎩 \[\e[0;36m\]\[\e[0;36m\] \W\[\033[0;35m\]$(__git_ps1 " (%s)")\[\e[0m\] \$ '

# colours for `ls` command
# https://github.com/jonathf/gls
#alias ls='gls'
if is_osx; then
    alias ls="command ls -G"
    #if type brew 2&>/dev/null; then
    #  for completion_file in $(brew --prefix)/etc/bash_completion.d/*; do
    #    source "$completion_file"
    #  done
    #fi
else
    alias ls="command ls --color"
fi

alias vi=vim
export EDITOR=vim

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

for f in "$HOME/.extra.d/"*.sh; do
  . $f
done


eval "$(direnv hook bash)"

if is_wsl; then
	#####
	## Autorun for the gpg-relay bridge
	##
	SOCAT_PID_FILE=$HOME/.gnupg/socat-gpg.pid
    SOCAT_PID_FILE2=$HOME/.gnupg/socat-gpg.pid.2

    relayexe="$(wslpath 'C:/Users/yabea/AppData/Roaming/wsl2-ssh-gpg-agent-relay.exe')"
    for sock in "$HOME/.gnupg/S.gpg-agent" "/run/user/$UID/gnupg/S.gpg-agent"; do
        if ! ss -a | grep -q $sock; then
            rm -f "$sock"
            mkdir -p "$(dirname "$sock")"
            setsid --fork socat UNIX-LISTEN:"$sock,fork" EXEC:"$relayexe -ei -ep -s -a 'C:/Users/yabea/AppData/Roaming/gnupg/S.gpg-agent'",nofork
        fi
    done
    unset sock

    export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
    if ! ss -a | grep -q $SSH_AUTH_SOCK; then
        rm -f $SSH_AUTH_SOCK
        setsid --fork socat UNIX-LISTEN:"$SSH_AUTH_SOCK,fork" EXEC:"$relayexe -ei -ep -s //./pipe/openssh-ssh-agent",nofork
    fi
fi 

. "$HOME/.cargo/env"
