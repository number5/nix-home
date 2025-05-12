{
  zsh-vim-mode,
  zsh-completions,
  alias-tips,
  zsh-256color,
  fast-syntax-highlighting,
  zimfw-completion,
  zsh-no-ps2,
  zsh-history-substring-search,
  git-open,
  ...
}:
{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;

    # Use built-in Home-Manager functionality for these plugins
    autosuggestion.enable = true;
    enableCompletion = true;

    # Custom plugins using flake inputs
    plugins = [
      {
        name = "zsh-vim-mode";
        src = zsh-vim-mode;
      }
      {
        name = "zsh-completions";
        src = zsh-completions;
      }
      {
        name = "alias-tips";
        src = alias-tips;
      }
      {
        name = "zsh-256color";
        src = zsh-256color;
      }
      {
        name = "fast-syntax-highlighting";
        src = fast-syntax-highlighting;
      }
      {
        name = "zimfw-completion";
        src = zimfw-completion;
      }
      {
        name = "zsh-no-ps2";
        src = zsh-no-ps2;
      }
      {
        name = "zsh-history-substring-search";
        src = zsh-history-substring-search;
      }
    ];

    # Custom initialization for plugins that need special handling
    initContent = ''
      # Git open plugin
      source ${git-open}/git-open

      # Any additional custom configurations can go here
      source $ZDOTDIR/zshrc.link
    '';

    # Set options equivalent to your previous Sheldon setup
    defaultKeymap = "viins"; # For vim-mode

    # Set environment variables if needed
    sessionVariables = {
      # Add any environment variables you need
    };
  };

  # Installing additional packages that plugins might depend on
  home.packages = with pkgs; [
    fzf
    git
    # Add any other packages your setup depends on
  ];
}
