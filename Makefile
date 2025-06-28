.POSIX:

all: link build secrets done

ROOTCOMMAND := $(shell command -v doas || command -v sudo)


# TODO: handle XDG_CONFIG_HOME and XDG_DATA_HOME not being set

xdg-user-dirs:
	mkdir -p $(HOME)/Desktop $(HOME)/Documents $(HOME)/Downloads $(HOME)/Music $(HOME)/Pictures $(HOME)/Public $(HOME)/Templates $(HOME)/Videos

create_dirs: xdg-user-dirs
	mkdir -p $(XDG_DATA_HOME)/applications $(XDG_DATA_HOME)/themes $(XDG_DATA_HOME)/abook $(HOME)/projects $(HOME)/Pictures/Webcam $(HOME)/Pictures/Screenshots

link: create_dirs
	ln -sf $(PWD)/config/* $(XDG_CONFIG_HOME)
	ln -sf $(PWD)/gnupg/* $(HOME)/.gnupg
	ln -sf $(PWD)/share/applications/* $(XDG_DATA_HOME)/applications
	ln -sf $(PWD)/share/themes/* $(XDG_DATA_HOME)/themes
	ln -sf $(PWD)/nexrc $(HOME)/.nexrc

clean:
	find $(XDG_CONFIG_HOME) $(HOME)/.local/bin $(HOME)/.gnupg $(XDG_DATA_HOME)/themes -type l -delete

build: /usr/local/bin/dwl /usr/local/bin/mew /usr/local/bin/wlock

$(XDG_CONFIG_HOME)/dwl:
	git clone https://codeberg.org/unrealapex/dwl $(XDG_CONFIG_HOME)/dwl

$(XDG_CONFIG_HOME)/dwl/dwl: $(wildcard $(XDG_CONFIG_HOME)/dwl/*.h) $(wildcard $(XDG_CONFIG_HOME)/dwl/*.c) | $(XDG_CONFIG_HOME)/dwl
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/dwl install

/usr/local/bin/dwl: $(XDG_CONFIG_HOME)/dwl/dwl
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/dwl clean install

dwl: /usr/local/bin/dwl

$(XDG_CONFIG_HOME)/mew:
	git clone https://codeberg.org/unrealapex/mew $(XDG_CONFIG_HOME)/mew

$(XDG_CONFIG_HOME)/mew/mew: $(wildcard $(XDG_CONFIG_HOME)/mew/*.h) $(wildcard $(XDG_CONFIG_HOME)/mew/*.c) | $(XDG_CONFIG_HOME)/mew
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/mew install

/usr/local/bin/mew: $(XDG_CONFIG_HOME)/mew/mew
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/mew clean install

mew: /usr/local/bin/mew

$(XDG_CONFIG_HOME)/wlock:
	git clone https://codeberg.org/unrealapex/wlock $(XDG_CONFIG_HOME)/wlock

$(XDG_CONFIG_HOME)/wlock/wlock: $(wildcard $(XDG_CONFIG_HOME)/wlock/*.h) $(wildcard $(XDG_CONFIG_HOME)/wlock/*.c) | $(XDG_CONFIG_HOME)/wlock
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/wlock install

/usr/local/bin/wlock: $(XDG_CONFIG_HOME)/wlock/wlock
	$(ROOTCOMMAND) $(MAKE) -C $(XDG_CONFIG_HOME)/wlock clean install

wlock: /usr/local/bin/wlock

secrets: $(XDG_CONFIG_HOME)/git/config.local

$(XDG_CONFIG_HOME)/git/config.local:
	cp -n $(HOME)/dotfiles/secrets/gitconfig.local $(XDG_CONFIG_HOME)/git/config.local

done:
	@echo "Makefile targets completed!"

.PHONY: all create_dirs link clean build dwl mew wlock done

