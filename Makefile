.POSIX:

all: link build secrets done

ROOT := $(shell command -v doas || command -v sudo)


# TODO: handle XDG_CONFIG_HOME and XDG_DATA_HOME not being set

xdg-user-dirs:
	mkdir -p $(HOME)/Desktop $(HOME)/Documents $(HOME)/Downloads $(HOME)/Music $(HOME)/Pictures $(HOME)/Public $(HOME)/Templates $(HOME)/Videos

create_dirs: xdg-user-dirs
	mkdir -p $(HOME)/.local/bin $(XDG_DATA_HOME)/applications $(XDG_DATA_HOME)/themes $(XDG_DATA_HOME)/abook $(HOME)/projects $(HOME)/Pictures/Webcam $(HOME)/Pictures/Screenshots

link: create_dirs
	ln -sf $(realpath config)/* $(XDG_CONFIG_HOME)
	ln -sf $(realpath bin)/* $(HOME)/.local/bin
	ln -sf $(realpath gnupg)/* $(HOME)/.gnupg
	ln -sf $(realpath share/applications)/* $(XDG_DATA_HOME)/applications
	ln -sf $(realpath share/themes)/* $(XDG_DATA_HOME)/themes

clean:
	find -L $(HOME) -maxdepth 0 -type l -delete

build: /usr/local/bin/dwm /usr/local/bin/st /usr/local/bin/dmenu /usr/local/bin/slock

$(XDG_CONFIG_HOME)/dwm:
	git clone https://codeberg.org/unrealapex/dwm $(XDG_CONFIG_HOME)/dwm

$(XDG_CONFIG_HOME)/dwm/dwm: $(wildcard $(XDG_CONFIG_HOME)/dwm/*.h) $(wildcard $(XDG_CONFIG_HOME)/dwm/*.c) | $(XDG_CONFIG_HOME)/dwm
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/dwm install

/usr/local/bin/dwm: $(XDG_CONFIG_HOME)/dwm/dwm
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/dwm clean install

dwm: /usr/local/bin/dwm

$(XDG_CONFIG_HOME)/st:
	git clone https://codeberg.org/unrealapex/st $(XDG_CONFIG_HOME)/st

$(XDG_CONFIG_HOME)/st/st: $(wildcard $(XDG_CONFIG_HOME)/st/*.h) $(wildcard $(XDG_CONFIG_HOME)/st/*.c) | $(XDG_CONFIG_HOME)/st
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/st install

/usr/local/bin/st: $(XDG_CONFIG_HOME)/st/st
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/st clean install

st: /usr/local/bin/st

$(XDG_CONFIG_HOME)/dmenu:
	git clone https://codeberg.org/unrealapex/dmenu $(XDG_CONFIG_HOME)/dmenu

$(XDG_CONFIG_HOME)/dmenu/dmenu: $(wildcard $(XDG_CONFIG_HOME)/dmenu/*.h) $(wildcard $(XDG_CONFIG_HOME)/dmenu/*.c) | $(XDG_CONFIG_HOME)/dmenu
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/dmenu install

/usr/local/bin/dmenu: $(XDG_CONFIG_HOME)/dmenu/dmenu
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/dmenu clean install

dmenu: /usr/local/bin/dmenu

$(XDG_CONFIG_HOME)/slock:
	git clone https://codeberg.org/unrealapex/slock $(XDG_CONFIG_HOME)/slock

$(XDG_CONFIG_HOME)/slock/slock: $(wildcard $(XDG_CONFIG_HOME)/slock/*.h) $(wildcard $(XDG_CONFIG_HOME)/slock/*.c) | $(XDG_CONFIG_HOME)/slock
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/slock install

/usr/local/bin/slock: $(XDG_CONFIG_HOME)/slock/slock
	$(ROOT) $(MAKE) -C $(XDG_CONFIG_HOME)/slock clean install

slock: /usr/local/bin/slock

secrets: $(XDG_CONFIG_HOME)/git/config.local

$(XDG_CONFIG_HOME)/git/config.local:
	cp -n $(HOME)/dotfiles/secrets/git.local $(XDG_CONFIG_HOME)/git/config.local

done:
	@echo "Makefile targets completed!"

.PHONY: all create_dirs link clean build dwm st dmenu slock done

