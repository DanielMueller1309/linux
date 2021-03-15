#!/bin/bash

apt update
apt install tmux  htop mc qemu-guest-agent net-tools -y
echo alias ll=\'ls -lahF\' >> ~/.bash_aliases
rm update_tmux.sh
wget -P ~/ https://raw.githubusercontent.com/DanielMueller1309/linux_startup_repo/master/update_tmux.sh
bash update_tmux.sh
rm update_tmux_test_branch.sh
wget -P ~/ https://raw.githubusercontent.com/DanielMueller1309/linux_startup_repo/master/update_tmux_test_branch.sh
tmux new-session -d -s 0 \; \
  split-window -h 'htop' \; \
  split-window -p 88 \; \
  split-window -p 50 \; \
  attach
tmux new-session -d -s upgrade 'apt upgrade'
