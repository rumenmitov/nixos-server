{ ... }:
{
  networking.hostName = "rumen-server"; 
  networking.networkmanager.enable = true;  

  networking.firewall.allowedTCPPorts = [ 443 80 ];
  networking.firewall.allowedUDPPorts = [ 443 80 ];
  networking.firewall.enable = true;

  security.acme = {
	acceptTerms = true;
	defaults.email = "rumenmitov@protonmail.com";
	certs."rumenmitov.duckdns.org" = {
		dnsProvider = "duckdns";
		credentialsFile = "/etc/nixos/secrets/duckdns.env";
		group = "nginx";
		extraDomainNames = [ "nextcloud.rumenmitov.duckdns.org" ];
	};
  };

  services.nginx.virtualHosts = {
  	"nextcloud.rumenmitov.duckdns.org" = {
		forceSSL = true;
		useACMEHost = "rumenmitov.duckdns.org";
	};
  };

}
