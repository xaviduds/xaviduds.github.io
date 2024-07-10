if [ -f ~/.bash_aliases ]; then
    . /home/eduardo/.bash_aliases
fi

case $(tmux display-message -p '#S') in

  *)
  clear
  tmux attach
  clear
  tmux
  clear
  cd ~/lince && clear
  bash ~/.karma/scripts/fetch.sh
  ls --group-directories-first -AFw1
  echo
  if [ -d .git ]; then git status; fi;;

esac
