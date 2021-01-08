{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    coreutils
    dragon-drop
    exa
    fd
    fzf
    gawk
    gnused
    gnutls
    gotop
    htop
    lf
    nix-zsh-completions
    nmap
    powertop
    starship
    universal-ctags
    unzip
    xsv
    zsh
    nixpkgs-fmt
    nixpkgs-lint
    cachix
    bat
    ripgrep
    openssl
    rbw
    pinentry-qt
    dmenu
    xdotool
    nix-index
    gitAndTools.gitui
    graphviz
  ];


  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };
  # programs.autojump = {
  #   enable = true;
  #   enableZshIntegration = true;
  # };

  # programs.gpg.enable = true;
  # programs.gpg.settings = {
  #   pinentry-program = "/home/fedeizzo/.nix-profile/bin/pinentry-curses";
  # };

  home.file.".gitconfig" = {
    source = ../dotfiles/dot_gitconfig;
  };
  xdg.configFile."lf/lfrc".source = ../dotfiles/dot_config/lf/lfrc;
  xdg.configFile."starship.toml".source = ../dotfiles/dot_config/starship.toml;
  xdg.configFile."gitui/key_config.ron".source = ../dotfiles/dot_config/gitui/key_config.ron;
  xdg.configFile."gitui/theme.ron".source = ../dotfiles/dot_config/gitui/theme.ron;
}
