{ config, lib, pkgs, modulesPath, ... }:

{
  networking.interfaces.wlan0.useDHCP = true;
  networking.wireless.interfaces = [ "wlan0" ];
  networking.wireless.enable = true;
  networking.wireless.userControlled.enable = true;
  networking.wireless.networks = {
    "SFR-8e10_5GHz" = {
      psk = "QCLPCMF4M2M1";
    };
    "HONOR View20" = {
      psk = "8f8aac332581";
    };
    "Blue Forest - Guests" = {
      psk = "welcometoblueforest";
    };
#    "iPhone de Sylvain" = {
#      psk = "sylvain13021996";
#    };
    "Bbox-F2B1299A" = {
      psk = "291A13D3D57A4C1C335753C93A9AE3";
    };
  };
  services.openssh = {
    enable = true;
    ports = [ 8012 ];
    passwordAuthentication = false;
  };
}
