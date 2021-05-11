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
    xdotool
    nix-index
    gitAndTools.gitui
    rsync
    (nerdfonts.override {
      fonts = [
        "Meslo"
        "RobotoMono"
      ];
    })
    arandr
    autorandr
    bitwarden
    bitwarden-cli
    brightnessctl
    firefox
    xcmenu
    jq
    keyutils
    multilockscreen
    openssh
    pamixer
    pandoc
    pavucontrol
    playerctl
    qutebrowser
    xorg.xmodmap
    devour
    xss-lock
    borgbackup
    steam
    minecraft
    ncdu
    thunderbird
    joypixels
  ];

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };
}
