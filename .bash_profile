

source $HOME/.bash_aliases

if [ -d /opt/google-cloud-sdk ]; then
# The next line updates PATH for the Google Cloud SDK.
source '/opt/google-cloud-sdk/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/opt/google-cloud-sdk/google-cloud-sdk/completion.bash.inc'
fi

[ `which rbenv` ] && eval "$(rbenv init -)" || echo "rbenv not available."

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
