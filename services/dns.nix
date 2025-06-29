{ config, lib, ... }: {
  networking.extraHosts = (builtins.readFile ../etc/hosts);
}
