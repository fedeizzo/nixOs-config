{ pkgs, ... }:
let
  sources = import ../nix/sources.nix;
in
{
  imports = [
    ../modules/alacritty.nix
    ../modules/chat.nix
    ../modules/cli.nix
    #../modules/cuda.nix
    ../modules/languages.nix
    ../modules/media.nix
    ../modules/neovim.nix
    ../modules/nix-utilities.nix
    ../modules/nixos-desktop.nix
    ../modules/ssh.nix
  ];

  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.stateVersion = "20.09";
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history.save = 10000;
    plugins = [{
      name = "zsh-history-substring-search";
      src = pkgs.fetchFromGitHub {
        inherit (sources.historysubstring) owner repo rev sha256;
      };
    }
    {
      name = "zsh-syntax-highlighting";
      src = pkgs.fetchFromGitHub {
        inherit (sources.syntaxhighlighting) owner repo rev sha256;
      };
    }
    ];
    oh-my-zsh = {
      enable = true;
    };
    initExtra = builtins.readFile ../../dotfiles/dot_zshrc;
    envExtra = builtins.readFile ../../dotfiles/dot_zshenv;
  };

  home.file.".sources" = {
    source = ../../dotfiles/dot_sources;
    executable = true;
    recursive = true;
  };
  home.file."./.config/bspwm/bspwmrc" = {
    source = ../../dotfiles/dot_config/bspwm/executable_bspwmrc;
    executable = true;
  };
  xdg.configFile."sxhkd/sxhkdrc".source = ../../dotfiles/dot_config/sxhkd/sxhkdrc;

  services.lorri.enable = true;
}
