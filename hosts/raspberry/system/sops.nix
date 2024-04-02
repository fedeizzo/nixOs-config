{ inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops/keys.txt";
    age.generateKey = false;
    age.sshKeyPaths = [ ];
  };

  sops.secrets.laptop-ssh-public-key.sopsFile = ../../../secrets/ssh-public-keys-secrets.yaml;

  sops.secrets.homelab-wireguard-private-key.sopsFile = ../../../secrets/raspberry-secrets.yaml;

  sops.secrets.restic-repository.sopsFile = ../../../secrets/raspberry-secrets.yaml;
  sops.secrets.restic-password.sopsFile = ../../../secrets/raspberry-secrets.yaml;
}
