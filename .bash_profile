system_type=$(uname -s)
system_arch=$(uname -m)

function is_osx() {
    [ "$system_type" = "Darwin" ] && return 0 || return 1
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

. "$HOME/.cargo/env"
