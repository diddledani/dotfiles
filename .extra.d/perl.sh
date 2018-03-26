if [ ! -d "$HOME/perl5" ]; then
	fetch_extract http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/local-lib-2.000024.tar.gz /tmp
	pushd /tmp/local-lib-2.000024
	perl Makefile.PL --bootstrap
	make test && make install
	popd
fi

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
