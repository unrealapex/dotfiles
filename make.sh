#!/bin/sh

config_home=${XDG_CONFIG_HOME:-~/.config}
data_home=${XDG_DATA_HOME:-~/.local/share}

install() {
	link
	install_vis_plugins
	secrets
	finished
}

xdg_user_dirs()  {
	mkdir -p "$HOME"/Desktop "$HOME"/Documents "$HOME"/Downloads "$HOME"/Music "$HOME"/Pictures "$HOME"/Public "$HOME"/Templates "$HOME"/Videos
}


create_dirs() {
	xdg_user_dirs
	mkdir -p "$data_home"/applications "$data_home"/themes "$data_home"/abook "$HOME"/projects "$HOME"/Pictures/Webcam "$HOME"/Pictures/Screenshots
}

link() {
	create_dirs
	ln -sf "$PWD"/config/* "$config_home"
	ln -sf "$PWD"/gnupg/* "$HOME"/.gnupg
	ln -sf "$PWD"/share/applications/* "$data_home"/applications
	ln -sf "$PWD"/share/themes/* "$data_home"/themes
	ln -sf "$PWD"/exrc "$HOME"/.exrc
}

clean() {
	find "$config_home" "$HOME"/.local/bin "$HOME"/.gnupg "$data_home"/themes -type l -delete
}


install_vis_plugins() {
	git submodule init
	git submodule update
}

secrets() {
	secrets_file="$config_home"/git/config.local
	 [ ! -f "$secrets_file" ] && cp -n "$HOME"/dotfiles/secrets/gitconfig.local "$secrets_file"
}

finished() {
	echo "$0: finished"
}

help() {
	printf "make.sh install\nmake.sh [xdg_user_dirs|create_dirs|link|clean|install_vis_plugins|secrets]\n"
}

main() {
	case "$1" in
		install)
			install
			;;
		xdg_user_dirs)
			xdg_user_dirs
			;;
		create_dirs)
			create_dirs
			;;
		link)
			link
			;;
		clean)
			clean
			;;
		install_vis_plugins)
			install_vis_plugins
			;;
		secrets)
			secrets
			;;
		*)
			help
		;;
	esac
}

main "$@"
