{ config, pkgs, inputs, ... }: 
# let
# 	yazi-plugins = pkgs.fetchFromGitHub {
# 		owner = "yazi-rs";
# 		repo = "plugins";
# 		rev = "02d18be03812415097e83c6a912924560e4cec6d";
# 		hash = "sha256-1FZ8wcf2VVp6ZWY27vm1dUU1KAL32WwoYbNA/8RUAog=";
# 	};
# in 
{
  # Install CLI tools system-wide
  home.packages = with pkgs; [
    git
    curl
    wget
    fzf
    zoxide
    bat
    eza
    oh-my-posh
    btop-rocm
    fastfetch
    #yazi
    tmux
    tealdeer
    jq
    bc
    fd
    ffmpeg
    ripgrep
    poppler
    ouch
    nix-prefetch
  ] ++ (with inputs.nixpkgs-unstable.legacyPackages.x86_64-linux; [
    yazi
  ]);

  home.file.".config/ohmypost.toml" = {
    source = ./../configs/ohmypost.toml;
  };

  home.file.".config/fzf" = {
    source = ./../configs/fzf;
  };

	# programs.yazi = {
	# 	enable = true;
	# 	enableZshIntegration = true;
	# 	shellWrapperName = "y";
	#
	# 	plugins = {
	# 		chmod = "${yazi-plugins}/chmod.yazi";
	#     no-status = "${yazi-plugins}/no-status.yazi";
	# 		full-border = "${yazi-plugins}/full-border.yazi";
	# 		smart-enter = "${yazi-plugins}/smart-enter.yazi";
	#     # ouch = pkgs.fetchFromGitHub {
	#     #    owner = "ndtoan96";
	#     #    repo = "ouch.yazi";
	#     #    rev = "ce6fb75431b9d0d88efc6ae92e8a8ebb9bc1864a";
	#     #    sha256 = "sha256-oUEUGgeVbljQICB43v9DeEM3XWMAKt3Ll11IcLCS/PA=";
	#     #  };
	# 		mediainfo = pkgs.fetchFromGitHub {
	# 			owner = "boydaihungst";
	# 			repo = "mediainfo.yazi";
	# 			rev = "e2a7cfd750226ce4adc3acc42b4cf75c79fe9f0e";
	# 			sha256 = "sha256-MW0pawBT2S0rOoclCQahiYzLX5JZPuiALCG0ZzOqvM4=";
	# 		};
	# 	};
	#
	# 	# initLua = ''
	# 	# 	-- require("full-border"):setup()
	# 	# 	require("no-status"):setup()
	# 	# '';
	#
	# 	# keymap = {
	# 	# 	manager.prepend_keymap = [
	# 	# 		{
	# 	# 			on = "T";
	# 	# 			run = "plugin max-preview";
	# 	# 			desc = "Maximize or restore the preview pane";
	# 	# 		}
	# 	# 		{
	# 	# 			on = ["c" "m"];
	# 	# 			run = "plugin chmod";
	# 	# 			desc = "Chmod on selected files";
	# 	# 		}
	# 	# 	];
	# 	# };
	# };
  home.file.".config/yazi" = {
    source = ./../configs/yazi;
  };

}
