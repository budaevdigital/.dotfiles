#!/bin/bash
set -e

MY_HOSTNAME=tools

# Предварительно установить - https://flathub.org/repo/flathub.flatpakrepo
# Для настройки Flat менеджера пакетов

# Установка hostname машины
sudo hostnamectl set-hostname $MY_HOSTNAME

echo "==============================================="
echo "Обновление пакетного менеджера"
echo "==============================================="

sudo dnf -y upgrade --refresh
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf &&
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf &&
echo 'keepcache=1' | sudo tee -a /etc/dnf/dnf.conf

sudo dnf -y autoremove && sudo dnf clean all
sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo flatpak remote-add --if-not-exists fedora oci+https://registry.fedoraproject.org


echo "==============================================="
echo "Установка драйверов для NVIDIA и мультимедиа"
echo "==============================================="

sudo dnf -y groupupdate core
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
sudo dnf groupupdate sound-and-video
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel 
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia
sudo dnf -y install akmod-nvidia
sudo dnf -y install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-power nvidia-settings
sudo dnf -y install xorg-x11-drv-nvidia-cuda


echo "==============================================="
echo "Установка дополнительных программных пакетов"
echo "==============================================="
# Дополнительный пакетный менеджер
sudo dnf -y install dnfdragora
# Кастомизация интерфейса Gnome
sudo dnf -y install gnome-tweak-tool
sudo dnf -y install gnome-shell-extension
# Для очистки мусора и ненужных файлов
sudo dnf -y install bleachbit
# Дополнительные пакеты для мониторинга системы
sudo dnf -y install neofetch htop

# Установка VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf -y update
sudo dnf -y install code

# Установка терминала
sudo dnf -y install terminator
# Пакет для ведения заметок
sudo flatpak -y install md.obsidian.Obsidian
# Пакет для настройки Grub при загрузки системы
sudo dnf -y install grub-customizer
# Пакет для облачного гейминга
sudo flatpak -y install flathub io.github.hmlendea.geforcenow-electron


echo "==============================================="
echo "Дополнительная проверка обновлений"
echo "==============================================="
sudo dnf check-update
