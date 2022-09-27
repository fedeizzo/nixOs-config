{ pkgs, lib, ... }:

with lib;
let
  enableOption = mkOption {
    type = types.bool;
    default = false;
    description = "Enable service";
  };
  appOrderOption = mkOption {
    type = types.ints.positive;
    default = 1;
    description = "Number used for name of the systemlink, used for kubectl apply order";
  };
in
{
  imports = [ ./traefik ./homer ./authelia ./cloudflare-ddns ];

  options = {
    fiCluster.services = {
      traefik.enable = enableOption;
      traefik.applicationOrder = appOrderOption;
      authelia.enable = enableOption;
      authelia.applicationOrder = appOrderOption;
      cloudflare-ddns.enable = enableOption;
      cloudflare-ddns.applicationOrder = appOrderOption;
      homer.enable = enableOption;
      homer.applicationOrder = appOrderOption;
    };
  };

  config = {
    environment.etc.global-configmap = {
      enable = true;
      source = ./global-configmap.yaml;
      target = "homelab-kubernetes/00-global-configmap.yaml";
    };
  };
}
