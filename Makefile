.PHONY: all help init

all: help

help:
	@echo "make init          #=> Run init scripts"

init:
	./etc/init/init.sh
