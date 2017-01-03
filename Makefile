.PHONY: all help init

all: help

help:
	@echo "make init          #=> Run init scripts"
	@echo "make submodule     #=> Update submodule"
	@echo "make update        #=> Update symlink & submodule"
	@echo "make rm-drepo      #=> Remove ~/.vim/dein/repos/github.com"

init:
	./etc/init/init.sh
	git submodule init

submodule:
	git submodule update

update: init submodule

rm-drepo:
	rm -rf ~/.vim/dein/repos/github.com
