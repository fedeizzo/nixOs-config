{ config, pkgs, libs, ... }:

{
  home.packages = with pkgs; [
    (makeDesktopItem {
      name = "reboot";
      exec = "reboot";
      comment = "Reboot the system";
      desktopName = "reboot";
      type = "Application";
    })
    (makeDesktopItem {
      name = "shutdown";
      exec = "shutdown now";
      comment = "Shutdown the system";
      desktopName = "shutdown";
      type = "Application";
    })
    coreutils
    xdragon
    exa
    fd
    fzf
    gawk
    gnused
    gnutls
    htop
    nmap
    powertop
    unzip
    xsv
    zsh
    cachix
    bat
    ripgrep
    openssl
    rbw
    rofi-rbw
    nix-index
    rsync
    brightnessctl
    jq
    openssh
    pamixer
    pandoc
    borgbackup
    ncdu
    playerctl
    libsecret
    w3m
    rclone
    lazygit
    graphviz
    sshfs
    ffmpeg
    flac
    file
    mpd-mpris
    moreutils
    home-manager
    zip
  ];
  xdg.configFile."rofi-rbw.rc" = {
    source = ./rofi-rbw.rc;
  };
}
