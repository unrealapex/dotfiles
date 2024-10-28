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
	find -L "$HOME" -maxdepth 1 -type l -delete

build: /usr/local/bin/dwl /usr/local/bin/mew /usr/local/bin/wlock

~/.config/dwl:
	git clone https://git.sr.ht/~unrealapex/dwl ~/.config/dwl

~/.config/dwl/dwl: $(wildcard ~/.config/dwl/*.h) $(wildcard ~/.config/dwl/*.c) | ~/.config/dwl
	$(MAKE) -C ~/.config/dwl install

/usr/local/bin/dwl: ~/.config/dwl/dwl
	$(MAKE) -C ~/.config/dwl clean install

dwl: /usr/local/bin/dwl

~/.config/mew:
	git clone https://git.sr.ht/~unrealapex/mew ~/.config/mew

~/.config/mew/mew: $(wildcard ~/.config/mew/*.h) $(wildcard ~/.config/mew/*.c) | ~/.config/mew
	$(MAKE) -C ~/.config/mew install

/usr/local/bin/mew: ~/.config/mew/mew
	$(MAKE) -C ~/.config/mew clean install

mew: /usr/local/bin/mew

~/.config/wlock:
	git clone https://git.sr.ht/~unrealapex/wlock ~/.config/wlock

~/.config/wlock/wlock: $(wildcard ~/.config/wlock/*.h) $(wildcard ~/.config/wlock/*.c) | ~/.config/wlock
	$(MAKE) -C ~/.config/wlock install

/usr/local/bin/wlock: ~/.config/wlock/wlock
	$(MAKE) -C ~/.config/wlock clean install

wlock: /usr/local/bin/wlock

secrets: ~/.config/git/config.local

~/.config/git/config.local:
	cp -n ~/dotfiles/secrets/git.local ~/.config/git/config.local

done:
	@echo "Makefile targets completed!"

.PHONY: all create_dirs link clean build dwl mew wlock done

