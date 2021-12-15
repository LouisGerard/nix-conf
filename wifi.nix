{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = import ./config.nix { pkgs = pkgs; };
in
{
  networking.interfaces.wlan0.useDHCP = true;
  networking.wireless.interfaces = [ "wlan0" ];
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = lib.mkIf (cfg ? networks) cfg.networks;
  services.openssh = {
    enable = true;
    ports = [ 8012 ];
    passwordAuthentication = false;
  };
}
