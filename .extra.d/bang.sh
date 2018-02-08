BANGDIR="$HOME/Documents/git"
export BANGDIR

alias log="$BANGDIR/scripts/wordpress/log"
alias ec2="$BANGDIR/scripts/ec2/ec2"

if [ -f "$BANGDIR/scripts/cluster/cluster_completion.sh" ]; then
	source "$BANGDIR/scripts/cluster/cluster_completion.sh"
fi
if [ -f "$BANGDIR/scripts/gcomm/vm/gcomm_completion.sh" ]; then
	source "$BANGDIR/scripts/gcomm/vm/gcomm_completion.sh"
fi

function cluster {
	OLDWD="$(pwd)"
	pushd "$BANGDIR/drbd"
	./cluster "$@"
	popd
}

function gcomm {
	OLDWD="$(pwd)"
	pushd "$BANGDIR/scripts/gcomm/vm"
	./gcomm "$@"
	popd
}
