

source $HOME/.bash_aliases

# Marmalade SDK addition: please do not edit these lines
export PATH=$PATH:"/Applications/Marmalade.app/Contents/s3e/bin"
export S3E_DIR=/Applications/Marmalade.app/Contents/s3e
# Marmalade SDK addition: end

# The next line updates PATH for the Google Cloud SDK.
source '/opt/google-cloud-sdk/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/opt/google-cloud-sdk/google-cloud-sdk/completion.bash.inc'


eval "$(rbenv init -)"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
