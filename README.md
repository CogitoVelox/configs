To install neovim (via https://medium.com/thelinux/the-correct-way-to-install-the-neovim-42f3076f9b88):
cd ~
wget https://github.com/neovim/neovim/releases/download/<version, e.g.: 'v0.9.5'>/nvim.appimage
chmod u+x nvim.appimage

Test the permissions:
./nvim.appimage

Move to appropriate folder
sudo mv nvim.appimage /usr/local/bin/nvim

May have to restart terminal or source the path.
