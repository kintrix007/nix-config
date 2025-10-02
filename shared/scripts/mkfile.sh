DIR="$(dirname "$1")"

if [[ -z $1 ]]; then
  >&2 echo "error: Expected filepath."
  exit 1
fi

if [[ "$DIR" != "." ]]; then
  if ! [[ -e "$DIR" ]]; then
    mkdir -p "$DIR"
  fi
fi

touch "$1"
