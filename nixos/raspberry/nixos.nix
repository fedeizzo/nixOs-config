{ config, pkgs, lib, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxPackages_rpi4;
    tmpOnTmpfs = true;
    cleanTmpDir = true;
    # ttyAMA0 is the serial console broken out to the GPIO
    kernelParams = [
      "8250.nr_uarts=1"
      "console=ttyAMA0,115200"
      "console=tty1"
      # A lot GUI programs need this, nearly all wayland applications
      "cma=128M"
    ];
    loader = {
      raspberryPi = {
        enable = true;
        uboot.enable = false;
        version = 4;
        firmwareConfig = ''
          dtparam=sd_poll_once=on
          dtoverlay=gpio-fan,gpiopin=14,temp=60000
        '';
      };
      grub.enable = false;
      systemd-boot.enable = false;
      generic-extlinux-compatible.enable = false;
    };
  };

  # Required for the Wireless firmware
  hardware.enableRedistributableFirmware = true;

  # NETWORKING
  networking = {
    hostName = "rasp-nixos";
    networkmanager = {
      enable = true;
    };
    # interfaces.eth0.ipv4.addresses = [{
    #   address = "192.168.1.31";
    #   prefixLength = 24;
    # }];
    nat = {
      enable = true;
      internalInterfaces = [ "tailscale0" ];
    };
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ 51820 ];
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = false;
    allowSFTP = false; # Don't set this if you need sftp
    challengeResponseAuthentication = false;
    openFirewall = false;
    forwardX11 = false;
    permitRootLogin = "no";
  };
  services.fail2ban.enable = true;
  # tailscale up
  # ip link show tailscale0
  # jorntalctl -fu tailscale
  services.tailscale = {
    enable = true;
    port = 51820;
  };
  # add gpio group
  users.groups.gpio = { };

  # udev rule for gpio
  services.udev.extraRules = ''
    SUBSYSTEM=="bcm2835-gpiomem", KERNEL=="gpiomem", GROUP="gpio",MODE="0660"
    SUBSYSTEM=="gpio", KERNEL=="gpiochip*", ACTION=="add", RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio  /sys/class/gpio/export /sys/class/gpio/unexport ; chmod 220 /sys/class/gpio/export /sys/class/gpio/unexport'"
    SUBSYSTEM=="gpio", KERNEL=="gpio*", ACTION=="add",RUN+="${pkgs.bash}/bin/bash -c 'chown root:gpio /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value ; chmod 660 /sys%p/active_low /sys%p/direction /sys%p/edge /sys%p/value'"
  '';
  systemd.services.fan-control = {
    enable = true;
    script = ''
      while true; do
        ontemp=60
        temp=$(${pkgs.libraspberrypi}/bin/vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
        temp0=$${temp%.*}

        if [[ $temp > $ontemp ]]; then
            ${pkgs.libgpiod}/bin/gpioset gpiochip0 14=1
        else
            ${pkgs.libgpiod}/bin/gpioset gpiochip0 14=0

        fi
        sleep 10
      done
    '';
    unitConfig = {
      Type = "simple";
    };
    wantedBy = [ "multi-user.target" ];
  };

  # KEYMAP AND TIME
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };
  time.timeZone = "Europe/Rome";
  time.hardwareClockInLocalTime = true;

  # PACKAGES
  environment.systemPackages = with pkgs; [
    tailscale
    raspberrypifw
    bc
    curl
    killall
    wget
    git
    vim
    docker-compose
    dnsmasq
    hostapd
    firefox
    raspberrypi-eeprom
    libraspberrypi
    libgpiod
    borgbackup
  ];
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      enableNvidia = false;
    };
  };
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
  };

  # i3
  services.xserver = {
    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      startx.enable = false;
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
      ];
    };
  };

  # SECURITY
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      { groups = [ "wheel" ]; keepEnv = true; persist = true; }
    ];
  };
  # Show log with journactl -f
  security.auditd.enable = true;
  security.audit.enable = true;
  security.audit.rules = [
    "-a exit,always -F arch=b64 -S execve"
  ];

  # USER
  users.users.rasp = {
    name = "rasp";
    isNormalUser = true;
    createHome = true;
    extraGroups = [
      "wheel"
      "docker"
      "autologin"
      "users"
      "networkmanager"
      "gpio"
    ];
    shell = pkgs.bash;
  };

  # NIX STUFF
  nixpkgs.config = {
    allowUnfree = true;
  };
  nix = {
    autoOptimiseStore = true;
    package = pkgs.nixFlakes;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
        min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
      experimental-features = nix-command flakes
    '';
  };
  system.stateVersion = "22.05";
}
