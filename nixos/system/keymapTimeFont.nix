{ config, pkgs, ... }:

{
  #################################
  # KEYMAP and TIME and FONT
  #################################
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };
  time.timeZone = "Europe/Rome";
  time.hardwareClockInLocalTime = true;
  nixpkgs.config.joypixels.acceptLicense = true;

  fonts = {
    fonts = [
      pkgs.fira-code
      pkgs.font-awesome
      pkgs.joypixels
      pkgs.symbola
      pkgs.jetbrains-mono
      pkgs.emacs-all-the-icons-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
      };
    };
  };
}
