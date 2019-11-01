function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_wsl() {
    [[ "$(uname -r)" =~ microsoft ]] || return 1
}

if is_wsl && [ "$SHLVL" = 1 ]; then
    exec zsh
fi

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

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

for f in "$HOME/.extra.d/"*.sh; do
  . $f
done

export PATH="$HOME/.cargo/bin:$PATH"
