#!/bin/bash
set -e

# Предварительно установить - https://flathub.org/repo/flathub.flatpakrepo
# Для настройки Flat менеджера пакетов

MY_HOSTNAME=tools

# Установка hostname машины
sudo hostnamectl set-hostname $MY_HOSTNAME


echo "==============================================="
echo "Обновление пакетного менеджера"
echo "==============================================="

sudo dnf upgrade --refresh -y
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf &&
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf &&
echo 'keepcache=1' | sudo tee -a /etc/dnf/dnf.conf

sudo dnf autoremove && sudo dnf clean all
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org


echo "==============================================="
echo "Установка драйверов для NVIDIA и мультимедиа"
echo "==============================================="

sudo dnf groupupdate core -y
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel 
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
sudo dnf install akmod-nvidia
sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-power nvidia-settings
sudo dnf install xorg-x11-drv-nvidia-cuda


echo "==============================================="
echo "Установка дополнительных программных пакетов"
echo "==============================================="

sudo dnf install dnfdragora
sudo dnf install gnome-tweak-tool
sudo dnf install gnome-shell-extension
sudo dnf install bleachbit
sudo dnf install neofetch htop

# установка VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y update
sudo dnf -y install code

sudo dnf -y install terminator
sudo flatpak install md.obsidian.Obsidian
sudo dnf install grub-customizer
sudo flatpak install flathub io.github.hmlendea.geforcenow-electron


echo "==============================================="
echo "Дополнительная проверка обновлений"
echo "==============================================="
sudo dnf check-update
