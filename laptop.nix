{ config, lib, pkgs, modulesPath, ... }:

{
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad.middleEmulation = true;
  services.xserver.libinput.touchpad.tapping = true; 

  programs.light.enable = true;
}
