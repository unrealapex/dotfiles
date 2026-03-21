#!/bin/sh

config_home=${XDG_CONFIG_HOME:-~/.config}
data_home=${XDG_DATA_HOME:-~/.local/share}
bin_dir=~/.local/bin

install() {
	link
	secrets
	finished
}

xdg_user_dirs() {
	mkdir -p "$HOME"/Desktop "$HOME"/Documents "$HOME"/Downloads \
		"$HOME"/Music "$HOME"/Pictures "$HOME"/Public "$HOME"/Templates \
		"$HOME"/Videos "$bin_dir"
}

create_dirs() {
	xdg_user_dirs
	mkdir -p "$data_home"/applications "$data_home"/themes \
		"$data_home"/abook "$HOME"/projects "$HOME"/Pictures/Webcam \
		"$HOME"/Pictures/Screenshots "$bin_dir"
}

link() {
	create_dirs
	ln -sf "$PWD"/config/* "$config_home"
	ln -sf "$PWD"/gnupg/* "$HOME"/.gnupg
	ln -sf "$PWD"/share/applications/* "$data_home"/applications
	ln -sf "$PWD"/share/themes/* "$data_home"/themes
	ln -sf "$PWD"/bin/* "$bin_dir"
	ln -sf "$PWD"/exrc "$HOME"/.exrc
	ln -sf "$PWD"/sakura.png "$HOME"/Pictures/sakura.png
}

clean() {
	find "$config_home" "$HOME"/.local/bin "$HOME"/.gnupg \
		"$data_home"/themes -type l -delete
}

secrets() {
	secret_gitconfig="$config_home"/git/config.local
	secret_msmtpconfig="$config_home"/msmtp/config
	[ ! -f "$secret_gitconfig" ] && cp -n secrets/gitconfig.local \
		"$secret_gitconfig"
	[ ! -f "$secret_msmtpconfig" ] && cp -n secrets/msmtp.config.local \
		"$secret_msmtpconfig"
}

finished() {
	echo "$0: finished"
}

help() {
	printf "%s\n%s\n" \
		"make.sh install" \
		"make.sh [xdg_user_dirs|create_dirs|link|clean|secrets]"
}

main() {
	case "$1" in
	install | all)
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
	secrets)
		secrets
		;;
	*)
		help
		;;
	esac
}

main "$@"
