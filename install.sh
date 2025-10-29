#!/bin/bash
set -e

packages=(
    git 
    neovim
    flatpak
    fastfetch
    xfce4-power-manager
    lxappearance
    firefox
    papirus-icon-theme
    picom 
    polybar 
    ttf-jetbrains-mono
    ttf-jetbrains-mono-nerd 
    alacritty
    pcmanfm 
    rofi 
    xwallpaper
)
sudo pacman -Syu --needed --noconfirm "${packages[@]}"

#installing yay
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

#themes 
yay -S catppuccin-gtk-theme-mocha
yay -S nordic-theme

#clone configs 
# Check if script is run from the dotfiles directory
if [ ! -d ".git" ]; then
    echo "Error: This script must be run from your cloned dotfiles repository!"
    echo "Usage: cd ~/dotfiles && ./install.sh"
    exit 1
fi

echo "Installing dotfiles..."

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Copy config files
cp -r ./.config/i3 "$HOME/$USER/.config/" 2>/dev/null && echo "✓ i3 config installed"
cp -r ./.config/polybar "$HOME/$USER/.config/" 2>/dev/null && echo "✓ polybar config installed"
cp -r ./.config/rofi "$HOME/$USER/.config/" 2>/dev/null && echo "✓ rofi config installed"
cp -r ./.config/alacritty "$HOME/$USER/.config/" 2>/dev/null && echo "✓ alacritty config installed"
cp -r ./.config/picom "$HOME/$USER/.config/" 2>/dev/null && echo "✓ picom config installed"

echo ""
echo "Done, Reload i3 with Mod+Shift+R"

#install spotify and mod it 
flatpak install flathub com.spotify.Client
flatpak run com.spotify.Client
curl -sSL https://spotx-official.github.io/run.sh
