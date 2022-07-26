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



#-------------------
# Псевдонимы (Alias)
#-------------------

alias study='cd ~/Documents/Code/Git/Study/'
alias h='history'


# сокращать путь к текущему каталогу в приглашении

export PROMPT_DIRTRIM=5
