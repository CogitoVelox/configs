#!/bin/bash

sudo apt update
sudo apt install ripgrep npm fd-find -y
npm install -g tree-sitter-cli

if cat /proc/version | grep -iq 'wsl'; then
	wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
	unzip win32yank-x64.zip
	chmod +x win32yank.exe
	sudo mv win32yank.exe /usr/local/bin/
fi

echo "downloading lazygit"
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
echo "installing lazygit"
sudo install lazygit /usr/local/bin/

rm -rf lazygit lazygit.tar.gz LICENSE win32yank-x64.zip
