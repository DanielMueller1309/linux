#tmux

#### Reloading tmux config
If you have made changes to your tmux configuration file in the ~/.tmux.conf file, it shouldn’t be necessary to start the server up again from scratch with kill-server. Instead, you can prompt the current tmux session to reload the configuration with the source-file command.

This can be done either from within tmux, by pressing Ctrl+B and then : to bring up a command prompt, and typing:

> :source-file ~/.tmux.conf

Or simply from a shell:

> $ tmux source-file ~/.tmux.conf

This should apply your changes to the running tmux server without affecting the sessions or windows within them.




#### Autostart Tmux Session On Remote System When Logging In Via SSH
To autostart Tmux session when connecting via SSH, edit your remote system's ~/.bash_profile file:

> $ nano ~/.bash_profile

If the file is not available, just create it.

And add the following lines in it:
```
if [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
```

Save and close the file. Log out and log back into the remote systems. You will be landed into a new Tmux session named ___default___.

durch ein
```
attach
```
am ende einer tmux eingabe, sei es nun in der ___tmux.conf___ oder der bash-shell bzw eines scripts.
- Beispiel Script:
  > tmux new-session -d -s 0 \\; \\
    split-window -h 'htop' \\; \\
    split-window -p 88 \\; \\
    split-window -p 50 \\; \\
    attach


keybind + q : zeigt nummern der panes an




### Everything you need to know about Tmux copy paste - Ubuntu

####Know about copy buffers

When you do a `CTRL+c`, the stuff you copy is stored in your computer's buffer, called ‘clipboard’ from where you can paste anywhere by doing a `CTRL+v`. Tmux has it's own buffer for coppying, which we'll call ‘tmux buffer’. Our goal is to understand in a Tmux session how to copy to tmux buffer, and also to clipboard.

You can always copy stuff into clipboard while usin Tmux. “Why do I need a Tmux buffer then”, you might wonder. This is because, in your shell, the text you want to select might not fit in your current screen (e.g. output of cat /etc/passwd file). If you copy normally, you will only be able to copy text visible on your screen, and not the output which is ‘scrolled up’ due to a lot of output.

#### Tmux copy-paste - the defaults
The defaults are slighly involved, so this section is purely for informational purposes, and shouldn't be memorized. Skipping this section is perfectly okay.

Enter ‘copy mode’ by pressing `keybind + [`
Use the arrow keys to go to the position from where you want to start copying. Press `CTRL+SPACE` to start copying.
Use arrow keys to go to the end of text you want to copy. Press `ALT+w` or `CTRL+w` to copy into Tmux buffer.
Press `keybind + ]` to paste in a possibly different Tmux pane/window.

#### Tmux Vim-bindings for copying into tmux buffer
Adding configuration described in this section will give you easier shortcuts for copy-pasting in Tmux. Moreover, these shortcuts work very similar to Vim's copy-pasting shortcuts!

Add these lines in a file by name ~/.tmux.conf.
```
 bind P paste-buffer
 bind-key -t vi-copy 'v' begin-selection
 bind-key -t vi-copy 'y' copy-selection
 bind-key -t vi-copy 'r' rectangle-toggle
```

Note that for a newer tmux version (2.4 and above I think, not sure), the last three lines should be replaced with:
```
 bind-key -T copy-mode-vi v send-keys -X begin-selection
 bind-key -T copy-mode-vi y send-keys -X copy-selection
 bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
```

Now you can enter copy mode by pressing `keybind + [`, and then go to start point, press `v` and start copying. After you have selected text you want to copy, you can just press `y` (or the default ‘enter’ key) to copy the text into Tmux's buffer. This is exactly the commands you would use in Vim to copy text.

To paste, press `keybind + P`. Note that it's capital `P` (i.e. `SHIFT+p`). This again is similar to Vim's shortcut ‘p’ for paste, though not exactly similar. You'll realize in your Tmux journey why didn't we use a small ‘p’ instead of a capital ‘P’ ;)

### Copy from tmux buffer to system buffer (clipboard)
For this to happen, you need to install xclip on your computer. Do it as:

> sudo apt-get install --assume-yes xclip

After that, you need to add this line in ~/.tmux.conf file:

`bind -t vi-copy y copy-pipe "xclip -sel clip -i"`

Now close all your tmux sessions. From now onwards, whatever you copy in Tmux buffer will also land into system clipboard.

#### Tmux copy with mouse drag!
You can enable ‘mouse mode’, using which you can copy text into tmux buffer by mouse drag. For doing that, you just need to add this line to your ~/.tmux.conf file:
```
setw -g mode-mouse on
set -g mouse-select-window on
```
Note that if your tmux version is 2.1 or above, you need to include the following line instead of the above two

`set -g mouse on`

But now I can't do normal copy-paste with mouse!
You'll notice that now all your selections will go to tmux buffer, and not clipboard buffer. Of course, you can enable copying to system clipboard as described in a section above. However, you can notice that you can't double click to select a complete word with vi's tmux copy-pasting shortcuts + mouse option enabled.

Just press SHIFT button when copying, and now you can copy as if Tmux doesn't exist! :)

#### Copy from a remote server
Install xclip on the remote Ubuntu/Linux server, and add the line mentioned above (`bind -t vi-copy y copy-pipe "xclip -sel clip -i"`) to ~/.tmux.conf on that server. Also, pass -X option when making SSH connection to the server, like so:

> ssh -X remoteuser@remotehost

And after that everything you copy into remote's Tmux buffer will get copied over to local clipboard. Magic!


Quelle:https://www.rushiagr.com/blog/2016/06/16/everything-you-need-to-know-about-tmux-copy-pasting-ubuntu/
https://www.rockyourcode.com/copy-and-paste-in-tmux/




### Tmux 2.4+ with vi copy mode bindings and xclip:

```
set-option -g mouse on
set-option -s set-clipboard off
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -se c -i"
```
For older tmux versions, emacs copy mode bindings (the default), or non-X platforms (i.e., no xclip), see the explanation below.

Explanation: First we need to enable the mouse option so tmux will capture the mouse and let us bind mouse events:

`set-option -g mouse on`
Gnome-terminal doesn't support setting the clipboard using xterm escape sequences so we should ensure the set-clipboard option is off:

`set-option -s set-clipboard off`
This option might be supported and enabled by default on iTerm2 (see set-clipboard in the tmux manual), which would explain the behavior on there.

We can then bind the copy mode `MouseDragEnd1Pane` "key", i.e., when the first mouse button is released after clicking and dragging in a pane, to a tmux command which takes the current copy mode selection (made by the default binding for `MouseDrag1Pane`) and pipes it to a shell command. This tmux command was `copy-pipe` before tmux 2.4, and has since changed to `send-keys -X copy-pipe[-and-cancel]`. As for the shell command, we simply need something which will set the contents of the system clipboard to whatever is piped to it; xclip is used to do this in the following commands.
Some equivalent replacements for `'xclip -selection clipboard -i'`
- on non-X platforms are `'wl-copy'`(Wayland)
`'pbcopy'` (macOS)
`'clip.exe'` (Windows, WSL)
- `'cat /dev/clipboard'` (Cygwin, MinGW)

### Tmux 2.4+:

##### For vi copy mode bindings
`bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard -i'`
##### For emacs copy mode bindings
`bind-key -T copy-mode MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard -i'`

###Tmux 2.2 to 2.4:

##### For vi copy mode bindings
`bind-key -t vi-copy MouseDragEnd1Pane copy-pipe 'xclip -selection clipboard -i'`
##### For emacs copy mode bindings
`bind-key -t emacs-copy MouseDragEnd1Pane copy-pipe 'xclip -selection clipboard -i'`


###Before tmux 2.2:
Copy after mouse drag support was originally added in Tmux 1.3 through setting the new mode-mouse option to on. Tmux 2.1 changed the mouse support to the familiar mouse key bindings, but did not have DragEnd bindings, which were introduced in 2.2. Thus, before 2.2 I believe the only method of setting the system clipboard on mouse drag was through the built-in use of xterm escape sequences (the set-clipboard option). This means that it's necessary to update to at least tmux 2.2 to obtain the drag-and-copy behavior for terminals that don't support set-clipboard, such as GNOME Terminal.
Quelle: https://unix.stackexchange.com/questions/348913/copy-selection-to-a-clipboard-in-tmux
