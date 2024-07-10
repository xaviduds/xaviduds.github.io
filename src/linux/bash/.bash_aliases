# idate_printer() {
#   date +"%Y-%m-%d %H:%M:%S %A"
# }
# ivolume_printer() {
# volume_percentage=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F " " '{print $2*100}')
# volume_state=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk -F'[\\[\\]]' 'END{print $2}')
# ( [ "$volume_state" == "MUTED" ] && printf "%s%s%s\n" " " "$volume_percentage" "%"|| printf "%s%s%s%s\n" "  " " " "$volume_percentage" "%")
# }
# imicrophone_printer() {
# microphone_percentage=$(wpctl get-volume @DEFAULT_SOURCE@ | awk -F " " '{print $2*100}')
# microphone_state=$(wpctl get-volume @DEFAULT_SOURCE@ | awk -F'[\\[\\]]' 'END{print $2}')
# ( [ "$microphone_state" == "MUTED" ] && printf "%s%s%s\n" " " "$microphone_percentage" "%" || printf "%s%s%s\n" " " "$microphone_percentage" "%")
# }
# itmux_printer() {
# tmux list-windows -F '#{window_index}#{window_flags}' | awk '{gsub(/\*$/, "*"); printf "%s ", $0} END {print ""}'
# }
alias iatencao="echo -n Atenção é a fonte de amor, prazer e paz. Supere o que diminui isso."
# alias idate='echo -n $(date +"%Y-%m-%d %H:%M:%S %A")'
# alias ibattery='echo -n 󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%'
# alias ivolume='echo -n $(ivolume_printer)'
# alias imicrophone='echo -n $(imicrophone_printer)'
# alias itmux='echo $(itmux_printer)'
# alias i='iatencao && echo -n " " && idate && echo -n " " && ibattery && echo -n " " && ivolume && echo -n " " && imicrophone && echo -n " " && itmux'
alias i="bash ~/.karma/src/linux/bash/fetch.sh"
alias rb="reboot"
alias s="if [ -d .git ]; then git status; fi"
alias gd="git diff"
alias gl="git log -p"
alias a="git add"
alias aa="git add ."
alias ap="git add -p"
alias ai="git add -i"
alias c="git commit"
alias m="git commit -m"
alias gp="git pull"
alias gpr="git pull --rebase"
alias p="git push"
alias cc="aa && m 'commit' && p && zl"
alias z="clear && i && ls --group-directories-first -AFw1 && echo && s"
alias t="clear && i && ls --group-directories-first -AFRw1 && echo && s"
alias k="cd ~/.karma && z"
alias ks="cd ~/.karma/scripts && z"
alias v="cd ~/.charya && z"
alias n="cd ~/.karma/src/linux && z && hx ."
alias d="cd ~/Downloads && z"
alias l="cd ~/lince && z"
alias co="cd ~/.config && z"
alias dc="cd ~/ && z"
alias ksrc="cd ~/.karma/src && z"
alias lsrc="cd ~/lince/src && z"
alias ..="cd .."
alias e="exit"
alias ns="nix-shell"
alias np="nix-shell -p"
alias ff="nix-shell -p firefox"
alias nslince="nix-shell ~/lince/default.nix"
alias nsl="nix-shell ~/lince/default.nix"
alias nspython="nix-shell ~/.karma/samadhi/python.nix"
alias nsp="nix-shell ~/.karma/samadhi/python.nix"
alias nsreact="nix-shell ~/.karma/samadhi/react.nix"
alias nsrust="nix-shell ~/.karma/samadhi/rust.nix"
alias nsds="nix-shell ~/.karma/samadhi/data_science.nix"
alias nd="nix flake update && nix develop && z"
alias u="sudo nix flake update ~/.karma/src/linux/"
alias b="sudo nixos-rebuild switch --flake ~/.karma/src/linux#default --impure"
alias br="b && reboot"
alias ncs="nix-collect-garbage -d && df -h"
alias bah="u && b && ncs"
alias ht="hx ~/.charya"
alias zt="zathura ~/.charya/estudando/* &"
alias 22="tmux split-window -h \\; split-window -v \\; select-pane -L \\; split-window -v \\; select-pane -U && clear"
alias 12="tmux split-window -v \\; split-window -h \\; select-pane -L \\; select-pane -U && clear"
alias f="firefox &"
alias h="hx"
alias hk="hx ~/.karma"
alias linsql="psql -U postgres -d lince"
alias hl="hx ~/lince/src/app/lince.py"
alias linceapploop="while true; do python ~/lince/src/app/lince.py; sleep 1; done"
alias lap="while true; do python ~/lince/src/app/lince.py; sleep 1; done"
alias lincetestloop="while true; do python ~/lince/org/test/test.py; sleep 1; done"
alias ltl="while true; do python ~/lince/org/test/test.py; sleep 1; done"
alias wifi="xterm -e nmtui"
alias logout="pkill -u eduardo"
alias vt="wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && z"
alias vu="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ && z"
alias vd="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05- && z"
alias va="wpctl set-volume @DEFAULT_AUDIO_SINK@"
alias v0="wpctl set-volume @DEFAULT_AUDIO_SINK@ 0 && z"
alias mt="wpctl set-mute @DEFAULT_SOURCE@ toggle && z"
alias mu="wpctl set-volume @DEFAULT_SOURCE@ 0.01+ && z"
alias md="wpctl set-volume @DEFAULT_SOURCE@ 0.01- && z"
alias ma="wpctl set-volume @DEFAULT_SOURCE@"
alias m0="wpctl set-volume @DEFAULT_SOURCE@ 0 && z"
alias m10="wpctl set-volume @DEFAULT_SOURCE@ 0.1 && z"
alias bu="brightnessctl s +5%"
alias bd="brightnessctl s 5%-"
