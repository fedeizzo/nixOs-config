{ config, ... }:

{
  services.restic.backups = {
    backblaze = {
      user = "root";
      initialize = true;
      runCheck = false; # there is already another job with a grafana alert
      # Env file structure
      # B2_ACCOUNT_ID=
      # B2_ACCOUNT_KEY=
      environmentFile = "/root/.restic_backup_env";
      repository = "b2:fedeizzo-homelab-backup";
      # repositoryFile = config.sops.secrets.restic-repository.path;
      passwordFile = config.sops.secrets.restic-password.path;
      createWrapper = true;
      extraBackupArgs = [
        "--compression max"
      ];
      paths = [
        # directories
        "/var/container_envs"
        "/var/volumes/grafana/plugins"
        "/var/volumes/sftpgo"
        "/var/volumes/net_worth_db/"
        "/var/backup/postgresql"
        "${config.services.immich.mediaLocation}"
        ## streaming
        "/var/lib/jellyfin"
        "/var/lib/radarr"
        "/var/lib/sonarr"
        "/var/lib/bazarr"
        "/var/lib/private/prowlarr"
        "/var/lib/private/jellyseerr"
        "/games/jellyfin/torrent/.config"

        # files
        "/var/volumes/promtail/GeoLite2-City.mmdb"
        "/var/volumes/grafana/data/grafana.db"
        "/var/volumes/net_worth_nocodb/noco.db"
        "/var/volumes/traefik/acme.json"
      ];
      pruneOpts = [
        "--keep-last 30" # keep last 30 days
      ];
    };
  };
}
