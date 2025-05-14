{
  zsh-defer,
  zsh-vi-mode,
  fast-syntax-highlighting,
  zimfw-completion,
  zsh-no-ps2,
  zsh-history-substring-search,
  zsh-autosuggestions,
  git-open,
  ...
}:
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fzf
    # completions and manpage install
    zsh-abbr

    # completions
    zsh-completions
  ];

  programs.zsh = {
    enable = true;
    dotDir = ".zsh"; # Change to .config/zsh ?
    envExtra = ''
      ## misc

      # make word movement commands to stop at every character except:
      # WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
      export WORDCHARS="_*"
    '';

    completionInit = ''
      # Show dotfiles in complete menu
      setopt GLOB_DOTS

      # source ''${zimfw-completion}/init.zsh

      ## zsh-defer

      source ${zsh-defer}/zsh-defer.plugin.zsh
    '';

    initContent = ''

      source ${zsh-no-ps2}/zsh-no-ps2.plugin.zsh

      ## zsh-autosuggestions

      export ZSH_AUTOSUGGEST_MANUAL_REBIND=true
      export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
      export ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=()

      source ${zsh-autosuggestions}/zsh-autosuggestions.zsh

      ## zsh-fsh

      # remove background from pasted text
      # source: https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/25
      # docs: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
      zle_highlight=('paste:fg=white,bold')

      # HACK: set catppuccin theme for zsh-fast-syntax-highlighting
      #FAST_WORK_DIR="\$\{fshTheme}"
      source ${fast-syntax-highlighting}/fast-syntax-highlighting.plugin.zsh

      ## zsh-vi-mode

      function zvm_config() {
        # ZVM_VI_INSERT_ESCAPE_BINDKEY=^X
        ZVM_ESCAPE_KEYTIMEOUT=0
        ZVM_KEYTIMEOUT=0.2
        ZVM_VI_HIGHLIGHT_BACKGROUND=#45475A
        ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4
        ZVM_VI_SURROUND_BINDKEY=s-prefix
        ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
        ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
        ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
      }

      function zvm_after_init() {
        # load_key_bindings

        # HACK: fix race condition where zsh-vi-mode overwrites fzf key-binding
        bindkey -M viins '^R' fzf-history-widget
      }

      source ${zsh-vi-mode}/zsh-vi-mode.plugin.zsh

      ## zsh-history-substring-search

      # https://github.com/zsh-users/zsh-history-substring-search
      # change the behavior of history-substring-search-up
      export HISTORY_SUBSTRING_SEARCH_PREFIXED="1"

      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0.2
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=cyan,fg=16,bold"
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=16,bold"

      source ${zsh-history-substring-search}/zsh-history-substring-search.zsh

      ## zsh-abbr

      function _zsh-abbr-start() {
        export ABBR_DEFAULT_BINDINGS=0

        source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.zsh

        bindkey -M viins " " abbr-expand-and-insert

        if [[ ! -e "$ABBR_USER_ABBREVIATIONS_FILE" || ! -s "$ABBR_USER_ABBREVIATIONS_FILE" ]]; then
          abbr import-aliases --quiet
          abbr erase --quiet sudo
          abbr erase --quiet nv
          abbr erase --quiet nvim
          abbr erase --quiet ls
          abbr erase --quiet la
          abbr erase --quiet lt
          abbr erase --quiet ll
          abbr erase --quiet lla
          abbr erase --quiet z
        fi
      }

      zsh-defer _zsh-abbr-start

      ## snippets

      source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

      ## load our config
      source ''${ZDOTDIR}/zsh_custom


    '';
    enableCompletion = true;
    defaultKeymap = "viins";
    history = {
      ignoreDups = false;
      expireDuplicatesFirst = true;
      extended = true;
      ignoreSpace = true;
      save = 1000000000;
      size = 1000000000;
      # Shares current history file between all sessions as soon as shell closes
      share = true;
      # TODO: add ignorePatterns
    };
    dirHashes = {
      nxc = "/home/nixos";
      nxs = "/nix/store";
      dl = "$HOME/Downloads";
    };
  };

}
