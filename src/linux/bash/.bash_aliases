# SYSTEM CONTROL
## RANDOM
alias ..="cd .."
alias e="exit"
alias rb="reboot"
alias po="poweroff"
alias wifi="xterm -e nmtui"
alias logout="pkill -u eduardo"
alias i="bash ~/.karma/src/linux/bash/fetch.sh"

## VOLUME
alias vt="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && z"
alias vu="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ && z"
alias vd="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- && z"
alias va="wpctl set-volume @DEFAULT_AUDIO_SINK@"
alias v0="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0 && z"

## MICROPHONE
alias mt="wpctl set-mute @DEFAULT_SOURCE@ toggle && z"
alias mu="wpctl set-volume @DEFAULT_SOURCE@ 0.01+ && z"
alias md="wpctl set-volume @DEFAULT_SOURCE@ 0.01- && z"
alias ma="wpctl set-volume @DEFAULT_SOURCE@"
alias m0="wpctl set-volume @DEFAULT_SOURCE@ 0 && z"
alias m10="wpctl set-volume @DEFAULT_SOURCE@ 0.1 && z"

## BRIGHTNESS
alias bu="brightnessctl s +5%"
alias bd="brightnessctl s 5%-"

# GIT
alias s="[ -d .git ] && git status"
alias gd="git diff"
alias gl="git log -p"

alias a="git add"
alias aa="git add ."
alias ap="git add -p"
alias ai="git add -i"

alias m="git commit -m"
alias am="aa && m"

alias gp="git pull"
alias gpr="git pull --rebase"
alias p="git push"

alias cc="aa && m 'commit' && p && z"

# MESSING AROUND, FINDING OUT

## GENERAL
alias z="clear && i && ls --group-directories-first -AFw1 && echo && s"
alias t="clear && i && ls --group-directories-first -AFRw1 && echo && s"

alias h="hx"
alias co="cd ~/.config && z"
alias dc="cd ~/ && z"
alias d="cd ~/Downloads && z"

## KARMA
alias k="cd ~/.karma && z"
alias ks="cd ~/.karma/scripts && z"
alias sa="cd ~/.karma/samadhi && z"
alias ksrc="cd ~/.karma/src && z"
alias n="cd ~/.karma/src/linux && z && hx ."
alias hk="hx ~/.karma"

## LINCE

### SHELL
alias nsl="nix-shell ~/lince/default.nix"

### POSTGRE
alias linsql="psql -U postgres -d lince"

### CD & HX
alias l="cd ~/lince && z"
alias hl="l && hx ~/lince/src/app/lince.py"

### TESTING
alias ldl="while true; do python ~/lince/src/app/lince.py; sleep 1; done"
alias ltl="while true; do python ~/lince/test/test.py; sleep 1; done"

## CHARYA

### WRITING
alias c="cd ~/.charya && z"
alias hc="c && hx ~/.charya"

### READING
alias zc="zathura ~/.charya/estudando/* &"

# NIX

## SHELLS
alias ns="nix-shell"
alias np="nix-shell -p"

alias nsp="nix-shell ~/.karma/samadhi/python.nix"
alias nsds="nix-shell ~/.karma/samadhi/data_science.nix"
alias f="nix-shell ~/.karma/samadhi/firefox.nix"

## BUILD
alias nd="nix flake update && nix develop && z"
alias u="sudo nix flake update ~/.karma/src/linux/"

alias b="sudo nixos-rebuild switch --flake ~/.karma/src/linux#default --impure"
alias br="b && reboot"

alias ncs="nix-collect-garbage -d && df -h"
alias nph="nix-shell -p nh"
alias nhc="nh clean all"

alias bah="u && b && ncs"

# TMUX
alias 12="tmux split-window -v \\; split-window -h \\; select-pane -L \\; select-pane -U && clear"
alias 22="tmux split-window -h \\; split-window -v \\; select-pane -L \\; split-window -v \\; select-pane -U && clear"


