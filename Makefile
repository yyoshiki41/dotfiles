all: help

help:
	@echo "make init                #=> Update symlink & submodule"
	@echo "make update-symlink      #=> Update symlink"
	@echo "make update-submodule    #=> Update submodule"

init: update-submodule update-symlink

update-symlink:
	@./etc/init/init.sh

update-submodule:
	git submodule init
	git submodule update
