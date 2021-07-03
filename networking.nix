{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    ./wifi.nix
  ];
  networking.extraHosts = ''
    127.0.0.1 dropin.local
    127.0.0.1 web.apps.dropin.local api.dropin.local files.dropin.local
    127.0.0.1 editor.dropin.local studio.dropin.local account.dropin.local
    127.0.0.1 mblocation.local
  '';
}
