{ ... }:
{

  networking = {
  	hostName = "haven"; 
  	networkmanager.enable = true;  

    wg-quick.interfaces = {
        wg0 = {
            address = [ "192.168.10.4/32" ];
            dns = [ "192.168.10.1" ];

            privateKeyFile = "/etc/nixos/secrets/wireguard/private";

            peers = [
            {
                publicKey = "dxJ3jeTLXHahOOC1xCl9dduLMv0C2C+Az6KTNfqGzwo=";
                allowedIPs = [ "0.0.0.0/0" ];

                endpoint = "rumen.crabdance.com:51820";
                persistentKeepalive = 25;
            }
            ];
        };
    };

  	firewall.enable = true;
  	firewall.allowedTCPPorts = [ 443 80 8080 11000 22 51820 28981 11434 ];
  	firewall.allowedUDPPorts = [ 443 80 8080 11000 22 51820 28981 11434 ];
    firewall.checkReversePath = false;
  };
}
