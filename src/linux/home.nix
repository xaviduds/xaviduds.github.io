{ pkgs, inputs, ... }:

{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];
  home = {
    persistence."/persist/home/eduardo" = {
      directories =
        [ ".charya" "lince" ".karma" ".ssh" ".local/share/zathura" ];
      allowOther = true;
    };
    file = {
      ".config/zathura/zathurarc".source =
        /home/eduardo/.karma/src/linux/zathura/zathurarc;

      ".config/alacritty/alacritty.toml".source =
        /home/eduardo/.karma/src/linux/alacritty/alacritty.toml;

      ".config/helix/config.toml".source =
        /home/eduardo/.karma/src/linux/helix/config.toml;
      ".config/helix/languages.toml".text = ''
        [[language]]
        name = "nix"
        auto-format = true
        formatter.command = "${pkgs.nixfmt-classic}/bin/nixfmt"
      '';

      ".config/tmux/tmux.conf".source =
        /home/eduardo/.karma/src/linux/tmux/tmux.conf;

      # ".config/hypr/hyprland.conf".source =
      #   /home/eduardo/.karma/src/linux/hypr/hyprland.conf;

      # ".bashrc".source = /home/eduardo/.karma/src/linux/bash/.bashrc;
      # ".bash_aliases".source =
      #   /home/eduardo/.karma/src/linux/bash/.bash_aliases;
    };
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "24.05";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = ",highres,auto,1";
      exec-once = [ "sleep 5 && wpctl set-volume @DEFAULT_SOURCE@ 0.1" ];
      input = {
        kb_layout = "br";
        kb_variant = "abnt2";
        kb_model = "abnt2";
        numlock_by_default = "yes";
      };
      general = {
        gaps_in = "0";
        gaps_out = "0";
        border_size = "0";
      };
      animations = { enabled = "false"; };
      misc = { disable_hyprland_logo = "true"; };
      bind = [
        "SUPER, Q, exec, alacritty"
        "SUPER, C, killactive"
        "SUPER, M, exit"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"
        "SUPER CTRL, H, movewindow, l"
        "SUPER CTRL, L, movewindow, r"
        "SUPER CTRL, K, movewindow, u"
        "SUPER CTRL, J, movewindow, d"
        "SUPER SHIFT, l, resizeactive, 50 0"
        "SUPER SHIFT, h, resizeactive, -50 0"
        "SUPER SHIFT, k, resizeactive, 0 -50"
        "SUPER SHIFT, j, resizeactive, 0 50"
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"
      ];
    };
  };
  programs = {
    home-manager.enable = true;
    bash = {
      enable = true;
      initExtra = ''
        tmux_session_checker
      '';
    };
  };
}
