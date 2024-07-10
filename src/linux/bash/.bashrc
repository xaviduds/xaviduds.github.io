clear
tmux attach
clear
tmux
clear

if [ -f ~/.bash_aliases ]; then
    . /home/eduardo/.bash_aliases
fi

l

shopt -s autocd

PS1="[\D{%Y-%m-%d %H:%M:%S %A} \u@\h:\w]$ "
