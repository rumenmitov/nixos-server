{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;

    hostName = "nc.rumen.crabdance.com";
    https = true;

    configureRedis = true;
    config.adminpassFile = "/etc/nixos/secrets/nextcloud.env";
    config.dbtype = "sqlite";

    datadir = "/data/nextcloud";
  };
}
