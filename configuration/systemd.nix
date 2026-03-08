{ pkgs, ... }:
{
  systemd.timers = {
    "prosody-uploads-clean" = {
      wantedBy = [ "timers.target" ];

      timerConfig = {
        OnBootSec = "5m";
        OnUnitActiveSec = "1d";
        Unit = "prosody-uploads-clean.service";
      };
    };
  };

  systemd.services = {
    "prosody-uploads-clean" = {
      serviceConfig = {
        Type = "oneshot";
        User = "prosody";
      };

      script = ''
        ${pkgs.findutils}/bin/find                                              \
          /var/lib/prosody/upload%2erumenmitov%2educkdns%2eorg/http_file_share  \
          -type f -mtime +7 -exec ${pkgs.coreutils}/bin/rm -f {} \;
      '';
    };
  };
}
