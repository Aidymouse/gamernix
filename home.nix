{ config, pkgs, ... }:

{
  # TODO please change the username & home directory to your own
  home.username = "aidan";
  home.homeDirectory = "/home/aidan";
# link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # here is some command line tools I use frequently
    # feel free to add your own or remove some of them

    # programs
    neovim
    lazygit
    #discord
    pavucontrol

    texliveConTeXt
    dropbox

    # utils
    ripgrep # recursively searches directories for a regex pattern
    unzip
    wget
  
    # misc
    cowsay

    # programming
    python3

    # music
	ncspot
  
  ];

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Aidymouse";
    userEmail = "aidymouse4891@gmail.com";
  };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
    	enable = true;
    theme = "robbyrussel";
    };
    shellAliases = {
    	lg = "lazygit";
    };
    
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}

