function port_mount() {
	if ! mount | grep /opt/local/var/macports/build 2>&1 > /dev/null; then
		echo -n "Enter RAM Disk size in megabytes: "
		read size
		size=$(echo "$size * 2048" | bc)
		dev=$(hdiutil attach -nomount ram://$size)
		newfs_hfs $dev
		/usr/bin/sudo mount -t hfs $dev /opt/local/var/macports/build
	fi
	/usr/bin/sudo /opt/local/bin/port $@
}

alias port=port_mount

#!/bin/bash

[ -d /usr/local/emsdk_portable ] && source /usr/local/emsdk_portable/emsdk_env.sh

BANGDIR=~/bang
export BANGDIR

[ -x /usr/bin/vi ] && export EDITOR=/usr/bin/vi

if ls --color=auto >/dev/null 2>&1; then
	alias ls='ls --color=auto'
	alias la='ls --color=auto -a'
	alias ll='ls --color=auto -a -l'
else
	alias ls='ls -G'
	alias la='ls -G -a'
	alias ll='ls -G -a -l'
fi

if [ -d "/Applications/Sublime Text.app" ]; then
	alias sublime="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
fi
alias log=$BANGDIR/scripts/wordpress/log
alias ec2=$BANGDIR/scripts/ec2/ec2

export JAVA_HOME=/usr
#export AWS_AUTO_SCALING_HOME=~/Applications/AutoScaling
[ -d /usr/local/Cellar/elb-tools ] && export AWS_ELB_HOME="/usr/local/Cellar/elb-tools/1.0.34.0/libexec"
[ -d /usr/local/Cellar/ec2-api-tools ] && export EC2_HOME="/usr/local/Cellar/ec2-api-tools/$(ls /usr/local/Cellar/ec2-api-tools/ | tail -n1)/libexec"

export BANG_AWS_CREDENTIAL_FILE=~/.ssh/bang-aws.creds
export MINE_AWS_CREDENTIAL_FILE=~/.ssh/my-aws.creds
export BOWLHAT_AWS_CREDENTIAL_FILE=~/.ssh/bowlhat-aws.creds
#export EC2_REGION=eu-west-1

#export PATH="$JAVA_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$PATH"
#export PATH="$HOME/Applications/android-sdk-linux/platform-tools:$PATH"

export PATH="$PATH:/usr/local/lib/aws-eb"

[ -f "$BANGDIR/scripts/cluster/cluster_completion.sh" ] && . $BANGDIR/scripts/cluster/cluster_completion.sh
[ -f "$BANGDIR/scripts/gcomm/vm/gcomm_completion.sh" ] && . $BANGDIR/scripts/gcomm/vm/gcomm_completion.sh
[ -f "$HOME/.azure-completion.sh" ] && . $HOME/.azure-completion.sh

[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
[ -d "$HOME/.composer" ] && export PATH="$HOME/.composer/vendor/bin:$PATH"

export DEBFULLNAME="Daniel Llewellyn"
export DEBEMAIL="dan@bang-on.net"

#export CD_COMPLETION_EXTRA_DIRS="/data $HOME/bang"
#source ~/bang/scripts/bash/cd-to-sourcecode.sh
export CDPATH=".:/data:$BANGDIR:~"

function cluster {
	OLDWD="$(pwd)"
	cd $BANGDIR/drbd;
	./cluster $@
	cd "$OLDWD"
}
function gcomm {
	OLDWD="$(pwd)"
	cd $BANGDIR/scripts/gcomm/vm
	./gcomm $@
	cd "$OLDWD"
}

[ -d "$HOME/perl5" ] && [ $SHLVL -eq 1 ] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"


alias add="git add"
alias push="git push"
alias pull="git pull"
alias status="git status"
alias commit="git commit"
alias checkout="git checkout"
function diff {
	git status 2> /dev/null > /dev/null
	[ $? = 0 ] && git diff $@ || /usr/bin/diff $@
}
function cd {
	builtin cd "$@" > /dev/null
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

function_exists()
{
    type $1 2>&1 | grep -q 'shell function'
}

[ -d /Applications ] && for i in /Applications/Xcode*.app; do
	j="$i/Contents/Developer/usr/share/git-core"
	[ -e "$j/git-completion.bash" ] && source $j/git-completion.bash
	[ -e "$j/git-prompt.sh" ] && source $j/git-prompt.sh
done

if [ "$color_prompt" = yes ]; then
	if [ "$(id -u)" == 0 ]; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u \[\033[38;5;208m\]\h \[\033[01;34m\]\w$(__git_ps1 " \[\033[1;35m\]⎇  %s") \[\033[01;31m\]\$\[\033[00m\] '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u \[\033[38;5;208m\]\h \[\033[01;34m\]\w$(__git_ps1 " \[\033[1;35m\]⎇  %s") \[\033[01;32m\]\$\[\033[00m\] '
	fi
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# MySQL prompt
MY_HOSTNAME=$(hostname)
alias mysql="$(echo -e "mysql --prompt='\001\033[1;32m\002\\u \001\033[38;5;208m\002$MY_HOSTNAME \001\033[1;36m\002⛁ \\d \001\033[1;32m\002> \001\033[0m\002'")"

# PostgreSQL prompt
export PGDATABASE=postgres
#export PAGER="grcat ~/.grcat"
[ -f ~/.psqlrc ] || (echo "
\set PROMPT1 '%[%033[01;32m%]%n %[%033[38;5;208m%]$MY_HOSTNAME %[%033[01;31m%]%x%[%033[36m%]%[%033[1m%]⛁ %/ %[%033[01;32m%]%R %[%033[0m%]'
\set PROMPT2 '%[%033[01;32m%]%n %[%033[38;5;208m%]$MY_HOSTNAME %[%033[01;31m%]%x%[%033[36m%]%[%033[1m%]⛁ %/ %[%033[01;32m%]%R %[%033[0m%]'
\set PROMPT3 '%[%033[01;32m%]%n %[%033[38;5;208m%]$MY_HOSTNAME %[%033[01;31m%]%x%[%033[36m%]%[%033[1m%]⛁ %/ %[%033[01;32m%]%R %[%033[0m%]'
\pset format aligned
\pset linestyle unicode
\pset null '(null)'
" | tee ~/.psqlrc 2>&1 > /dev/null)
