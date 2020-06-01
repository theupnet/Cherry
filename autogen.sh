#!/bin/sh

if ! test -f configure.ac; then
  printf 'You must execute this script from the top level directory.\n' >&2
  exit 1
fi

dump_help_screen() {
  printf 'Usage: %s [options]\n' "$0"
  printf '\n' 
  printf 'options:\n'
  printf '  -n           skip CVS changelog creation\n'
  printf '  -h,--help    show this help screen\n'
  printf '\n'
  exit
}

parse_options() {
  while [ $# -gt 0 ]; do
    case $1 in
    -h|--help)
      dump_help_screen
      ;;
    -n)
      export SKIP_CVS_CHANGELOG=yes
      ;;
    *)
      printf 'Invalid argument - %s\n' "$1" >&2
      dump_help_screen
    esac

    shift
  done
}

run_or_die() {
  if [ $# -eq 0 ]; then
    printf '*warning* no command specified\n' >&2
    exit 1
  fi

  printf '*info* running %s' "$1"

  if [ $# -gt 1 ]; then (
    shift
    printf ' (%s)' "$*"
  ); fi

  printf '\n'

  if ! "$@"; then
    printf '*error* %s failed. (exit code = %d)\n' "$1" "$?" >&2
    exit 1
  fi
}

last_dir=$PWD
autoconf=${AUTOCONF:-autoconf}
aclocal=${ACLOCAL:-aclocal}
automake=${AUTOMAKE:-automake}
autoheader=${AUTOHEADER:-autoheader}
libtoolize=${LIBTOOLIZE:-libtoolize}

parse_options "$@"

printf 'Building librb autotools files.\n'

if ! cd librb; then
  printf 'Could not change to %s/librb\n' "$PWD"
  exit 1
fi

sh autogen.sh
printf 'Building main autotools files.\n'

if ! cd "$last_dir"; then
  printf 'Could not change to %s\n' "$PWD"
  exit 1
fi

run_or_die "$aclocal" -I m4
run_or_die "$libtoolize" --force --copy
run_or_die "$autoheader"
run_or_die "$autoconf"
run_or_die "$automake" --add-missing --copy
