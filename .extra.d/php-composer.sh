get_install php php-cli

if [ ! -x "$HOME/bin/composer" ];then
  composer_sigfile="$(mktemp)"
  fetch "https://composer.github.io/installer.sig" "$composer_sigfile"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

	EXPECTED_SIGNATURE="$(cat "$composer_sigfile")"
  ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

	if [ "$EXPECTED_SIGNATURE" = "$ACTUAL_SIGNATURE" ]; then
		php composer-setup.php --quiet --install-dir="$HOME/bin" --filename=composer
	fi
	rm composer-setup.php
fi

if [ ! -d "$HOME/.composer" ]; then
	mkdir "$HOME/.composer"
fi

export COMPOSER_HOME="$HOME/.composer"
export PATH="$HOME/.composer/vendor/bin:$PATH"

