if [ ! -x "$HOME/bin/composer" ];then
	EXPECTED_SIGNATURE="$(curl -L -s https://composer.github.io/installer.sig)"
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	ACTUAL_SIGNATURE="$(php -r "echo hash_file('SHA384', 'composer-setup.php');")"

	if [ "$EXPECTED_SIGNATURE" == "$ACTUAL_SIGNATURE" ]; then
		php composer-setup.php --quiet --install-dir=$HOME/bin --filename=composer
	fi
	rm composer-setup.php
fi

if [ ! -d "$HOME/.composer" ]; then
	mkdir "$HOME/.composer"
fi

export COMPOSER_HOME="$HOME/.composer"
export PATH="$HOME/.composer/vendor/bin:$PATH"
