#!/bin/bash
DOT_DIR_FILE_HOME=~/.dotfiles-master
DOT_DIR_FILE_HOME_ZIP=~/.dotfiles-master.zip
ISBASHRC=$1
REMOTHERFILES=$2

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

if [[ $REMOTHERFILES == "y" || $REMOTHERFILES == "Y2" || $REMOTHERFILES == "" ]]; then    
    rm -r $DOT_DIR_FILE_HOME/_assets
    rm -r $DOT_DIR_FILE_HOME/terminator
    rm $DOT_DIR_FILE_HOME/install-linux.sh
    rm $DOT_DIR_FILE_HOME/README.md
else
    echo 'Установочные файлы были нетронуты'
fi

echo 'Поздравляем! Всё установлено и готово к использованию!'