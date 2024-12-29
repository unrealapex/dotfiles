all: link build secrets done

create_dirs:
	xdg-user-dirs-update
	mkdir -p ~/.local/share/themes ~/.local/share/abook ~/projects ~/Downloads/git ~/Pictures/Webcam ~/Pictures/Screenshots

link: create_dirs
	ln -sf $(realpath config)/* ~/.config/
	ln -sf $(realpath bin)/* /usr/local/bin/
	ln -sf $(realpath gnupg)/* ~/.gnupg/
	ln -sf $(realpath share/applications)/* ~/.local/share/applications
	ln -sf $(realpath share/themes)/* ~/.local/share/themes

clean:
	find -L $$HOME -maxdepth 1 -type l -delete

build: /usr/local/bin/dwm /usr/local/bin/st /usr/local/bin/dmenu /usr/local/bin/slock

~/.config/dwm:
	git clone https://codeberg.org/unrealapex/dwm ~/.config/dwm

~/.config/dwm/dwm: $(wildcard ~/.config/dwm/*.h) $(wildcard ~/.config/dwm/*.c) | ~/.config/dwm
	$(MAKE) -C ~/.config/dwm install

/usr/local/bin/dwm: ~/.config/dwm/dwm
	$(MAKE) -C ~/.config/dwm clean install

dwm: /usr/local/bin/dwm

~/.config/st:
	git clone https://codeberg.org/unrealapex/st ~/.config/st

~/.config/st/st: $(wildcard ~/.config/st/*.h) $(wildcard ~/.config/st/*.c) | ~/.config/st
	$(MAKE) -C ~/.config/st install

/usr/local/bin/st: ~/.config/st/st
	$(MAKE) -C ~/.config/st clean install

st: /usr/local/bin/st

~/.config/dmenu:
	git clone https://codeberg.org/unrealapex/dmenu ~/.config/dmenu

~/.config/dmenu/dmenu: $(wildcard ~/.config/dmenu/*.h) $(wildcard ~/.config/dmenu/*.c) | ~/.config/dmenu
	$(MAKE) -C ~/.config/dmenu install

/usr/local/bin/dmenu: ~/.config/dmenu/dmenu
	$(MAKE) -C ~/.config/dmenu clean install

dmenu: /usr/local/bin/dmenu

~/.config/slock:
	git clone https://codeberg.org/unrealapex/slock ~/.config/slock

~/.config/slock/slock: $(wildcard ~/.config/slock/*.h) $(wildcard ~/.config/slock/*.c) | ~/.config/slock
	$(MAKE) -C ~/.config/slock install

/usr/local/bin/slock: ~/.config/slock/slock
	$(MAKE) -C ~/.config/slock clean install

slock: /usr/local/bin/slock

secrets: ~/.config/git/config.local

~/.config/git/config.local:
	cp -n ~/dotfiles/secrets/git.local ~/.config/git/config.local

done:
	@echo "Makefile targets completed!"

.PHONY: all create_dirs link clean build dwm st dmenu slock done

