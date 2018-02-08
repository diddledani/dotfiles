if [ ! -d "$HOME/perl5" ]; then
	curl -L -s -o /tmp/local-lib.tgz http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/local-lib-2.000024.tar.gz
	tar zxf /tmp/local-lib.tgz -C /tmp
	pushd /tmp/local-lib
	perl Makefile.PL --bootstrap
	make test && make install
	popd
fi

eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
