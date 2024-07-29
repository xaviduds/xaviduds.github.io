# SYSTEM CONTROL
## RANDOM
alias ..="cd .."
alias e="exit"
alias rb="reboot"
alias po="poweroff"
alias wifi="xterm -e nmtui &"
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
alias bd="brightnessctl s -5%"

# GIT
alias o="origin"
alias s="[ -d .git ] && git status"
alias gb="git branch"
alias gc="git checkout"
alias gr="git restore"
alias gd="git diff"
alias gl="git log -p"
alias gt="git tag"

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
alias n="hx ~/.karma/src/linux && cd ~/.karma/src/linux && z"
alias hk="hx ~/.karma"

# NIX

## SHELLS
alias ns="nix-shell"
alias np="nix-shell -p"

alias nsp="nix-shell ~/.karma/samadhi/python.nix"
alias nsds="nix-shell ~/.karma/samadhi/data_science.nix"
alias nhc="nix-shell ~/.karma/samadhi/nh.nix"
alias w="librewolf &"

## BUILD
alias u="sudo nix flake update ~/.karma/src/linux/"
alias b="sudo nixos-rebuild switch --flake ~/.karma/src/linux#default --impure"
alias br="b && reboot"
alias ncs="nix-collect-garbage -d && df -h"
alias bah="u && b && ncs"

# LINCE
## PERSONAL
alias gcl="git clone https://github.com/lince-social/lince.git"
alias lp="cd ~/.charya/lince && z"
alias hlp="hx ~/.charya/lince/src/app/lince.py && lp"
alias nlp="lp && ns"

## STARTUP
alias nsl="nix-shell ~/lince/default.nix"
alias pyl="python src/cli.py"

## CD & HX
alias l="cd ~/lince && z"
alias hl="hx ~/lince/src && l"

## TESTING
alias ltl="while true; do python ~/lince/test/test.py; sleep 1; done"

## BUILDING
alias lv='rm "src/db/dump.sql" && git add . && git commit -m "Build rm dump.sql temporarily else error happened" && read -p "Tag name: " TAG && git tag "$TAG" && git reset --hard HEAD~1"'

## PULLING
alias gpl="cp src/db/dump.sql ~/dump.sql && mv src/db/dump.sql .. && git restore src/db/dump.sql && git pull --rebase && mv ../dump.sql src/db/dump.sql"

# CHARYA

## WRITING
alias v="cd ~/.charya && z"
alias hv="hx ~/.charya && v"

## READING
alias zv="zathura ~/.charya/estudando/* &"

# CARGO
alias c="cargo"
