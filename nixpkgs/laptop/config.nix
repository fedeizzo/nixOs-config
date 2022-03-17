{ pkgs }:

{
  allowUnfree = true;
  cudaSupport = true;
  joypixels.acceptLicense = true;
  packageOverrides = pkgs: with pkgs; rec {
    swayhide = callPackage ../pkgs/swayhide.nix { };
    # rbw = callPackage ../pkgs/rbw.nix { };
    swaync = callPackage ../pkgs/swaync.nix { };
  };
  permittedInsecurePackages = [
    "electron-13.6.9"
  ];
  substituters = https://hydra.iohk.io https://iohk.cachix.org https://cache.nixos.org/;
  trusted-public-keys = hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ= iohk.cachix.org-1:DpRUyj7h7V830dp/i6Nti+NEO2/nhblbov/8MW7Rqoo= cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=;
}
