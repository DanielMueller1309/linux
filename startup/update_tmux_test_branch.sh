#!/bin/bash
rm ~/.tmux.conf
wget -P ~/ https://raw.githubusercontent.com/DanielMueller1309/pentesting/tmux/Programme/tmux/.tmux.conf
tmux source-file ~/.tmux.conf
