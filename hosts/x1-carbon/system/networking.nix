{ hostname, config, ... }:

{
  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    useDHCP = false;
    extraHosts = ''
      192.168.7.1 homelab
    '';
    nameservers = [ "192.168.7.1" "1.1.1.1" ];
    firewall = {
      enable = true;
      checkReversePath = "loose";
      allowedUDPPorts = [ 51821 ];
    };
    wireguard.enable = true;
    networking.wireguard.interfaces = {
      wg0 = {
        ips = [ "192.168.7.3/24" ];
        listenPort = 51821;
        privateKeyFile = "${config.sops.secrets.x1-wireguard-private-key.path}";
        peers = [
          {
            # home-lab
            publicKey = "Ug1P6UzLyQ0BFbrfi0G9KLJBNBs+IOisRn3uiLoR5yU=";
            allowedIPs = [ "192.168.7.1" ];
            endpoint = "vpn.fedeizzo.dev:51821";
            # dynamicEndpointRefreshSeconds = 5;
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };
}
