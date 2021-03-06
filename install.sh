#!/bin/bash
#
# Installs the dot files.

cd $(dirname $0)

set -e

function ok {
  read -p "$1" -n 1 -r
  echo
  case $REPLY in
    y|Y)
      return 0 ;;
    *)
      return 1 ;;
  esac
}

function run {
  echo "$@"
  "$@"
}

function install {
  local SRC=$1
  local DST=$2

  if [ -e "$DST" ]; then
    if ! colordiff -U10 "$DST" "$SRC"; then
      if ! ok "$DST has changes! Continue? "; then
        return 0
      fi
    fi
  fi

  run ln -sf "$SRC" "$DST"
}

install $PWD/bash/bash_logout ~/.bash_logout
install $PWD/bash/bash_profile ~/.bash_profile
install $PWD/bash/bashrc ~/.bashrc
install $PWD/bash/colors ~/.colors

install $PWD/X/Xdefaults ~/.Xdefaults
install $PWD/X/xsession ~/.xsession

install $PWD/emacs/emacs ~/.emacs

mkdir -p ~/.i3
install $PWD/i3/config ~/.i3/config
install $PWD/i3/i3status.conf ~/.i3status.conf
