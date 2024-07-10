clear
tmux attach
clear
tmux
clear

if [ -f ~/.bash_aliases ]; then
    . /home/eduardo/.bash_aliases
fi

cd ~/lince && clear
i
ls --group-directories-first -AFw1
echo
if [ -d .git ]; then git status; fi

shopt -s autocd

PS1="[\D{%Y-%m-%d %H:%M:%S %A} \u@\h:\w]$ "
