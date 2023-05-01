{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  inherit (config.lib) dag;
  cfg = config.mutable;

  cloneIfNotExists = target: repo: branch: ''
    if [ ! -e "${target}" ]; then
      $DRY_RUN_CMD ${pkgs.git}/bin/git clone \
        --branch "${branch}" \
        --recursive \
        -- \
        "${repo}" \
        "${target}"
    fi
  '';

  cloneScripts =
    lib.attrsets.mapAttrsToList
    (_name: attrs: cloneIfNotExists attrs.target attrs.repo attrs.branch)
    cfg.repos;
in {
  options.mutable.enable = mkEnableOption "Stateful Data";

  options.mutable.repos = mkOption {
    type = with types;
      attrsOf (submodule {
        options = {
          branch = mkOption {type = str;};
          repo = mkOption {type = str;};
          target = mkOption {type = path;};
        };
      });
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;

    home.activation.cloneStatefulRepos =
      dag.entryAfter ["installPackages"]
      (builtins.concatStringsSep "\n" cloneScripts);
  };
}
