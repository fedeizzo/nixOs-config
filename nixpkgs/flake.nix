{
  description = "Home manager flake configuration";

  # inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  # inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay.url = "github:neovim/neovim/release-0.5?dir=contrib";

  inputs.home-manager = {
    url = "github:rycee/home-manager/release-21.05";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay 
      ];
    in
    {
      homeConfigurations = {
        linux = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              nixpkgs.overlays = overlays;
              nixpkgs.config = import ./laptop/config.nix;
              imports = [
                ./laptop/home.nix
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/fedeizzo";
          username = "fedeizzo";
        };
      };
      linux = self.homeConfigurations.linux.activationPackage;
    };
}
