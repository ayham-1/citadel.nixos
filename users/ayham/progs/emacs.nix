{ config, pkgs, lib, ...}:

{
	imports = [ <home-manager/nixos> ];

	home-manager.users.ayham = { pkgs, ... }: {
		programs.emacs = {
			enable = true;
		};
	};

  environment.systemPackages = with pkgs; [
    clang
    clang-tools
  ];
}
