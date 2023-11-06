#!/bin/bash

# ----------sync tmux--------
cp -f ./tmux-conf/tmux.conf ~/.tmux.conf
# ----------------------------

#-----------sync lazyvim------
rsync -zvh ./lazyvim-conf/* ~/.config/nvim
#------------------------------

