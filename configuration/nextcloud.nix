{ config, pkgs, ... }:
{
  services.nextcloud = {
  	enable = true;
	hostName = "nextcloud.rumenmitov.duckdns.org";
	https = true;
	configureRedis = true;
	package = pkgs.nextcloud28;
	config.adminpassFile = "/etc/nixos/secrets/nextcloud.env";
  };
}
