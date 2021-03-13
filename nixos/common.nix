{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  imports = [ ./hardware-configuration.nix ];

  #################################
  # BOOT
  #################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;
  boot.kernelPackages = pkgs.linuxPackages;
  # boot.initrd.kernelModules = [ "btrfs" "xxhash" ];

  #################################
  # KEYMAP and TIME and FONT
  #################################
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };
  time.timeZone = "Europe/Rome";

  fonts = {
    fonts = [
      pkgs.fira-code
      pkgs.font-awesome
      pkgs.joypixels
      pkgs.symbola
      (pkgs.callPackage ./pkgs/gfonts.nix { })
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "Nimbus Mono PS" ];
        sansSerif = [ "Nimbus Sans" ];
        serif = [ "Nimbus Roman" ];
      };
    };
  };

  #################################
  # NIX/NIXOS
  #################################
  nixpkgs.config = {
    allowUnfree = true;
  };
  system.stateVersion = "20.09";
  nix = {
    autoOptimiseStore = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    binaryCachePublicKeys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
    binaryCaches = [
      "https://hydra.iohk.io"
    ];
  };

  #################################
  # PROGRAMS and ENV
  #################################
  environment.systemPackages = with pkgs; [
    bc
    curl
    dunst
    haskellPackages.xmobar
    killall
    libnotify
    neofetch
    picom
    unclutter
    wget
    xclip
    xorg.xbacklight
    xsel
    acpi
    arandr
    docker
    docker-compose
    podman
    podman-compose
    git
    highlight
    lm_sensors
    vim
    nvidia-offload
    (pkgs.callPackage ./pkgs/nvidia-xrun.nix { })
    xorg.xinit
    virt-manager
  ];
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
      enableNvidia = true;
      # extraOptions = "-H tcp://0.0.0.0:2376"; 
    };
    podman.enable = true;
    libvirtd.enable = true;
  };
  environment.shells = [ pkgs.bash pkgs.fish ];
  environment.pathsToLink = [ "/share/fish" ];
  environment.variables = {
    "EDITOR" = "nvim";
    "READER" = "zathura";
    "VISUAL" = "nvim";
    "CODEEDITOR" = "nvim";
    "TERMINAL" = "alacritty";
    "BROWSER" = "qutebrowser";
    "COLORTERM" = "truecolor";
  };
  environment.shellAliases = {
    # cp optimized for btrfs
    "cp" = "cp --reflink=auto -i";
    # some useful aliases
    "grep" = "grep --color=auto";
    "ip" = "ip -c ";
    ":q" = "exit";
    "mv" = "mv -i";
    "open" = "xdg-open";
    # editor aliases
    "v" = "nvim";
    "SS" = "systemctl";
  };
  # environment.etc = {
  #   "/etc/systemd/system/nvidia-xrun-pm.service".source = mkOptionDefault "${nvidia-xrun}/etc/systemd/system/nvidia-xrun-pm.service";
	# "/etc/default/nvidia-xrun".source = mkOptionDefault "${nvidia-xrun}/etc/default/nvidia-xrun";
	# "/etc/X11/nvidia-xorg.conf".source = mkOptionDefault "${nvidia-xrun}/etc/X11/nvidia-xorg.conf";
	# "/etc/X11/xinit/nvidia-xinitrc".source = mkOptionDefault "${nvidia-xrun}/etc/X11/xinit/nvidia-xinitrc";
	# "/usr/bin/nvidia-xrun".source = mkOptionDefault "${nvidia-xrun}/usr/bin/nvidia-xrun";
	# "/etc/X11/xinit/nvidia-xinitrc.d".source = mkOptionDefault "${nvidia-xrun}/etc/X11/xinit/nvidia-xinitrc.d";
	# "/etc/X11/nvidia-xorg.conf.d".source = mkOptionDefault "${nvidia-xrun}/etc/X11/nvidia-xorg.conf.d";

  # };
  programs.bash = {
    enableCompletion = true;
    enableLsColors = true;
  };
  programs.fish.enable = true;
  programs.autojump.enable = true;
  programs.light.enable = true;
  programs.ssh.askPassword = "";
  programs.ccache.enable = true;
  programs.gnupg.agent.enable = true;

  #################################
  # HARDWARE
  #################################
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
  powerManagement.enable = true;
  hardware.opengl = {
    enable = true;
    extraPackages = [
      pkgs.intel-media-driver
      pkgs.vaapiIntel
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
    ];
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  hardware.bumblebee = {
    enable = true;
    driver = "nvidia";
  };
  hardware.cpu.intel.updateMicrocode = true;
  hardware.pulseaudio = {
    enable = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = "load-module module-bluetooth-discover a2dp_config=\"ldac_eqmid=sq\"\n";
    package = pkgs.pulseaudioFull;
  };
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  # hardware.nvidia.prime = {
  #   offload.enable = true;

  #   intelBusId = "PCI:0:2:0";
  #   nvidiaBusId = "PCI:1:0:0";
  # };


  #################################
  # NETWORKING
  #################################
  networking.hostName = "fedeizzo-nixos";
  networking.networkmanager.enable = true;
  networking.useDHCP = false;

  #################################
  # SECURITY
  #################################
  security.sudo = {
    enable = true;
    wheelNeedsPassword = true;
  };

  #################################
  # SECURITY
  #################################
  services.xserver = {
    enable = true;
    autorun = true;
    desktopManager.default = null;
    displayManager.lightdm = {
      enable = true;
    };
    layout = "us";
    xkbVariant = "altgr-intl";
    libinput.enable = true;
    extraConfig = ''
      Section "InputClass"
        Identifier "touchpad"
        Driver "libinput"
        MatchIsTouchpad "on"
        Option "NaturalScrolling" "true"
      EndSection
    '';
    videoDrivers = [ "intel" ];

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
    };
  };
  services.tlp = {
    enable = true;
    settings = {
      TLP_ENABLE = 1;
      TLP_DEFAULT_MODE = "AC";
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
      CPU_HWP_ON_AC = "performance";
      CPU_HWP_ON_BAT = "balance-performance";
      DEVICES_TO_ENABLE_ON_STARTUP = "bluetooth wifi";
    };
  };
  services.thermald = {
    enable = true;
  };
  services.fstrim = {
    enable = true;
    interval = "weekly";
  };
}
