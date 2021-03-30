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
    rsync
    (nerdfonts.override {
      fonts = [
        "3270"
        "Agave"
        "AnonymousPro"
        "Arimo"
        "BitstreamVeraSansMono"
        "CascadiaCode"
        "Cousine"
        "DaddyTimeMono"
        "DejaVuSansMono"
        "FantasqueSansMono"
        "FiraCode"
        "Go-Mono"
        "Gohu"
        "Hack"
        "HeavyData"
        "IBMPlexMono"
        "Inconsolata"
        "InconsolataGo"
        "InconsolataLGC"
        "Iosevka"
        "JetBrainsMono"
        "Lekton"
        "LiberationMono"
        "MPlus"
        "Meslo"
        "Monofur"
        "Monoid"
        "Mononoki"
        "Noto"
        "ProFont"
        "ProggyClean"
        "RobotoMono"
        "ShareTechMono"
        "SourceCodePro"
        "SpaceMono"
        "Terminus"
        "Tinos"
        "Ubuntu"
        "UbuntuMono"
        "VictorMono"
        "iA-Writer"
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
    # libreoffice
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
    # wezterm
  ];

  programs.direnv = {
    enable = true;
    enableNixDirenvIntegration = true;
  };
}
