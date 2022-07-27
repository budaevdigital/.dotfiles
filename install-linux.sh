#!/bin/bash
DOT_DIR_FILE_HOME=~/.dotfiles-master
DOT_DIR_FILE_HOME_ZIP=~/.dotfiles-master.zip
ISBASHRC=$1
REMOTHERFILES=$2

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

# Блок с установкой
# -e  (readline), чтобы разрешить редактирование строки с помощью клавиш со стрелками
# read -e -p "
# Хотите установить настройки для Bashrс? [Y/n] " ISBASHRC



if [[ $ISBASHRC == "y" || $ISBASHRC == "Y1" || $ISBASHRC == "" ]]; then
    if [[ -f ~/.bashrc ]]; then
	    rm ~/.bashrc
    fi
        ln -s $DOT_DIR_FILE_HOME/bash/.bashrc ~/.bashrc      
else
    echo 'Bashrс - пропущен'
fi

# read -e -p "
# Удалить ненужные установочные файлы? [Y/n] " REMOTHERFILES

if [[ $REMOTHERFILES == "y" || $REMOTHERFILES == "Y2" || $REMOTHERFILES == "" ]]; then    
    rm -r $DOT_DIR_FILE_HOME/_assets
    rm -r $DOT_DIR_FILE_HOME/terminator
    rm $DOT_DIR_FILE_HOME/install-linux.sh
    rm $DOT_DIR_FILE_HOME/README.md
else
    echo 'Установочные файлы были нетронуты'
fi


echo 'Поздравляем! Всё установлено и готово к использованию!'