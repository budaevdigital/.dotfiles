#!/bin/bash
DOT_DIR_FILE_HOME=~/.dotfiles-master
DOT_DIR_FILE_HOME_ZIP=~/.dotfiles-master.zip
ISBASHRC=$1
FIRSTSTARTFEDORA=$2
CONFIGTERMINAL=$3
REMOTHERFILES=$4

LINK_IN_BASHRC_FILE=("#.bashrc\n\n
source $DOT_DIR_FILE_HOME/bash/.shells/.export\n
source $DOT_DIR_FILE_HOME/bash/.shells/.defaults\n
source $DOT_DIR_FILE_HOME/bash/.shells/.functions\n
source $DOT_DIR_FILE_HOME/bash/.shells/.alias\n
source $DOT_DIR_FILE_HOME/bash/.shells/.prompt")

if [[ ! -d $DOT_DIR_FILE_HOME ]]; then
  wget https://github.com/budaevdigital/.dotfiles/archive/master.zip -O $DOT_DIR_FILE_HOME_ZIP
  mkdir $DOT_DIR_FILE_HOME
  unzip $DOT_DIR_FILE_HOME_ZIP -d ~/
  rm $DOT_DIR_FILE_HOME_ZIP
else
  rm -r $DOT_DIR_FILE_HOME
  wget https://github.com/budaevdigital/.dotfiles/archive/master.zip -O $DOT_DIR_FILE_HOME_ZIP
  mkdir $DOT_DIR_FILE_HOME
  unzip $DOT_DIR_FILE_HOME_ZIP -d ~/
  rm $DOT_DIR_FILE_HOME_ZIP    
fi


# Удаляет bashrc и создаёт ссылку на файл в директории DOT_DIR_FILE_HOME
if [[ $ISBASHRC == "y" || $ISBASHRC == "Y1" || $ISBASHRC == "" ]]; then
  if [[ -f ~/.bashrc ]]; then
    rm ~/.bashrc
  fi
  echo -e $LINK_IN_BASHRC_FILE > $DOT_DIR_FILE_HOME/bash/.bashrc
  ln -s $DOT_DIR_FILE_HOME/bash/.bashrc ~/.bashrc
  source ~/.bashrc
else
  echo 'Bashrс - пропущен'
fi

if [[ $FIRSTSTARTFEDORA == "y" || $FIRSTSTARTFEDORA == "Y2" || $FIRSTSTARTFEDORA == "" ]]; then
  bash $DOT_DIR_FILE_HOME/first_settings_Fedora.sh
else
    echo 'Первоначальная настройка Fedora Linux пропущена'
fi

if [[ $CONFIGTERMINAL == "y" || $CONFIGTERMINAL == "Y3" || $CONFIGTERMINAL == "" ]]; then
  if [[ -f ~/.config/terminator/config ]]; then
    cp -f $DOT_DIR_FILE_HOME/terminator/config ~/.config/terminator/config
  fi
  cp $DOT_DIR_FILE_HOME/terminator ~/.config/terminator/

  if [[ -f ~/.config/alacritty/alacritty.yml ]]; then
    cp -f $DOT_DIR_FILE_HOME/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
  fi
  cp $DOT_DIR_FILE_HOME/alacritty ~/.config/alacritty/
else
    echo 'Конфиги пропущены'
fi

if [[ $REMOTHERFILES == "y" || $REMOTHERFILES == "Y4" || $REMOTHERFILES == "" ]]; then    
  rm -r $DOT_DIR_FILE_HOME/_assets
  rm -r $DOT_DIR_FILE_HOME/terminator
  rm $DOT_DIR_FILE_HOME/install-linux.sh
  rm $DOT_DIR_FILE_HOME/first_settings_Fedora.sh
  rm $DOT_DIR_FILE_HOME/README.md
else
  echo 'Установочные файлы были нетронуты'
fi

echo 'Поздравляем! Всё установлено и готово к использованию!'
