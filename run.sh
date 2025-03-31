#!/usr/bin/env bash

if [ "$(whoami)" == "root" ]; then
  echo "You need to be a regular user to run this script!"
  exit
fi 

compile_file() {
	cd "$1" || exit
	echo -e "\x1b[32m--------------------------------\x1b[0m"
	echo -e "\x1b[32mCompiling: $1\x1b[0m"
	echo -e "\x1b[32m--------------------------------\x1b[0m"

	sed -i "s/sha256sums=(.*/sha256sums=()/g" PKGBUILD
	sha=$(makepkg -g)
        sed -i "s/sha256sums=()/${sha}/g" PKGBUILD
 
	makepkg -si --noconfirm || exit
	makepkg --printsrcinfo > .SRCINFO || exit
	cd ../ || exit

	echo -e "\x1b[32m--------------------------------\x1b[0m"
	echo -e "\x1b[32mSuccessfully compiled $1!"
	echo -e "\x1b[32m--------------------------------\x1b[0m"
}

export -f compile_file

compile_file untitled-i18n
compile_file untitled-open
compile_file untitled-xdg-basedir
compile_file untitled-exec
compile_file untitled-cli-parser
compile_file untitled-dbus-utils

compile_file untitled-imgui-framework
compile_file ude-session-logout
compile_file untitled-game-system-manager
compile_file untitled-ibus-handwriting
