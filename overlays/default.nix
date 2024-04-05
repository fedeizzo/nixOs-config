{ inputs, ... }:
let
  # Pass flake inputs to overlay so we can use the sources pinned in flake.lock
  # instead of having to keep sha256 hashes in each package for src
  additions = import ../pkgs;
  modifications = self: super: {
    waybar = super.waybar.overrideAttrs (oldAttrs: {
      mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
    });
    # notmuch = super.notmuch.overrideAttrs (oldAttrs: {
    #   version = "0.37";
    # });
  };
in
inputs.nixpkgs.lib.composeManyExtensions [ modifications additions ]
