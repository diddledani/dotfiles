if [ -d "$HOME/perl5" -a $SHLVL -eq 1 ]; then
	eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
fi
