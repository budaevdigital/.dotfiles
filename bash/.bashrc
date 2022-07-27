# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

PS1='\[\e[0;2m\][\[\e[0;2m\]\A\[\e[0;2m\]]\[\e[0;2m\][\[\e[0;2m\]\u\[\e[0;2m\]@\[\e[0;2m\]\h\[\e[0;2m\]]\[\e[0;2m\]> \[\e[0;1;38;5;210m\]$(git branch 2>/dev/null | grep '"'"'^*'"'"' | colrm 1 2) \[\e[0;38;5;37m\]\w\n\[\e[0;2;38;5;98m\]\! \[\e[0;2m\].\[\e[0;2m\]/\[\e[0;1;2;97m\]\W\[\e[0;2m\]>\[\e[0;38;5;41m\]\$ \[\e[0m\]'


# Ограничиваем размер файлов баш-историй
HISTSIZE=2000
HISTFILESIZE=2000

#-------------------
# Псевдонимы (Alias)
#-------------------

# Рабочие директории
alias study='cd ~/Documents/Code/Git/Study/'
alias study-api='cd ~/Documents/Code/Git/Study/Yandex/Module_7/02_API/api_yamdb'


alias h='history'
alias c='clear'


# Переместить в родительскую папку (на один/два/три каталого наверх)
alias ..='cd ..;pwd'
alias ...='cd ../..;pwd'
alias ....='cd ../../..;pwd'

# Псевдонимы под свои функции
alias findlarge='find_largest_files'
alias myip='print_ip_adress'
alias ginit='git_init'
alias vpn='see_vpn_is_active'


#-------------------
# Функции
#-------------------

# Показывает список (20 первых) самых больших файлов в каталоге
function find_largest_files() {
    du -h -x -s -- * | sort -r -h | head -20;
}

function print_ip_adress(){
	# 2>/dev/null - убирает вывод таблицы curl запроса в консоль. Только ip
	get_ip=$(curl ifconfig.me 2>/dev/null);
	echo "Мой IP адресс: $get_ip";
}

# Инициализация проекта (каталога и шаблонов гит файлов)
function git_init() {
    if [ -z "$1" ]; then
        printf "%s\n" "Укажите имя директории";
    else
        mkdir "$1";
        builtin cd "$1";
        pwd;
        git init;
        touch readme.md .gitignore LICENSE;
        echo "# $(basename $PWD)" >> readme.md
    fi
}

function see_vpn_is_active() {
	# задаём переменную в которой ищем запущен ли wireguard
	isactive=$(sudo wg show | grep -c wg0);
	if sudo wg show | grep -c wg0 2>&1 >/dev/null; then
		# /dev/null 2>&1 - отключает вывод у указанного уровня (2 и 1) вывода в терминал
		wg-quick down wg0 > /dev/null 2>&1 && echo "VPN Deactivate";
	# если переменная equal (равна) False
	elif [ $isactive -eq 0 ]; then
		wg-quick up wg0 > /dev/null 2>&1 && echo "VPN Activate";
	fi
}


# сокращать путь к текущему каталогу в строке терминала
export PROMPT_DIRTRIM=5

