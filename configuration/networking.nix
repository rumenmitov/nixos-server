{ pkgs, ... }:
{
  security.acme = {
    defaults.email = "rumenmitov@disroot.org";
    acceptTerms = true;

    certs."rumenmitov.duckdns.org" = {
      dnsProvider = "duckdns";
      extraDomainNames = [ "*.rumenmitov.duckdns.org" ];
      environmentFile = "/etc/nixos/secrets/duckdns/creds.ini";
      group = "nginx";
    };
  };

  services = {
    yggdrasil = {
      enable = true;
      persistentKeys = true;

      settings.Peers = [
        "tls://srl.newsdeef.eu:59999" 
          "quic://[2a0b:4142:e9e::2]:65535" ];
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "rumen" ];
      };
    };

    nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;

      virtualHosts = {
        "nc.rumenmitov.duckdns.org" = {
          forceSSL = true;
          useACMEHost = "rumenmitov.duckdns.org";

          locations."/" = {
            proxyPass = "http://127.0.0.1:11000";
            proxyWebsockets = true; 
          };
        };

        "paperless.rumenmitov.duckdns.org" = {
          forceSSL = true;
          useACMEHost = "rumenmitov.duckdns.org";

          locations."/" = {
            proxyPass = "http://127.0.0.1:28981";
          };
        };
      };
    };

    paperless = {
      enable = true;
      passwordFile = "/etc/nixos/secrets/paperless/admin-pass";
      address = "0.0.0.0";
      dataDir = "/data/paperless";
      settings = {
        PAPERLESS_URL = "https://paperless.rumenmitov.duckdns.org";
      };
    };

    prosody = {
      enable = true;

      admins = [ "rumenmitov@rumenmitov.duckdns.org" ];

      ssl.cert = "/var/lib/acme/rumenmitov.duckdns.org/fullchain.pem";
      ssl.key = "/var/lib/acme/rumenmitov.duckdns.org/key.pem";

      virtualHosts."rumenmitov.duckdns.org" = {
        enabled = true;
        domain = "rumenmitov.duckdns.org";
        ssl.cert = "/var/lib/acme/rumenmitov.duckdns.org/fullchain.pem";
        ssl.key = "/var/lib/acme/rumenmitov.duckdns.org/key.pem";
      };

      muc = [ { domain = "conference.rumenmitov.duckdns.org"; } ];

      httpFileShare = {
        domain = "upload.rumenmitov.duckdns.org";
      };

      allowRegistration = true;

      extraModules = [ "admin_shell" ];

      extraConfig = ''
        http_file_share_expire_after = 60
        '';
    };
  };

  networking = {
    hostName = "haven"; 
    networkmanager.enable = true;  

    firewall.enable = true;
    firewall.allowedTCPPorts = [ 443 80 8080 11000 22 28981 5222 5269 5280 5281];
    firewall.allowedUDPPorts = [ 443 80 8080 11000 22 28981 ];
    firewall.checkReversePath = false;
  };
}
