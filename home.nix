{ config, pkgs, nixgl, allowed-unfree-packages, lib, ... }:

{
# Home Manager needs a bit of information about you and the paths it should
# manage.
	home.username = "reis";
	home.homeDirectory = "/home/reis";

	imports = [
# TODO: remove when https://github.com/nix-community/home-manager/pull/5355 gets merged:
		(builtins.fetchurl {
		 url = "https://raw.githubusercontent.com/Smona/home-manager/nixgl-compat/modules/misc/nixgl.nix";
		 sha256 = "1krclaga358k3swz2n5wbni1b2r7mcxdzr6d7im6b66w3sbpvnb3";
		 })
	];

  nixGL = {
    packages = nixgl.packages; # you must set this or everything will be a noop
    defaultWrapper = "mesa"; # choose from options
		offloadWrapper = "mesaPrime";
		#installScripts = [ "mesa" "nvidiaPrime" ];
  };


# This value determines the Home Manager release that your configuration is
# compatible with. This helps avoid breakage when a new Home Manager release
# introduces backwards incompatible changes.
#
# You should not change this value, even if you update Home Manager. If you do
# want to update the value, then make sure to first check the Home Manager
# release notes.
	home.stateVersion = "24.05"; # Please read the comment before changing.

# The home.packages option allows you to install Nix packages into your
# environment.
		home.packages = [

    pkgs.nixgl.nixGLIntel # change this to what you need, find options in nixgl repo, use `home-manager switch --impure` when using nvidia or build will fail
# TODO: Explorer setting config options via packages
#    (config.lib.nixGL.wrap pkgs.wezterm)
#    (config.lib.nixGL.wrap pkgs.kitty)

# # It is sometimes useful to fine-tune packages, for example, by applying
# # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/reis/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

	# Wezterm
	programs.wezterm = {
		# when testing, wezterm had graphical bugs on linux mint
		enable = false;
		extraConfig = ''
			local wezterm = require 'wezterm'
			return {
			  tab_bar_at_bottom = true
			}
		'';
	};
	programs.kitty = {
		# shows wrapping a package which requires nixGL and setting config options for it
		package = (config.lib.nixGL.wrap pkgs.kitty);
		enable = true;
	  settings = {
			font_size = 38;
		};
	};
}