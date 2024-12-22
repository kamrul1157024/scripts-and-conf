#!/bin/bash

# ----------sync tmux--------
cp -f ./tmux-conf/tmux.conf ~/.tmux.conf
# ----------------------------

#-----------sync lazyvim------
rm -rf ~/.config/nvim/
rsync -avz ./lazyvim-conf/* ~/.config/nvim
#------------------------------
