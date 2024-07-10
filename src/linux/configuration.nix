{ inputs, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = { enable = true; };
      efi.canTouchEfiVariables = true;
    };
    initrd.postDeviceCommands = lib.mkAfter ''
      mkdir /btrfs_tmp
      mount /dev/root_vg/root /btrfs_tmp
      if [[ -e /btrfs_tmp/root ]]; then
          mkdir -p /btrfs_tmp/old_roots
          timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
          mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
      fi

      delete_subvolume_recursively() {
          IFS=$'\n'
          for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
              delete_subvolume_recursively "/btrfs_tmp/$i"
          done
          btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +0); do
          delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs_tmp/root
      umount /btrfs_tmp
    '';
  };

  users.users.eduardo = {
    isNormalUser = true;
    description = "eduardo";
    initialPassword = "1";
    extraGroups = [ "audio" "networkmanager" "wheel" ];
  };

  fileSystems."/persist".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [ "/etc/NetworkManager/system-connections" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "eduardo" = import ./home.nix; };
  };

  programs = {
    fuse.userAllowOther = true;
    hyprland.enable = true;
    dconf.enable = true;
    git = {
      enable = true;
      config = {
        user = {
          name = "xaviduds";
          email = "xaviduds@gmail.com";
        };
      };
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager = { enable = true; };
  };

  time.timeZone = "America/Sao_Paulo";

  i18n.defaultLocale = "pt_BR.UTF-8";

  console.keyMap = "br-abnt2";

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  environment = {
    systemPackages = with pkgs; [
      # Hard de se livrar
      git

      # Se livrar
      alacritty
      firefox
      helix
      tmux
      zathura

      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      python311Packages.python-lsp-server
      rust-analyzer
      rustfmt
      vscode-langservers-extracted
    ];
    # shellAliases = {
    #   # GIT
    #   "sshgithub" =
    #     "ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub";

    #   "s" = "if [ -d .git ]; then git status; fi";

    #   "gd" = "git diff";
    #   "gl" = "git log -p";

    #   "a" = "git add";
    #   "aa" = "git add .";
    #   "ap" = "git add -p";
    #   "ai" = "git add -i";

    #   "c" = "git commit";
    #   "m" = "git commit -m";

    #   "gp" = "git pull";
    #   "gpr" = "git pull --rebase";

    #   "p" = "git push";

    #   "cc" = "aa && m 'commit' && p && zl";

    #   # MOVING AROUND, FINDING OUT
    #   "z" =
    #     "clear && bash ~/.karma/scripts/fetch.sh && ls --group-directories-first -AFw1 && echo && s";
    #   "t" =
    #     "clear && bash ~/.karma/scripts/fetch.sh && ls --group-directories-first -AFRw1 && echo && s";

    #   "k" = "cd ~/.karma && z";
    #   "ks" = "cd ~/.karma/scripts && z";
    #   "v" = "cd ~/.charya && z";
    #   "n" = "cd ~/.karma/src/linux && z && hx .";
    #   "d" = "cd ~/Downloads && z";
    #   "l" = "cd ~/lince && z";
    #   "co" = "cd ~/.config && z";
    #   "dc" = "cd ~/ && z";
    #   "ksrc" = "cd ~/.karma/src && z";
    #   "lsrc" = "cd ~/lince/src && z";

    #   ".." = "cd ..";
    #   "e" = "exit";

    #   # NIX
    #   "ns" = "nix-shell";
    #   "np" = "nix-shell -p";
    #   "ff" = "nix-shell -p firefox";

    # "nslince" = "nix-shell ~/lince/default.nix";
    # "nsl" = "nix-shell ~/lince/default.nix";

    # "nspython" = "nix-shell ~/.karma/samadhi/python.nix";
    # "nsp" = "nix-shell ~/.karma/samadhi/python.nix";

    # "nsreact" = "nix-shell ~/.karma/samadhi/react.nix";

    # "nsrust" = "nix-shell ~/.karma/samadhi/rust.nix";

    # "nsds" = "nix-shell ~/.karma/samadhi/data_science.nix";

    # "nd" = "nix flake update && nix develop && z";
    # "u" = "sudo nix flake update ~/.karma/src/linux/";
    # "b" =
    #   "sudo nixos-rebuild switch --flake ~/.karma/src/linux#default --impure";
    # "br" = "b && reboot";
    # "ncs" = "nix-collect-garbage -d && df -h";
    # "bah" = "u && b && ncs";

    # # STUDY
    # "ht" = "hx ~/.charya";
    # "zt" = "zathura ~/.charya/estudando/* &";

    # # TMUX
    # "22" =
    #   "tmux split-window -h \\; split-window -v \\; select-pane -L \\; split-window -v \\; select-pane -U && clear";
    # "12" =
    #   "tmux split-window -v \\; split-window -h \\; select-pane -L \\; select-pane -U && clear";

    # # DEV
    # "f" = "firefox &";
    # "h" = "hx";
    # "hk" = "hx ~/.karma";

    # "linsql" = "psql -U postgres -d lince";

    # "hl" = "hx ~/lince/src/app/lince.py";
    # "linceapploop" =
    #   "while true; do python ~/lince/src/app/lince.py; sleep 1; done";
    # "lap" = "while true; do python ~/lince/src/app/lince.py; sleep 1; done";

    # "lincetestloop" =
    #   "while true; do python ~/lince/org/test/test.py; sleep 1; done";
    # "ltl" = "while true; do python ~/lince/org/test/test.py; sleep 1; done";

    # # SYSTEM CONTROL
    # "wifi" = "xterm -e nmtui";
    # "i" = "bash ~/.karma/scripts/fetch.sh";
    # "logout" = "pkill -u eduardo";

    # "vt" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    # "vu" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
    # "vd" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
    # "va" = "wpctl set-volume @DEFAULT_AUDIO_SINK@";
    # "v0" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0";

    #   "mt" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
    #   "mu" = "wpctl set-volume @DEFAULT_SOURCE@ 0.01+";
    #   "md" = "wpctl set-volume @DEFAULT_SOURCE@ 0.01-";
    #   "ma" = "wpctl set-volume @DEFAULT_SOURCE@";
    #   "m0" = "wpctl set-volume @DEFAULT_SOURCE@ 0";
    #   "m10" = "wpctl set-volume @DEFAULT_SOURCE@ 0.1";

    #   "bu" = "brightnessctl s +5%";
    #   "bd" = "brightnessctl s 5%-";
    # };
  };

  services = {
    postgresql = {
      enable = true;
      authentication = pkgs.lib.mkOverride 10 ''
        #type database  DBuser  auth-method
        				local all       all     trust
        				host all       all     127.0.0.1/32   trust
        				host all       all     ::1/128        trust		
        				'';
    };

    xserver = {
      enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };

    thermald.enable = true;

    power-profiles-daemon.enable = false;

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "powersave";
          turbo = "auto";
        };
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /persist/home/ 0777 root root -" # create /persist/home owned by root
    "d /persist/home/eduardo 0700 eduardo users -" # /persist/home/<user> owned by that user
  ];

  nix = {
    optimise = {
      automatic = true;
      dates = [ "22:11" ];
    };
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 1d";
    };
  };

  system = {
    autoUpgrade = {
      enable = true;
      flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "22:11";
      randomizedDelaySec = "45min";
    };
    stateVersion = "24.05";
  };
}
