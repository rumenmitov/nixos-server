{ config, pkgs, ... }:
{
  # services.nextcloud = {
  #   enable = true;
  #   package = pkgs.nextcloud31;
  #
  #   hostName = "nc.rumen.crabdance.com";
  #   https = true;
  #
  #   settings = {
  #     trusted_proxies = [ "188.245.180.15" ];
  #     wopi_allow_hosts = [ "office.rumen.crabdance.com" ];
  #   };
  #
  #   configureRedis = true;
  #   config.adminpassFile = "/etc/nixos/secrets/nextcloud.env";
  #   config.dbtype = "sqlite";
  #
  #   datadir = "/data/nextcloud";
  # };
  #
  # virtualisation.oci-containers.containers.collabora = {
  #   image = "docker.io/collabora/code";
  #   ports = [ "9980:9980" ];
  #   autoStart = true;
  #   environment = {
  #     domain = "office.rumen.crabdance.com";
  #     extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
  #   };
  # };
}
