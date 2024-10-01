{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ sops age ];
  sops = {
    defaultSopsFile = ../../../secrets/xps-9510-secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops/keys.txt";
    age.generateKey = false;
    age.sshKeyPaths = [ ];
  };

  sops.secrets = {
    borg-home-password = { };
    borg-root-password = { };
    fedeizzo-path = {
      neededForUsers = true;
    };
    root-path = {
      neededForUsers = true;
    };

    xps-9510-wireguard-private-key = { };
  };
}
