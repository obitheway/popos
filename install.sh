#!/bin/bash
set -euo pipefail
# Update repo and repository after initial build
sudo apt update && sudo apt upgrade -y
# Install some apt apps
sudo apt install nextcloud-client caffeine virt-manager transmission nfs-common net-tools neovim flameshot rustc cargo git nmap wireshark sshfs snap ruby-full bundler rake -y
# Install Brave Browser
curl -fsS https://dl.brave.com/install.sh | sudo bash
# Install ProtonVPN
wget https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.8_all.deb
echo "0b14e71586b22e498eb20926c48c7b434b751149b1f2af9902ef1cfe6b03e180  protonvpn-stable-release_1.0.8_all.deb" | sha256sum --check -
sudo dpkg -i ./protonvpn-stable-release_1.0.8_all.deb && sudo apt update
sudo apt install proton-vpn-gnome-desktop -y
sudo apt install libayatana-appindicator3-1 gir1.2-ayatanaappindicator3-0.1 gnome-shell-extension-appindicator -y
# Install Steam when done
sudo apt install steam -y
# Install Lazygit
echo 'deb http://download.opensuse.org/repositories/home:/clayrisser:/bookworm/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:clayrisser:bookworm.list
curl -fsSL https://download.opensuse.org/repositories/home:clayrisser:bookworm/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_clayrisser_bookworm.gpg >/dev/null
sudo apt update
sudo apt install ghostty -y
# Install Signal-Desktop
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor >signal-desktop-keyring.gpg
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg >/dev/null
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' |
  sudo tee /etc/apt/sources.list.d/signal-xenial.list
sudo apt update && sudo apt install signal-desktop -y
# Ruby installs
gem install debug
# Mount Network Drive
sudo mkdir /mnt/knox/
sudo mount -t nfs 192.168.114.240:/mnt/Knox/media /mnt/knox/
# Snap Install
sudo snap install ghostty obsidian
# Get .dotfiles
mkdir -p ~/dev && cd ~/dev
git clone https://github.com/obitheway/nvim.git
git clone https://github.com/obitheway/obsidian.git
git clone https://github.com/obitheway/ghostty.git
git clone https://github.com/obitheway/bash.git
git clone https://github.com/obitheway/aura-dark.git
rm -rf ~/.config/nvim
cp -r ~/dev/nvim ~/.config/
cp -r ~/dev/obsidian ~
rm -rf ~/.config/ghostty/
cp -r ~/dev/ghostty ~/.config
cp -r ~/dev/bash/.bashrc ~
cp -r ~/dev/aura-dark ~
