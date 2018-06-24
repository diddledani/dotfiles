#export GPG_TTY=$(tty)
#
#if [ -f "${HOME}/.gpg-agent-info" ]; then
#	. "${HOME}/.gpg-agent-info"
#elif [ -f "${HOME}/.gnupg/gpg-agent-info" ]; then
#	. "${HOME}/.gnupg/gpg-agent-info"
#elif [ -e "/run/user/$(id -u)/gnupg/S.gpg-agent.ssh" ]; then
#  SSH_AUTH_SOCK="/run/user/$(id -u)/gnupg/S.gpg-agent.ssh"
#fi
#
#export GPG_AGENT_INFO
#export SSH_AUTH_SOCK
