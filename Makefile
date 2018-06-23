###
# notes.txt makefile
###

SHELL = /bin/sh

INSTALL = /usr/bin/install
INSTALL_DIR = /usr/local/bin

install:
	mkdir -p $(INSTALL_DIR)
	$(INSTALL) notes.sh $(INSTALL_DIR)/notes.sh

uninstall:
	rm -f $(INSTALL_DIR)/notes.sh
