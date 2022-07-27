#!/bin/bash
DOT_DIR_FILE_HOME=~/.dotfiles-master
DOT_DIR_FILE_HOME_ZIP=~/.dotfiles-master.zip

if [ ! -d $DOT_DIR_FILE_HOME ]

then
    wget https://github.com/budaevdigital/.dotfiles/archive/master.zip -O $DOT_DIR_FILE_HOME_ZIP
    mkdir $DOT_DIR_FILE_HOME
    unzip $DOT_DIR_FILE_HOME_ZIP -d ~/
    rm $DOT_DIR_FILE_HOME_ZIP
fi

# Блок с установкой
# -e  (readline), чтобы разрешить редактирование строки с помощью клавиш со стрелками
read -e -p 'Хотите установить настройки для Bashrс? (y-да или n-нет)' -i 'y' ISBASHRC

if [ $ISBASHRC = 'y' ]
then
    if [ -f ~/.bashrc ]
    then
	    rm ~/.bashrc
        cp ~/.dotfiles-master/bash/.bashrc
        ln -s ~/.dotfiles-master/bash/.bashrc ~/.bashrc
    else
        cp ~/.dotfiles-master/bash/.bashrc
        ln -s ~/.dotfiles-master/bash/.bashrc ~/.bashrc      
    fi
else
    echo 'Bashrс - пропущен'
fi

read -e -p 'Удалить оставшиеся установочные файлы? (y-да или n-нет)' -i 'y' REMOTHERFILES

if [ $REMOTHERFILES = 'y' ]
then    
    rm -r ~/.dotfiles-master/_assets
    rm -r ~/.dotfiles-master/terminator
    rm ~/.dotfiles-master/install-linux.sh
    rm ~/.dotfiles-master/README.md
fi


echo 'Поздравляем! Всё установлено и готово к использованию!'