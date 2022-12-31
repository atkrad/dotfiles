{ inputs, outputs, lib, config, pkgs, ... }:

{
  services.locate = {
    enable = true;
    locate = pkgs.mlocate;
    interval = "hourly";
    localuser = null;
  };
}
