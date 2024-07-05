alacritty -e tmux attach -t lince_dev & 
alacritty -e tmux new-session -s "lince_dev" &

alacritty -e tmux attach -t lince_test & 
alacritty -e tmux new-session -s "lince_test" &
