#!/bin/sh

platex main.tex
dvipdfmx -r 2400 -z 0 main.dvi
#dvipdfmx main.dvi
#dvipdfmx -f msembed.map main

open -a Preview.app
