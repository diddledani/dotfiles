get_install() {
  binary="$1"
  [ -n "$2" ] && package="$2" || package="$1"

  if [ ! $(which $binary) ]; then
    if [ "$(uname)" = "Linux" ]; then
      if [ $(which apt-get) ]; then
        sudo apt-get install -yyq $package
      fi
    elif [ $(which brew) ]; then
      if [ ! "$(brew list | grep "^$package\$")" ]; then
        brew install $package
      fi
    fi
  fi
}

fetch() {
  get_install curl
  curl -L -s -o "$2" "$1"
}

fetch_extract() {
  extension="$(echo "$1" | awk -F'[.]' '{print $(NF-1)"."$NF}')"
  if [ "$(echo $extension | cut -d. -f1)" != "tar" ]; then
    extension="$(echo "$1" | awk -F'[.]' '{print $NF}')"
  fi

  tmpfile="$(mktemp).$extension"
  fetch "$1" "$tmpfile"
  case "$extension" in
    "tar.gz")
      tar zxf "$tmpfile" -C "$2"
      ;;
    "tar.bz2")
      tar jxf "$tmpfile" -C "$2"
      ;;
    "tar.xz")
      tar Jxf "$tmpfile" -C "$2"
      ;;
    "zip")
      get_install unzip
      pushdir "$2"
      unzip e "$tmpfile"
      popdir
      ;;
    *)
  esac

  rm "$tmpfile"
}

