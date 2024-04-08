# Based off of the 💤 LazyVim Template

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

# INSTALLING NEOVIM

To install neovim (via https://medium.com/thelinux/the-correct-way-to-install-the-neovim-42f3076f9b88): 

`cd ~`

`wget https://github.com/neovim/neovim/releases/download/<version, e.g.: 'v0.9.5'>/nvim.appimage`

`chmod u+x nvim.appimage`

Test the permissions: 
`./nvim.appimage`

Move to appropriate folder 
`sudo mv nvim.appimage /usr/local/bin/nvim`

May have to restart terminal or source the path.

# SETTING UP XDG

Append to ~/.bashrc:

`export XDG_CONFIG_HOME="$HOME/.config"`
`export XDG_CACHE_HOME="$HOME/.cache"`
`export XDG_DATA_HOME="$HOME/.local/share"`
`export TMUX_CONF="$HOME/.config/tmux/tmux.conf"`

# SETTING UP WINDOWS CLIPBOARD

`wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip`

`unzip win32yank-x64.zip`

`chmod +x win32yank.exe`

`sudo mv win32yank.exe /usr/local/bin/`

The rest of the setup is in clipboard.lua

# SETTING UP ICONS
Download a NerdFont from here and install _on Windows_ and set as terminal default:
https://www.nerdfonts.com/font-downloads
