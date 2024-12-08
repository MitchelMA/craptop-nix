{ config, pkgs, ... }:

{
  users.users.mitchel = {
    isNormalUser = true;
    description = "Mitchel Vonk";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neofetch
      chromium
      discord-ptb
      gcc
      gnumake
      cmake
      boost
      spotify
      signal-desktop
      tailscale
      kitty
      lunarvim
    ];
  };
}

