{ config, lib, pkgs, modulesPath, ... }:

let
  myCustomLayout = pkgs.writeText "xkb-layout" ''
    keycode 104 = Return
  '';
in
{
  # lapbook fix : enter key
  services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${myCustomLayout}";

  boot.extraModprobeConfig = ''
    options snd slots=snd-hda-intel
  '';
}
