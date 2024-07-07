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

      ".config/hypr/hyprland.conf".source =
        /home/eduardo/.karma/src/linux/hypr/hyprland.conf;

      # ".bashrc".source = /home/eduardo/.karma/src/linux/bash/.bashrc;
      ".bash_aliases".source =
        /home/eduardo/.karma/src/linux/bash/.bash_aliases;
    };
    username = "eduardo";
    homeDirectory = "/home/eduardo";
    stateVersion = "24.05";
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
