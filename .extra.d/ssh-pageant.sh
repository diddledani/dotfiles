#!/bin/bash

if [ -x /usr/bin/ssh-pageant.exe ]; then
	eval $(/usr/bin/ssh-pageant.exe -r -a "/tmp/.ssh-pageant-$USERNAME")
fi
