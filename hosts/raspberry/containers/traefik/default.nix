{ lib, config, kubernetesOrderString, kubernetesSuffixFile, ... }:

with lib;
with builtins;
let
  order = (kubernetesOrderString { intOrder = config.fiCluster.services.traefik.applicationOrder; });
  suffix = (kubernetesSuffixFile { isEnable = config.fiCluster.services.traefik.enable; });
  secretSuffix = (kubernetesSuffixFile {
    isEnable = config.fiCluster.services.traefik.enable;
    isSops = true;
  });
in
{
  config = {
    environment.etc.traefik-role = {
      enable = true;
      source = ./traefik-role.yaml;
      target = "homelab-kubernetes/${order}-01-traefik-role-${suffix}.yaml";
    };
    environment.etc.traefik-account = {
      enable = true;
      source = ./traefik-account.yaml;
      target = "homelab-kubernetes/${order}-02-traefik-account-${suffix}.yaml";
    };
    environment.etc.traefik-configmap = {
      enable = true;
      source = ./traefik-configmap.yaml;
      target = "homelab-kubernetes/${order}-03-traefik-configmap-${suffix}.yaml";
    };
    environment.etc.traefik-secrets = {
      enable = true;
      source = ./traefik-secrets.yaml;
      target = "homelab-kubernetes/${order}-04-traefik-secrets-${secretSuffix}.yaml";
    };
    environment.etc.traefik-deployment = {
      enable = true;
      source = ./traefik-deployment.yaml;
      target = "homelab-kubernetes/${order}-05-traefik-deployment-${suffix}.yaml";
    };
  };
}
