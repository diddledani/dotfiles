function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
source ~/bin/git-completion.bash
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
source ~/bin/git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWCOLORHINTS=true

export PS1='🎳🎩 🔹\[\e[0;36m\]\[\e[0;36m\] \W\[\033[0;35m\]$(__git_ps1 " (%s)")\[\e[0m\]: '
# colours for `ls` command
# https://github.com/jonathf/gls
#alias ls='gls'
if is_osx; then
  alias ls="command ls -G"
else
  alias ls="command ls --color"
fi
