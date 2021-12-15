{ config, lib, pkgs, modulesPath, ... }:

let
  cfg = import ./config.nix { pkgs = pkgs; };
in
{
  hardware.bluetooth.enable = (cfg ? bluetooth && cfg.bluetooth);
}
