{ inputs, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
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

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };
  console.keyMap = "br-abnt2";

  hardware = { pulseaudio.enable = false; };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };

  nixpkgs = { config = { allowUnfree = false; }; };

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  environment = {
    systemPackages = with pkgs; [
      alacritty
      brightnessctl
      eza
      feh
      firefox
      gh
      git
      helix
      man
      nil
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      python311Packages.python-lsp-server
      rust-analyzer
      rustfmt
      tmux
      vscode-langservers-extracted
      zathura

      mpv
      yt-dlp
    ];
    shellAliases = {
      ##############################################
      # Inspired by https://github.com/oliveski/lofi

      "lofi" = # lofi hip hop radio 📚 - beats to relax/study to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/jfKfPfyJRdk' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofisynth" = # synthwave radio 🌌 - beats to chill/game to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/4xDzrJKXOOY' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofisleep" = # lofi hip hop radio 💤 - beats to sleep/chill to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/rUxyKA_-grg' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofidark" = # dark ambient radio 🌃 - music to escape/dream to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/S_MOd40zlYU' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofipiano" = # peaceful piano radio 🎹 - music to focus/study to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/4oStw0r33so' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofiorientalized" = # asian lofi radio ⛩️ - beats to relax/study to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/Na0w3Mz46GA' 2> /dev/null | mpv --no-video - 2> /dev/null";

      "lofimedieval" = # medieval lofi radio 🏰 - beats to scribe manuscripts to
        "yt-dlp --buffer-size 1024 -f 91 -o - 'https://www.youtube.com/live/_uMuuHk_KkQ' 2> /dev/null | mpv --no-video - 2> /dev/null";

      ##############################################

      "sshgithub" =
        "ssh-keygen -t ed25519 -C 'xaviduds@gmail.com' && eval '$(ssh-agent -s)' && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub";
      "s" = "if [ -d .git ]; then git status; fi";
      "aa" = "git add .";
      "p" = "git push";
      "gp" = "git pull";
      "ap" = "git add -p";
      "ai" = "git add -i";
      "gd" = "git diff";
      "gpr" = "git pull --rebase";
      "a" = "git add";
      "c" = "git commit";
      "m" = "git commit -m";
      "cc" = "git add . && git commit -m 'commit' && git push && zl";

      "za" =
        "clear && bash ~/.karma/scripts/fetch.sh && eza -T -L 2 --icons=always --group-directories-first -s name -I .git -lh --no-user --no-permissions --git-repos --git --no-time -a && s";
      "z" =
        "clear && bash ~/.karma/scripts/fetch.sh && eza -T -L 2 --icons=always --group-directories-first -s name -I .git -lh --no-user --no-permissions --git-repos --git --no-time && s";
      "zl" =
        "clear && bash ~/.karma/scripts/fetch.sh && eza -a --icons=always --group-directories-first -s name -I .git -lh --no-user --no-permissions --git-repos --git --no-time && s";
      "zs" =
        "clear && bash ~/.karma/scripts/fetch.sh && eza -a --icons=always --group-directories-first -s size -r -I .git -lh --no-user --no-permissions --git-repos --git --no-time --total-size && s";
      "et" = "eza -T";
      "k" = "cd ~/.karma && z";
      "v" = "cd ~/.abodhi && z";
      "n" = "cd ~/.karma/src/nixos && z";
      "d" = "cd ~/Downloads && z";
      "l" = "cd ~/lince && z";
      "i" = "cd ~/lince && zl";
      "co" = "cd ~/.config && zl";
      "dc" = "cd ~/ && z";
      "ksrc" = "cd ~/.karma/src && zl";
      "lsrc" = "cd ~/lince/src && z";
      ".." = "cd ..";
      "e" = "exit";

      "ns" = "nix-shell";
      "np" = "nix-shell -p";
      "nslince" = "nix-shell ~/lince/shell.nix";
      "nsreact" = "nix-shell ~/.karma/samadhi/react.nix";
      "nspython" = "nix-shell ~/.karma/samadhi/python.nix";
      "nsrust" = "nix-shell ~/.karma/samadhi/rust.nix";
      "nsds" = "nix-shell ~/.karma/samadhi/data_science.nix";
      "lincedb" = "psql -U postgres -d lince";

      "nd" = "nix flake update && nix develop && z";
      "u" = "sudo nix flake update ~/.karma/src/nixos/";
      "b" = "sudo nixos-rebuild switch --flake ~/.karma/src/nixos#default";
      "ncs" = "nix-collect-garbage -d && df -h";
      "bah" = "u && b && ncs";

      "h" = "hx";
      "linsql" = "psql -U postgres -d lince";
      "hl" = "hx ~/lince/src/app/lince.py";
      "f" = "bash ~/.karma/src/nixos/fetch.sh";
      "zz" = "zathura ~/.abodhi/estudando/* &";
      "ht" = "hx ~/.abodhi/teoria.md";
      "looplince" = "while true; do python ~/lince/src/lince.py; sleep 1; done";
      "linceestudando" = "bash ~/.karma/scripts/linceestudando.sh";

      "va" = "wpctl set-volume @DEFAULT_AUDIO_SINK@";
      "vu" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+";
      "vd" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "vt" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "v0" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0";

      "ma" = "wpctl set-volume @DEFAULT_SOURCE@";
      "mu" = "wpctl set-volume @DEFAULT_SOURCE@ 0.01+";
      "md" = "wpctl set-volume @DEFAULT_SOURCE@ 0.01-";
      "mt" = "wpctl set-mute @DEFAULT_SOURCE@ toggle";
      "m0" = "wpctl set-volume @DEFAULT_SOURCE@ 0";

      "bu" = "brightnessctl s +5%";
      "bd" = "brightnessctl s 5%-";
    };
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
      pulse.enable = true;
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
    stateVersion = "23.11";
  };
}

