DOT_DIR_FILE_HOME=~/.dotfiles-master

LINK_IN_BASHRC_FILE=('#.bashrc\n\n
source '$DOT_DIR_FILE_HOME'/bash/.shells/.defaults\n
source '$DOT_DIR_FILE_HOME'/bash/.shells/.functions\n
source '$DOT_DIR_FILE_HOME'/bash/.shells/.alias\n
source '$DOT_DIR_FILE_HOME'/bash/.shells/.prompt')

echo -e $LINK_IN_BASHRC_FILE > bashtext