{
  description = "Home manager flake configuration";

  # inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-21.11";
  inputs.nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  # inputs.neovim-nightly-overlay.url = "github:mjlbach/neovim-nightly-overlay";
  inputs.neovim-nightly-overlay = {
    url = "github:neovim/neovim/release-0.6?dir=contrib";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  inputs.home-manager = {
    url = "github:rycee/home-manager/release-21.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
    let
      unstable-overlay = final: prev: {
        unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
      };
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        unstable-overlay
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
          stateVersion = "21.11";
        };
      };
      linux = self.homeConfigurations.linux.activationPackage;
    };
}
