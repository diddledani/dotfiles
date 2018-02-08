if [ ! -z "$GREP_OPTIONS" ]; then
    alias grep="grep $GREP_OPTIONS"
    unset GREP_OPTIONS
fi
