{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.middleEmulation = true;
  services.xserver.libinput.tapping = true; 

  programs.light.enable = true;
}
