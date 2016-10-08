.PHONY: all help init

all: help

help:
	@echo "make init          #=> Run init scripts"
	@echo "make submodule     #=> Update submodule"
	@echo "make update        #=> Update symlink & submodule"

init:
	./etc/init/init.sh
	git submodule init

submodule:
	git submodule update

update: init submodule
