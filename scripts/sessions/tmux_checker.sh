case $(tmux display-message -p '#S') in

  "estudo_nota") hx ~/.charya/teoria.md;;

  "lince_dev") hx ~/lince;;
  # "lince_test") ;;
  
  "portfolio_dev") hx ~/.karma;;
  # "portfolio_test") hx ~/.karma;;

  *)
  clear
  tmux attach
  clear
  tmux
  clear && cd ~/lince && clear && bash ~/.karma/scripts/fetch.sh && eza -T -L 2 --icons=always --group-directories-first -s name -I .git -lh --no-user --no-permissions --git-repos --git --no-time && if [ -d .git ]; then git status; fi;;

esac
