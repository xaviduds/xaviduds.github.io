alias sshgithub=alias ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub"
alias s="git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias gd="git diff"
alias a="git add"
alias aa="git add ."
alias ap="git add -p"
alias ai="git add -i"
alias c="git commit"
alias m="git commit -m"
alias gp="git pull"
alias gpr="git pull --rebase"
alias p="git push"
alias et="eza -T"
alias cc="aa && m 'commit' && p && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias za="clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias t="clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -T -L 2            && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias zs="clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s size -r -a --total-size && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias k="cd ~/.karma && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status "
alias ks="cd ~/.karma/scripts && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a -T -L 2         && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias v="cd ~/.charya && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status 
alias n="cd ~/.karma/src/linux && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias l="cd ~/lince && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias co="cd ~/.config && za"
alias dc="cd ~/ && za"
alias ksrc="cd ~/.karma/src && za"
alias lsrc="cd ~/lince/src && clear && bash ~/.karma/scripts/fetch.sh && eza --icons=always --group-directories-first -I .git -lh --no-user --no-permissions --git-repos --git --no-time -s name -a                && git rev-parse --is-inside-work-tree &>/dev/null && git status"
alias e="exit"
alias ns="nix-shell"
alias ..="cd .."
alias np="nix-shell -p"
alias ff="nix-shell -p firefox"
alias nslince="nix-shell ~/lince/default.nix"
alias nsreact="nix-shell ~/.karma/samadhi/react.nix"
alias nspython="nix-shell ~/.karma/samadhi/python.nix"
alias nsrust="nix-shell ~/.karma/samadhi/rust.nix"
alias nsds="nix-shell ~/.karma/samadhi/data_science.nix"
alias nd="nix flake update && nix develop && z"
alias u="sudo nix flake update ~/.karma/src/linux/"
alias b="sudo nixos-rebuild switch --flake ~/.karma/src/linux#default --impure"
alias ncs="nix-collect-garbage -d && df -h"
alias bah="u && b && ncs"
alias zz="zathura ~/.charya/estudando/* &"
alias ht="hx ~/.charya/teoria.md"
alias tmux_session_checker="bash ~/.karma/scripts/sessions/tmux_checker.sh"
alias 22="tmux split-window -h \\; split-window -v \\; select-pane -L \\; split-window -v \\; select-pane -U && clear"
alias 12="tmux split-window -v \\; split-window -h \\; select-pane -L \\; select-pane -U && clear"
alias me="bash ~/.karma/scripts/sessions/estudo.sh"
alias ml="bash ~/.karma/scripts/sessions/lince.sh"
alias mp="bash ~/.karma/scripts/sessions/portfolio.sh"
alias f="firefox &"
alias h="hx"
alias linsql="psql -U postgres -d lince"
alias lincetest="while true; do python ~/lince/src/app/lince.py; sleep 1; done"
alias wifi="xterm -e nmtui"
alias i="bash ~/.karma/scripts/fetch.sh"
alias logout="pkill -u eduardo"
alias va="wpctl set-volume @DEFAULT_AUDIO_SINK@"
alias vu="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
alias vd="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
alias vt="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
alias v0="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0"
alias ma="wpctl set-volume @DEFAULT_SOURCE@"
alias mu="wpctl set-volume @DEFAULT_SOURCE@ 0.01+"
alias md="wpctl set-volume @DEFAULT_SOURCE@ 0.01-"
alias mt="wpctl set-mute @DEFAULT_SOURCE@ toggle"
alias m0="wpctl set-volume @DEFAULT_SOURCE@ 0"
alias bu="brightnessctl s +5%"
alias bd="brightnessctl s 5%-"