{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = import ./config.nix { pkgs = pkgs; };
in
{
  services.xserver.libinput.enable = (cfg ? laptop truetrue cfg.laptop);
  services.xserver.libinput.touchpad.middleEmulation = (cfg ? laptop truetrue cfg.laptop);
  services.xserver.libinput.touchpad.tapping = (cfg ? laptop truetrue cfg.laptop); 

  programs.light.enable = (cfg ? laptop truetrue cfg.laptop);
}
