{ config, pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      restic
      resticprofile
    ];

    file = {
      ".config/resticprofile/profiles.toml".source = ./vps/resticprofile/profiles.toml;
      ".config/resticprofile/.env.dist".source = ./vps/resticprofile/.env.dist;

      "services/scripts" = {
        source = ./vps/services/scripts;
        recursive = true;
        force = true;
      };

      "services/configs".source = ./vps/services/configs;

      "services/docker-compose.yml".source = ./vps/services/docker-compose.yml;
  
      "services/secrets/.keep".text = "";
    };
  };

  # Systemd user service
  systemd.user.services.backup = {
    description = "Restic Backup Wasabi";
    serviceConfig = {
      Type = "simple";
      ExecStart = "~/services/scripts/backup.sh";
    };
  };

  # Systemd timer pour automatiser tous les jours à 2h
  systemd.user.timers.backup = {
    description = "Run backup daily at 2am";
    timerConfig = {
      OnCalendar = "*-*-* 02:00:00";
      Persistent = true;
    };
    wantedBy = [ "timers.target" ];
  };
}
