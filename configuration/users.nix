{ pkgs, ... }:
{
  users.users.rumen = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
    shell = pkgs.bash;
    packages = with pkgs; [
      lsd
      bat
      ripgrep
      tldr
      tree
      tmux

      nodejs
      rustup
      go
    ];
  };
}
